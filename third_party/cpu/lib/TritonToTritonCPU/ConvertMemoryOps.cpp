#include "TypeConverter.h"

#include "cpu/include/Analysis/TensorPtrShapeInfo.h"
#include "cpu/include/TritonToTritonCPU/Passes.h"

#include "mlir/Analysis/DataFlowFramework.h"
#include "mlir/Conversion/LLVMCommon/TypeConverter.h"
#include "mlir/Dialect/ControlFlow/IR/ControlFlowOps.h"
#include "mlir/Dialect/Index/IR/IndexDialect.h"
#include "mlir/Dialect/Index/IR/IndexOps.h"
#include "mlir/Dialect/MemRef/IR/MemRef.h"
#include "mlir/Dialect/Utils/IndexingUtils.h"
#include "mlir/Dialect/Vector/IR/VectorOps.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Transforms/GreedyPatternRewriteDriver.h"

#include "triton/Analysis/Allocation.h"
#include "triton/Analysis/AxisInfo.h"
#include "triton/Analysis/Membar.h"
#include "triton/Dialect/Triton/IR/Dialect.h"
#include "triton/Dialect/TritonCPU/IR/Dialect.h"

namespace mlir {
namespace triton {
#define GEN_PASS_DEF_CONVERTMEMORYOPS
#include "cpu/include/TritonToTritonCPU/Passes.h.inc"
} // namespace triton
} // namespace mlir

using namespace mlir;
using namespace mlir::triton;
using namespace mlir::triton::cpu;

namespace {

template <typename OpT>
struct MemoryOpConversion : public OpConversionPattern<OpT> {
  using OpConversionPattern<OpT>::OpConversionPattern;
  using OpConversionPattern<OpT>::getContext;
  using OpConversionPattern<OpT>::getTypeConverter;

  MemoryOpConversion(ModuleAxisInfoAnalysis &axisInfoAnalysis,
                     ModuleTensorPtrShapeInfoAnalysis &shapeInfoAnalysis,
                     TypeConverter &typeConverter, MLIRContext *context)
      : OpConversionPattern<OpT>(typeConverter, context),
        axisAnalysis(axisInfoAnalysis), shapeAnalysis(shapeInfoAnalysis) {}

  Value extractScalarPointer(Location loc, Value ptrs,
                             ArrayRef<int64_t> indices,
                             ConversionPatternRewriter &rewriter) const {
    // If we build a vector of pointers and the extract a pointer from it, then
    // compiler doesn't always optimize it to a simple scalar pointer
    // computation. Here we try to follow a data flow of the tensor to rebuild a
    // scalar pointer for more efficient resulting code.
    if (canComputeScalarValue(ptrs))
      return computeScalarValue(ptrs, indices, rewriter);

    // Fall back to a scalar pointer extraction from the vector.
    Value ptr = rewriter.create<vector::ExtractOp>(
        loc, rewriter.getRemappedValue(ptrs), indices);
    auto ptrTy = dyn_cast<RankedTensorType>(ptrs.getType()).getElementType();
    ptr = rewriter.create<IntToPtrOp>(loc, ptrTy, ptr);
    return ptr;
  }

  bool canComputeScalarValue(Value vals) const {
    if (auto def = vals.getDefiningOp<AddPtrOp>()) {
      return canComputeScalarValue(def.getPtr()) &&
             canComputeScalarValue(def.getOffset());
    }

    if (auto def = vals.getDefiningOp<arith::AddIOp>()) {
      return canComputeScalarValue(def.getLhs()) &&
             canComputeScalarValue(def.getRhs());
    }

    if (vals.getDefiningOp<SplatOp>() || vals.getDefiningOp<MakeRangeOp>()) {
      return true;
    }

    return false;
  }

  Value computeScalarValue(Value vals, ArrayRef<int64_t> indices,
                           ConversionPatternRewriter &rewriter) const {
    if (auto def = vals.getDefiningOp<AddPtrOp>()) {
      Value ptr = computeScalarValue(def.getPtr(), indices, rewriter);
      Value offs = computeScalarValue(def.getOffset(), indices, rewriter);
      return rewriter.create<AddPtrOp>(def.getLoc(), ptr.getType(), ptr, offs);
    }

    if (auto def = vals.getDefiningOp<arith::AddIOp>()) {
      Value lhs = computeScalarValue(def.getLhs(), indices, rewriter);
      Value rhs = computeScalarValue(def.getRhs(), indices, rewriter);
      return rewriter.create<arith::AddIOp>(def.getLoc(), lhs.getType(), lhs,
                                            rhs);
    }

    if (auto def = vals.getDefiningOp<SplatOp>()) {
      return def.getSrc();
    }

    if (auto def = vals.getDefiningOp<MakeRangeOp>()) {
      int32_t start = static_cast<int32_t>(def.getStart());
      assert(indices.size() == 1);
      Type elemTy = cast<RankedTensorType>(def.getType()).getElementType();
      return rewriter.create<arith::ConstantOp>(
          def.getLoc(), elemTy,
          rewriter.getIntegerAttr(elemTy, start + indices[0]));
    }

    return Value();
  }

  Value extractMemRef(Location loc, Value ptr,
                      ConversionPatternRewriter &rewriter) const {
    auto tensorTy = dyn_cast<RankedTensorType>(
        dyn_cast<PointerType>(ptr.getType()).getPointeeType());
    auto elemTy = tensorTy.getElementType();
    auto shapeInfo = shapeAnalysis.getPtrShapeInfo(ptr);
    Type memRefTy;
    if (shapeInfo && shapeInfo->getRank() > 0) {
      auto layout =
          StridedLayoutAttr::get(getContext(), 0, shapeInfo->getStrides());
      memRefTy = MemRefType::get(shapeInfo->getShape(), elemTy, layout);
    } else {
      SmallVector<int64_t> dynVals(tensorTy.getRank(), ShapedType::kDynamic);
      auto layout = StridedLayoutAttr::get(getContext(), 0, dynVals);
      memRefTy = MemRefType::get(dynVals, elemTy, layout);
    }
    return rewriter.create<ExtractMemRefOp>(loc, memRefTy, ptr);
  }

  Value convertOtherVal(triton::LoadOp loadOp,
                        ConversionPatternRewriter &rewriter) const {
    if (loadOp.getOther())
      return rewriter.getRemappedValue(loadOp.getOther());

    auto resTy =
        dyn_cast<VectorType>(getTypeConverter()->convertType(loadOp.getType()));
    return rewriter.create<arith::ConstantOp>(
        loadOp.getLoc(), resTy,
        SplatElementsAttr::get(resTy,
                               rewriter.getZeroAttr(resTy.getElementType())));
  }

protected:
  ModuleAxisInfoAnalysis &axisAnalysis;
  ModuleTensorPtrShapeInfoAnalysis &shapeAnalysis;
};

struct LoadOpConversion : public MemoryOpConversion<triton::LoadOp> {
  using MemoryOpConversion::MemoryOpConversion;

  static Value
  getPaddingValue(Location loc, Type type,
                  const std::optional<triton::PaddingOption> &padding,
                  ConversionPatternRewriter &rewriter) {
    auto padding_option = padding.value_or(PaddingOption::PAD_ZERO);

    TypedAttr attr;
    switch (padding_option) {
    case PaddingOption::PAD_ZERO:
      attr = rewriter.getZeroAttr(type);
      break;
    case PaddingOption::PAD_NAN:
      assert(!type.isIntOrIndex());
      auto apNaN =
          llvm::APFloat::getNaN(cast<FloatType>(type).getFloatSemantics());
      attr = FloatAttr::get(type, apNaN);
      break;
    }

    return rewriter.create<arith::ConstantOp>(loc, attr);
  }

  LogicalResult
  matchAndRewrite(triton::LoadOp loadOp, OpAdaptor adaptor,
                  ConversionPatternRewriter &rewriter) const override {
    auto loc = loadOp.getLoc();
    auto mask = loadOp.getMask();
    auto ptr = loadOp.getPtr();
    auto boundaryChecks = loadOp.getBoundaryCheck();

    if (!triton::isTensorPointerType(ptr.getType())) {
      auto axisInfo = axisAnalysis.getAxisInfo(ptr);
      if (axisInfo) {
        return lowerUsingAxisInfo(axisInfo, loadOp, rewriter);
      }
      return lowerToScalarLoads(loadOp, rewriter);
    }

    // TODO: support masks.
    if (mask) {
      llvm_unreachable("unsupported load op");
    }

    auto memRef = extractMemRef(loc, ptr, rewriter);
    auto rank = dyn_cast<MemRefType>(memRef.getType()).getRank();
    auto resTy = dyn_cast<VectorType>(
        getTypeConverter()->convertType(loadOp.getResult().getType()));
    auto indices = rewriter.create<ExtractIndicesOp>(loc, ptr).getResults();
    SmallVector<bool, 4> inBounds(rank, true);
    for (auto dim : boundaryChecks) {
      inBounds[dim] = false;
    }
    Value padding = getPaddingValue(loc, resTy.getElementType(),
                                    loadOp.getPadding(), rewriter);
    auto vecRead = rewriter.create<vector::TransferReadOp>(
        loc, resTy, memRef, indices, padding, inBounds);
    rewriter.replaceOp(loadOp, vecRead);
    return success();
  }

  LogicalResult lowerUsingAxisInfo(AxisInfo *axisInfo, triton::LoadOp loadOp,
                                   ConversionPatternRewriter &rewriter) const {
    // This is an experimental code that covers only a simple case of axis info
    // usage to demostrate load by tensor of pointers transformation into vector
    // loads.
    // TODO: Support more cases.
    // TODO: Make separate pass to produce block pointer stores?
    auto loc = loadOp.getLoc();
    auto vecTy =
        dyn_cast<VectorType>(getTypeConverter()->convertType(loadOp.getType()));
    auto shape = vecTy.getShape();
    auto contiguity = axisInfo->getContiguity();
    if (shape.back() > 1 && shape.back() == contiguity.back()) {
      auto strides = computeStrides(shape);
      int64_t numElems = vecTy.getNumElements();
      Type subVecTy = VectorType::get(shape.back(), vecTy.getElementType());
      Type memRefTy = MemRefType::get(shape.back(), vecTy.getElementType());
      Value mask = loadOp.getMask()
                       ? rewriter.getRemappedValue(loadOp.getMask())
                       : nullptr;
      Value zeroIdx = rewriter.create<arith::ConstantIndexOp>(loc, 0);
      Value defaultVal = convertOtherVal(loadOp, rewriter);
      Value res = defaultVal;
      for (int64_t idx = 0; idx < numElems; idx += shape.back()) {
        auto indices = delinearize(idx, strides);
        SmallVector<int64_t> subIndices(indices.begin(),
                                        indices.begin() + indices.size() - 1);
        auto ptr =
            extractScalarPointer(loc, loadOp.getPtr(), indices, rewriter);
        Value memRef =
            rewriter.create<triton::cpu::PtrToMemRefOp>(loc, memRefTy, ptr);
        Value vec;
        if (mask) {
          Value subMask = mask;
          Value passThru = defaultVal;
          if (shape.size() > 1) {
            subMask = rewriter.create<vector::ExtractOp>(loc, mask, subIndices);
            passThru =
                rewriter.create<vector::ExtractOp>(loc, defaultVal, subIndices);
          }
          vec = rewriter.create<vector::MaskedLoadOp>(
              loc, subVecTy, memRef, zeroIdx, subMask, passThru);
        } else {
          vec = rewriter.create<vector::LoadOp>(loc, subVecTy, memRef, zeroIdx);
        }

        if (shape.size() > 1) {
          res = rewriter.create<vector::InsertOp>(loc, vec, res, subIndices);
        } else {
          res = vec;
        }
      }

      rewriter.replaceOp(loadOp, res);
      return success();
    }

    return lowerToScalarLoads(loadOp, rewriter);
  }

  LogicalResult lowerToScalarLoads(triton::LoadOp loadOp,
                                   ConversionPatternRewriter &rewriter) const {
    // Scalar loads and boundary checks are not expected.
    assert(loadOp.getBoundaryCheck().empty());
    assert(isa<RankedTensorType>(loadOp.getType()));

    auto loc = loadOp.getLoc();
    auto vecTy =
        dyn_cast<VectorType>(getTypeConverter()->convertType(loadOp.getType()));
    auto ptrs = rewriter.getRemappedValue(loadOp.getPtr());
    auto mask = loadOp.getMask() ? rewriter.getRemappedValue(loadOp.getMask())
                                 : nullptr;
    auto ptrTy =
        dyn_cast<RankedTensorType>(loadOp.getPtr().getType()).getElementType();
    auto cache = loadOp.getCache();
    auto evict = loadOp.getEvict();
    auto isVolatile = loadOp.getIsVolatile();

    auto loadOne = [=, &rewriter](ArrayRef<int64_t> indices, Value dst) {
      Value ptr = rewriter.create<vector::ExtractOp>(loc, ptrs, indices);
      ptr = rewriter.create<IntToPtrOp>(loc, ptrTy, ptr);
      Value val =
          rewriter.create<triton::LoadOp>(loc, ptr, cache, evict, isVolatile);
      return rewriter.create<vector::InsertOp>(loc, val, dst, indices);
    };

    Value dst = convertOtherVal(loadOp, rewriter);
    int64_t numElems = vecTy.getNumElements();
    auto strides = computeStrides(vecTy.getShape());
    for (auto idx = 0; idx < numElems; ++idx) {
      auto indices = delinearize(idx, strides);
      if (!mask) {
        dst = loadOne(indices, dst);
        continue;
      }
      // Create a conditional block for load if there is a mask.
      auto predicate = rewriter.create<vector::ExtractOp>(loc, mask, indices);
      auto ifOp = rewriter.create<scf::IfOp>(
          loc, predicate,
          [&](OpBuilder &builder, Location loc) {
            auto result = loadOne(indices, dst).getResult();
            rewriter.create<scf::YieldOp>(loc, result);
          },
          [&](OpBuilder &builder, Location loc) {
            rewriter.create<scf::YieldOp>(loc, dst);
          });
      dst = ifOp.getResult(0);
    }

    rewriter.replaceOp(loadOp, dst);

    return success();
  }
};

struct StoreOpConversion : public MemoryOpConversion<triton::StoreOp> {
  using MemoryOpConversion::MemoryOpConversion;

  LogicalResult
  matchAndRewrite(triton::StoreOp storeOp, OpAdaptor adaptor,
                  ConversionPatternRewriter &rewriter) const override {
    auto loc = storeOp.getLoc();
    auto mask = storeOp.getMask();
    auto ptr = storeOp.getPtr();
    auto boundaryChecks = storeOp.getBoundaryCheck();

    if (!triton::isTensorPointerType(ptr.getType())) {
      auto axisInfo = axisAnalysis.getAxisInfo(ptr);
      if (axisInfo) {
        return lowerUsingAxisInfo(axisInfo, storeOp, rewriter);
      }
      return lowerToScalarStores(storeOp, rewriter);
    }

    // TODO: support masks.
    if (mask) {
      llvm_unreachable("unsupported store op");
    }

    auto value = rewriter.getRemappedValue(storeOp.getValue());
    auto memRef = extractMemRef(loc, ptr, rewriter);
    auto rank = dyn_cast<MemRefType>(memRef.getType()).getRank();
    auto indices = rewriter.create<ExtractIndicesOp>(loc, ptr).getResults();
    SmallVector<bool, 4> inBounds(rank, true);
    for (auto dim : boundaryChecks) {
      inBounds[dim] = false;
    }
    auto vecWrite = rewriter.create<vector::TransferWriteOp>(loc, value, memRef,
                                                             indices, inBounds);
    rewriter.replaceOp(storeOp, vecWrite);
    return success();
  }

  LogicalResult lowerUsingAxisInfo(AxisInfo *axisInfo, triton::StoreOp storeOp,
                                   ConversionPatternRewriter &rewriter) const {
    // This is an experimental code that covers only a simple case of axis info
    // usage to demostrate load by tensor of pointers transformation into vector
    // loads.
    // TODO: Support more cases.
    // TODO: Make separate pass to produce block pointer stores instead?
    auto loc = storeOp.getLoc();
    auto vals = rewriter.getRemappedValue(storeOp.getValue());
    auto vecTy = dyn_cast<VectorType>(vals.getType());
    auto shape = vecTy.getShape();
    auto contiguity = axisInfo->getContiguity();
    if (shape.back() > 1 && shape.back() == contiguity.back()) {
      auto strides = computeStrides(shape);
      int64_t numElems = vecTy.getNumElements();
      Type memRefTy = MemRefType::get(shape.back(), vecTy.getElementType());
      Value mask = storeOp.getMask()
                       ? rewriter.getRemappedValue(storeOp.getMask())
                       : nullptr;
      Value zeroIdx = rewriter.create<arith::ConstantIndexOp>(loc, 0);
      auto vals = rewriter.getRemappedValue(storeOp.getValue());
      for (int64_t idx = 0; idx < numElems; idx += shape.back()) {
        auto indices = delinearize(idx, strides);
        auto ptr =
            extractScalarPointer(loc, storeOp.getPtr(), indices, rewriter);
        Value memRef =
            rewriter.create<triton::cpu::PtrToMemRefOp>(loc, memRefTy, ptr);
        indices.pop_back();
        auto val = rewriter.create<vector::ExtractOp>(loc, vals, indices);

        if (mask) {
          Value subMask = mask;
          if (shape.size() > 1) {
            SmallVector<int64_t> subIndices = indices;
            subIndices.pop_back();
            subMask = rewriter.create<vector::ExtractOp>(loc, mask, indices);
          }
          rewriter.create<vector::MaskedStoreOp>(loc, memRef, zeroIdx, subMask,
                                                 val);
        } else {
          rewriter.create<vector::StoreOp>(loc, val, memRef, zeroIdx);
        }
      }

      rewriter.eraseOp(storeOp);
      return success();
    }

    return lowerToScalarStores(storeOp, rewriter);
  }

  LogicalResult lowerToScalarStores(triton::StoreOp storeOp,
                                    ConversionPatternRewriter &rewriter) const {
    // Scalar stores and boundary checks are not expected.
    assert(storeOp.getBoundaryCheck().empty());
    assert(isa<RankedTensorType>(storeOp.getValue().getType()));

    auto loc = storeOp.getLoc();
    auto ptrs = rewriter.getRemappedValue(storeOp.getPtr());
    auto mask = storeOp.getMask() ? rewriter.getRemappedValue(storeOp.getMask())
                                  : nullptr;
    auto vals = rewriter.getRemappedValue(storeOp.getValue());
    auto tensorTy = dyn_cast<RankedTensorType>(storeOp.getPtr().getType());
    auto ptrTy = tensorTy.getElementType();
    auto cache = storeOp.getCache();
    auto evict = storeOp.getEvict();

    auto storeOne = [=, &rewriter](ArrayRef<int64_t> indices) {
      Value ptr = rewriter.create<vector::ExtractOp>(loc, ptrs, indices);
      ptr = rewriter.create<IntToPtrOp>(loc, ptrTy, ptr);
      Value val = rewriter.create<vector::ExtractOp>(loc, vals, indices);
      rewriter.create<triton::StoreOp>(loc, ptr, val, cache, evict);
    };

    int64_t numElems = tensorTy.getNumElements();
    auto strides = computeStrides(tensorTy.getShape());
    for (auto idx = 0; idx < numElems; ++idx) {
      auto indices = delinearize(idx, strides);
      if (!mask) {
        storeOne(indices);
        continue;
      }
      // Create a conditional block for store if there is a mask.
      auto predicate = rewriter.create<vector::ExtractOp>(loc, mask, indices);
      rewriter.create<scf::IfOp>(loc, predicate,
                                 [&](OpBuilder &builder, Location loc) {
                                   storeOne(indices);
                                   rewriter.create<scf::YieldOp>(loc);
                                 });
    }

    rewriter.eraseOp(storeOp);

    return success();
  }
};

class MemoryOpConversionTarget : public ConversionTarget {
public:
  explicit MemoryOpConversionTarget(MLIRContext &ctx) : ConversionTarget(ctx) {
    addLegalDialect<vector::VectorDialect>();
    addLegalDialect<arith::ArithDialect>();
    addLegalDialect<scf::SCFDialect>();
    addLegalDialect<TritonDialect>();
    addLegalDialect<TritonCPUDialect>();
    addLegalOp<mlir::UnrealizedConversionCastOp>();

    // Allow only scalar loads and stores.
    addDynamicallyLegalOp<triton::LoadOp>([](triton::LoadOp loadOp) {
      return loadOp.getType().isIntOrIndexOrFloat();
    });
    addDynamicallyLegalOp<triton::StoreOp>([](triton::StoreOp storeOp) {
      return storeOp.getValue().getType().isIntOrIndexOrFloat();
    });
  }
};

struct ConvertMemoryOps
    : public triton::impl::ConvertMemoryOpsBase<ConvertMemoryOps> {
  using ConvertMemoryOpsBase::ConvertMemoryOpsBase;

  ConvertMemoryOps() : ConvertMemoryOpsBase() {}

  void runOnOperation() override {
    MLIRContext *context = &getContext();
    ModuleOp mod = getOperation();

    ModuleAxisInfoAnalysis axisInfoAnalysis(mod);
    ModuleTensorPtrShapeInfoAnalysis shapeInfoAnalysis(mod);
    MemoryOpConversionTarget convTarget(*context);
    TritonToTritonCPUTypeConverter pointerConverter;
    RewritePatternSet patterns(context);
    patterns.add<LoadOpConversion>(axisInfoAnalysis, shapeInfoAnalysis,
                                   pointerConverter, context);
    patterns.add<StoreOpConversion>(axisInfoAnalysis, shapeInfoAnalysis,
                                    pointerConverter, context);

    if (failed(applyPartialConversion(mod, convTarget, std::move(patterns))))
      return signalPassFailure();
  }
};

} // anonymous namespace

namespace mlir {
namespace triton {
namespace cpu {

std::unique_ptr<OperationPass<ModuleOp>> createConvertMemoryOps() {
  return std::make_unique<ConvertMemoryOps>();
}

} // namespace cpu
} // namespace triton
} // namespace mlir
