#include "ConvertDotCommon.h"

#include "cpu/include/TritonCPUTransforms/Passes.h"

#include "cpu/include/Analysis/TensorPtrShapeInfo.h"
#include "mlir/Dialect/Index/IR/IndexDialect.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Transforms/GreedyPatternRewriteDriver.h"

#include <iostream>
#include <tuple>
#include <utility>

namespace mlir {
namespace triton {
namespace cpu {
#define GEN_PASS_DEF_CONVERTDOTOPTOUKERNELOPS
#include "cpu/include/TritonCPUTransforms/Passes.h.inc"
} // namespace cpu
} // namespace triton
} // namespace mlir

#define DBGS() (llvm::dbgs() << "[" DEBUG_TYPE "]: ")
#define LDBG(X) LLVM_DEBUG(DBGS() << X << "\n")

using namespace mlir;
using namespace mlir::triton;
using namespace mlir::triton::cpu;

namespace {

#if defined(ONEDNN_AVAILABLE)
#include "oneapi/dnnl/dnnl_config.h"
#include "oneapi/dnnl/dnnl_ukernel.hpp"
#endif

#if defined(DNNL_EXPERIMENTAL_UKERNEL)
static inline dnnl::memory::data_type getDnnlDataTypeVal(Type ty) {
  ty = getElementTypeOrSelf(ty);
  if (ty.isF32())
    return dnnl::memory::data_type::f32;
  if (ty.isF64())
    return dnnl::memory::data_type::f64;
  if (ty.isBF16())
    return dnnl::memory::data_type::bf16;
  if (ty.isF16())
    return dnnl::memory::data_type::f16;
  llvm_unreachable("Unexpected type for conversion to DNNL type.");
}
#endif

bool isOneDNNPackingExpected(Type dtypeA, Type dtypeB) {
#if !defined(DNNL_EXPERIMENTAL_UKERNEL)
  // WA for passing lit tests without OneDNN.
  return false;
  llvm_unreachable("Using OneDNN without librabry.");
#else
  return dnnl::ukernel::brgemm::get_B_pack_type(getDnnlDataTypeVal(dtypeA),
                                                getDnnlDataTypeVal(dtypeB)) ==
         dnnl::ukernel::pack_type::pack32;
#endif
}

bool isPackingExpected(Type dtypeA, Type dtypeB, Ukernels ukernel) {
  if (ukernel == Ukernels::OneDNN)
    return isOneDNNPackingExpected(dtypeA, dtypeB);
  return false;
}

// This structure is used to hold candidates for conversion to ukernel calls.
struct DotOpCandidate {
  // Operation to convert.
  triton::cpu::DotOp op;

  // Block sizes.
  int64_t blockM;
  int64_t blockN;
  int64_t blockK;
  // If accumulator is updated in a loop, then this flag indicates if we
  // should keep it in tiles the whole loop and move back to vectors only
  // after the loop.
  bool isAccLoopCarried = false;
  bool canFuseLoop = false;

  // If input data is available in memory then input buffers hold it.
  MemBuffer lhsBuf;
  MemBuffer rhsBuf;
};

bool isLoopInvariant(SmallVector<Value> vals, LoopLikeOpInterface loopLike) {
  for (Value val : vals) {
    LDBG("Checking value for invariance: " << val);
    if (!loopLike.isDefinedOutsideOfLoop(val)) {
      LDBG("  Not invariant");
      return false;
    }
  }
  return true;
}

bool checkElemTypesOneDNN(Type lhsElemTy, Type rhsElemTy, Type accElemTy,
                          Type resElemTy) {
  // Integer types are not supported yet.
  if (lhsElemTy.isInteger() || rhsElemTy.isInteger() || resElemTy.isInteger()) {
    // Should be also lhs = [u8, s8] rhs = [u8, s8] res = [s32]
    // but there is an assertion if res not f32 TODO - verify.
    LDBG("Drop candidate. Integer types are not supported.");
    return false;
  }

  // FP8 input is not supported yet.
  if (lhsElemTy.getIntOrFloatBitWidth() == 8 ||
      rhsElemTy.getIntOrFloatBitWidth() == 8) {
    LDBG("Drop candidate. FP8 input is not supported.");
    return false;
  }

  // FP64 result is not supported.
  if (accElemTy.getIntOrFloatBitWidth() == 64 ||
      resElemTy.getIntOrFloatBitWidth() == 64) {
    LDBG("Drop candidate. FP64 result is not supported.");
    return false;
  }

  return true;
}

bool checkElemTypesXSMM(Type lhsElemTy, Type rhsElemTy, Type accElemTy,
                        Type resElemTy) {
  // Integer types are not supported yet.
  if (lhsElemTy.isInteger() || rhsElemTy.isInteger() || resElemTy.isInteger()) {
    // TODO: Add integer support.
    LDBG("Drop candidate. Integer types are not supported.");
    return false;
  }

  if (accElemTy != resElemTy) {
    // Constrain the two for simplicity.
    // Lowering assumes XSMM can
    // TODO: Relax check when dtypeAcc is available in ukernel ops.
    LDBG("Drop candidate. Expect same accumulation and result type.");
    return false;
  }

  if (lhsElemTy != rhsElemTy) {
    LDBG("Drop candidate. Mixed type input is not supported");
    return false;
  }

  // FP8 input is not supported yet.
  // TODO: Enable 8-bit support
  if (lhsElemTy.getIntOrFloatBitWidth() == 8 ||
      rhsElemTy.getIntOrFloatBitWidth() == 8) {
    LDBG("Drop candidate. FP8 input is not supported.");
    return false;
  }

  // Int64 and FP64 result are not supported.
  // TODO: Enable 64-bit support
  if (accElemTy.getIntOrFloatBitWidth() == 64 ||
      resElemTy.getIntOrFloatBitWidth() == 64) {
    LDBG("Drop candidate. 64-bit result is not supported.");
    return false;
  }

  return true;
}

bool checkElemTypes(Type lhsElemTy, Type rhsElemTy, Type accElemTy,
                    Type resElemTy, Ukernels ukernel) {
  if (ukernel == Ukernels::OneDNN)
    return checkElemTypesOneDNN(lhsElemTy, rhsElemTy, accElemTy, resElemTy);
  if (ukernel == Ukernels::XSMM)
    return checkElemTypesXSMM(lhsElemTy, rhsElemTy, accElemTy, resElemTy);
  return false;
}

bool checkInputShapesOneDNN(VectorType lhsTy, VectorType resTy,
                            DotOpCandidate &candidate) {
  if (lhsTy.getRank() != 2)
    return false;

  // Todo enable types that require transform (bfloat16, fp16, int8) to have
  // block-size (blockN) more than 64 (OneDNN ukernels transform issue)
  if (candidate.blockN > 64 && lhsTy.getElementTypeBitWidth() < 32) {
    LDBG("Drop candidate. BlockN > 64 && type requires transform. (btw < 32)");
    return false;
  }

  return true;
}

bool checkInputShapesXSMM(VectorType lhsTy, VectorType resTy,
                          DotOpCandidate &candidate) {
  return lhsTy.getRank() == 2;
}

bool checkInputShapes(VectorType lhsTy, VectorType resTy,
                      DotOpCandidate &candidate, Ukernels ukernel) {
  candidate.blockM = resTy.getDimSize(0);
  candidate.blockN = resTy.getDimSize(1);
  candidate.blockK = lhsTy.getDimSize(1);

  if (ukernel == Ukernels::OneDNN)
    return checkInputShapesOneDNN(lhsTy, resTy, candidate);
  if (ukernel == Ukernels::XSMM)
    return checkInputShapesXSMM(lhsTy, resTy, candidate);
  return false;
}

// Check if specified ContractionOp can be lowered to a ukernel operations.
// If conversion is possible, then true is returned and candidate
// structure is filled with detailed transformation info.
bool isUkernelsCandidate(triton::cpu::DotOp op, DotOpCandidate &candidate,
                         Ukernels ukernel) {
  VectorType lhsTy = cast<VectorType>(op.getA().getType());
  VectorType rhsTy = cast<VectorType>(op.getB().getType());
  VectorType accTy = cast<VectorType>(op.getC().getType());
  VectorType resTy = cast<VectorType>(op.getType());

  LDBG("Considering candidate op: " << op);

  if (accTy.getRank() != 2) {
    LDBG("  Drop candidate. Only 2D case is supported.");
    return false;
  }

  // Check input/output types.
  if (!checkElemTypes(lhsTy.getElementType(), rhsTy.getElementType(),
                      accTy.getElementType(), resTy.getElementType(), ukernel))
    return false;

  // Check input shapes.
  if (!checkInputShapes(lhsTy, resTy, candidate, ukernel))
    return false;

  bool allowVnni =
      isPackingExpected(op.getA().getType(), op.getB().getType(), ukernel);

  candidate.op = op;
  candidate.isAccLoopCarried = isLoopCarriedAcc(op.getC());
  candidate.lhsBuf = findInputBuffer(op.getA(), /*allowTransposed*/ false,
                                     /*allowVnni*/ false);
  candidate.rhsBuf = findInputBuffer(op.getB(), /*allowTransposed*/ false,
                                     /*allowVnni*/ allowVnni);

  // Check if we can fuse dot op loop into a single brgemm call.
  if (candidate.isAccLoopCarried && !candidate.lhsBuf.step.empty() &&
      !candidate.rhsBuf.step.empty()) {
    SmallVector<Value> valsToCheckInvariance;
    valsToCheckInvariance.append(candidate.lhsBuf.step);
    valsToCheckInvariance.append(candidate.rhsBuf.step);

    auto forOp = dyn_cast<scf::ForOp>(op->getParentOp());
    candidate.canFuseLoop = isLoopInvariant(valsToCheckInvariance, forOp);
  }
  return true;
}

Value addMemrefSubView(PatternRewriter &rewriter, Location loc,
                       VectorType &vecTy, ValueRange indices, Value memRef) {
  LDBG("  Reusing the original memref for a buffer: " << memRef);
  auto ctx = rewriter.getContext();
  auto memrefTy = cast<MemRefType>(memRef.getType());

  bool allZero = llvm::all_of(indices, isZeroIndex);
  if (allZero && memrefTy.getShape() == vecTy.getShape()) {
    LDBG("  Skipping subveiw creation as original MemRef size is whole Vector: "
         "\n    memref - "
         << memRef << "\n       vec - " << vecTy
         << "\n   is all Indices are zero - " << (allZero ? "true" : "false"));
    return memRef;
  }
  SmallVector<int64_t> strides(memrefTy.getRank(), 1);
  SmallVector<int64_t> shape(memrefTy.getRank(), 1);
  // we will add 1 to leading dimensions of shapes or just copy existing vector
  // shape.
  int64_t start_ind = memrefTy.getRank() - vecTy.getRank();
  for (auto ind = 0; ind < vecTy.getRank(); ind++, start_ind++) {
    shape[start_ind] = vecTy.getShape()[ind];
  }

  Value memRef_view = rewriter.create<memref::SubViewOp>(
      loc, memRef, getAsOpFoldResult(indices),
      getAsIndexOpFoldResult(ctx, shape), getAsIndexOpFoldResult(ctx, strides));
  LDBG("Adding subview with type: " << memRef_view);
  return memRef_view;
}

std::pair<Value, SmallVector<Value>>
extractBufferFromBlockPtr(Value blockPtr, triton::cpu::DotOp &dotOp,
                          ModuleTensorPtrShapeInfoAnalysis &shapeAnalysis,
                          PatternRewriter &rewriter) {
  Location loc = dotOp.getLoc();
  MLIRContext *ctx = dotOp.getContext();

  auto extractMemref = [&](Value ptr) {
    auto tensorTy = dyn_cast<RankedTensorType>(
        dyn_cast<PointerType>(ptr.getType()).getPointeeType());
    auto elemTy = tensorTy.getElementType();
    auto shapeInfo = shapeAnalysis.getPtrShapeInfo(ptr);
    Type memRefTy;
    if (shapeInfo && shapeInfo->getRank() > 0) {
      auto layout = StridedLayoutAttr::get(ctx, 0, shapeInfo->getStrides());
      memRefTy = MemRefType::get(shapeInfo->getShape(), elemTy, layout);
    } else {
      SmallVector<int64_t> dynVals(tensorTy.getRank(), ShapedType::kDynamic);
      auto layout = StridedLayoutAttr::get(ctx, 0, dynVals);
      memRefTy = MemRefType::get(dynVals, elemTy, layout);
    }
    return rewriter.create<ExtractMemRefOp>(loc, memRefTy, ptr);
  };

  auto memRef = extractMemref(blockPtr);
  auto indices = rewriter.create<ExtractIndicesOp>(loc, blockPtr).getResults();

  return {memRef, indices};
}

Value computeStepInBytes(Location loc, memref::ExtractStridedMetadataOp meta,
                         ArrayRef<Value> steps, PatternRewriter &rewriter) {
  Value res = index_cst(0);
  if (steps.empty())
    return res;

  SmallVector<Value> strides = meta.getStrides();
  for (uint i = 0; i < strides.size(); i++) {
    LDBG("[compute step]: " << i << "\n\tstride: " << strides[i]
                            << "\n\tstep: " << steps[i]);
    Value stride = strides[i];
    Value step = steps[i];
    if (!step.getType().isIndex())
      step = op_index_cast(rewriter.getIndexType(), step);
    Value mul = op_muli(step, stride);
    res = op_addi(res, mul);
    LDBG("[compute step]: mul " << mul);
  }

  Value dtSize = index_cst(
      getElementTypeOrSelf(meta.getBaseBuffer()).getIntOrFloatBitWidth() / 8);
  res = op_muli(res, dtSize);
  return res;
}

// 1. DotOp is replaced with BRGEMM call (aka loop collapse)
//   CONDITIONS:
//     - Acc is loop-carried
//     - Input buffers should exists, have steps and basic block pointers
//     - Buffer steps and block pointers should be loop invariants
//   - All generation goes out of the loop
//   - The original dot op result uses are replaced with its acc operand (to
//   make it dead code)

// 2. DotOp is replaced with GEMM call
// a) Acc is loop-carried
//   - Create buf for acc before the loop
//     -- OPT: use output buffer instead of the temporary one
//   - Put init acc values into the buf before the loop
//   - Load acc from buf after the loop and replace loop result uses with loaded
//   acc
//   - The original dot op result uses are replaced with its acc operand (to
//   make it dead code)
//   -- OPT: Remove the original store if output buffer was used for acc

// b) Acc is not loop-carried
//   - Create buf for acc before the loop
//   - Put acc value into the buf before the dot op
//   - Load acc from buf after GEMM call and replace orig dot op result uses
//   with loaded acc
//   - The original dot op is removed

LogicalResult
convertCandidate(DotOpCandidate &candidate, Ukernels ukernels,
                 ModuleTensorPtrShapeInfoAnalysis &shapeInfoAnalysis,
                 PatternRewriter &rewriter) {
  triton::cpu::DotOp op = candidate.op;
  Location loc = op.getLoc();
  VectorType resTy = cast<VectorType>(op.getResult().getType());
  Type resElemTy = resTy.getElementType();

  scf::ForOp forOp = dyn_cast<scf::ForOp>(op->getParentOp());
  Value numBatches = index_cst(1);
  if (candidate.isAccLoopCarried && candidate.canFuseLoop) {
    // We can fully replace the loop with one op.

    // Initial tile values are loaded before the loop and then directly
    // used within the loop. Later, new iter values will be added to
    // add loop carried-dependencies for accumulator tiles and accInitTiles
    // will be used as initializers for them.
    rewriter.setInsertionPoint(forOp);
    auto memrefsFromBlockPtr =
        extractBufferFromBlockPtr(candidate.lhsBuf.origBlockPtr, candidate.op,
                                  shapeInfoAnalysis, rewriter);
    candidate.lhsBuf.memRef = memrefsFromBlockPtr.first;
    candidate.lhsBuf.indices = memrefsFromBlockPtr.second;

    memrefsFromBlockPtr =
        extractBufferFromBlockPtr(candidate.rhsBuf.origBlockPtr, candidate.op,
                                  shapeInfoAnalysis, rewriter);
    candidate.rhsBuf.memRef = memrefsFromBlockPtr.first;
    candidate.rhsBuf.indices = memrefsFromBlockPtr.second;

    LDBG("Loading accumulator to tiles before the loop.");

    numBatches = op_divui(op_subi(forOp.getUpperBound(), forOp.getLowerBound()),
                          forOp.getStep());
    numBatches = op_index_cast(rewriter.getIndexType(), numBatches);
  }

  Operation *allocaPoint = op;
  while (!isa<triton::FuncOp>(allocaPoint->getParentOp()))
    allocaPoint = allocaPoint->getParentOp();

  auto blockM = int_cst(rewriter.getI64Type(), candidate.blockM);
  auto blockN = int_cst(rewriter.getI64Type(), candidate.blockN);
  auto blockK = int_cst(rewriter.getI64Type(), candidate.blockK);

  if (candidate.lhsBuf.empty()) {
    candidate.lhsBuf =
        storeToTmpBuffer(loc, candidate.op.getA(), allocaPoint, rewriter);
  }

  if (candidate.rhsBuf.empty()) {
    candidate.rhsBuf =
        storeToTmpBuffer(loc, candidate.op.getB(), allocaPoint, rewriter);
  }

  Value accToStore = op.getC();
  if (candidate.isAccLoopCarried) {
    LDBG("Setting insertion op to forOp. (accToStore)");
    forOp = cast<scf::ForOp>(op->getParentOp());
    accToStore = getInitAccValue(accToStore);
  }

  MemBuffer accBuf;
  {
    // If accumulator is bufferized then we should move initial values before
    // the loop.
    OpBuilder::InsertionGuard g(rewriter);
    if (candidate.isAccLoopCarried) {
      LDBG("String Setting insertion op to forOp. (accBuf)");
      rewriter.setInsertionPoint(forOp);
    }
    // Currently, acc always needs to be FP32.
    accToStore = maybeCast(loc, accToStore, rewriter.getF32Type(), rewriter);
    accBuf = storeToTmpBuffer(loc, accToStore, allocaPoint, rewriter);
  }
  bool isPackingRequired =
      isPackingExpected(op.getA().getType(), op.getB().getType(), ukernels);

  auto lhsVecTy = cast<VectorType>(candidate.op.getA().getType());
  auto lhsSubView =
      addMemrefSubView(rewriter, loc, lhsVecTy, candidate.lhsBuf.indices,
                       candidate.lhsBuf.memRef);

  auto rhsVecTy = cast<VectorType>(candidate.op.getB().getType());
  if (candidate.rhsBuf.vnni) {
    rhsVecTy = getPackedLayoutType(rhsVecTy);
  }
  auto rhsSubView =
      addMemrefSubView(rewriter, loc, rhsVecTy, candidate.rhsBuf.indices,
                       candidate.rhsBuf.memRef);

  auto metadataA =
      rewriter.create<memref::ExtractStridedMetadataOp>(loc, lhsSubView);
  auto metadataB =
      rewriter.create<memref::ExtractStridedMetadataOp>(loc, rhsSubView);
  auto metadataAcc =
      rewriter.create<memref::ExtractStridedMetadataOp>(loc, accBuf.memRef);

  Value lda = metadataA.getStrides()[metadataA.getStrides().size() - 2];
  Value ldb = metadataB.getStrides()[metadataB.getStrides().size() - 2];
  Value ldc = metadataAcc.getStrides()[metadataAcc.getStrides().size() - 2];

  Value lhsStepInBytes =
      computeStepInBytes(loc, metadataA, candidate.lhsBuf.step, rewriter);
  Value rhsStepInBytes =
      computeStepInBytes(loc, metadataB, candidate.rhsBuf.step, rewriter);

  // packing already done, so just skip it.
  bool skipPacking = !isPackingRequired || candidate.rhsBuf.vnni;
  auto skipPack = int_cst(rewriter.getI1Type(), skipPacking);

  Value brgemm = rewriter.create<triton::cpu::BrgemmCreate>(
      loc, rewriter.getIndexType(), blockM, blockN, blockK, numBatches, lda,
      ldb, ldc, lhsStepInBytes, rhsStepInBytes, op.getA().getType(),
      op.getB().getType(), rewriter.getF32Type(), skipPack);
  auto rhsTypeSize = int_cst(rewriter.getI64Type(),
                             op.getB().getType().getElementTypeBitWidth() / 8);
  Value rhsBlockSizeInBytes = op_muli(op_muli(blockN, blockK), rhsTypeSize);

  LDBG("[prepareResultBuffer] prepared acc buf: " << accBuf.memRef);
  LDBG("lhsBuf: {   memref "
       << candidate.lhsBuf.memRef << "\n "
       << "           indices " << candidate.lhsBuf.indices.size() << "\n"
       << "              step " << candidate.lhsBuf.step.size() << "\n"
       << "          blockptr " << candidate.lhsBuf.origBlockPtr << "\n"
       << "        transposed " << candidate.lhsBuf.transposed << "\n} \n");
  LDBG("rhsBuf: {   memref "
       << candidate.rhsBuf.memRef << "\n "
       << "           indices " << candidate.rhsBuf.indices.size() << "\n"
       << "              step " << candidate.rhsBuf.step.size() << "\n"
       << "          blockptr " << candidate.rhsBuf.origBlockPtr << "\n"
       << "        transposed " << candidate.rhsBuf.transposed << "\n} \n");

  rewriter.create<triton::cpu::BrgemmExecute>(
      loc, brgemm, lhsSubView, rhsSubView, accBuf.memRef, lhsStepInBytes,
      rhsStepInBytes, rhsBlockSizeInBytes, numBatches, skipPack);

  if (candidate.isAccLoopCarried && candidate.canFuseLoop) {
    LDBG("Loading the result to a vector to replace orig op result.");
    Value newVal =
        op_read(cast<VectorType>(toFp32(resTy)), accBuf.memRef, accBuf.indices);

    // Hope that dead code elemination do the rest.
    rewriter.replaceOp(candidate.op, candidate.op.getC());

    // We might need to cast back to the original type.
    newVal = maybeCast(loc, newVal, resElemTy, rewriter);
    rewriter.replaceAllOpUsesWith(
        forOp,
        ValueRange{newVal, candidate.lhsBuf.memRef, candidate.rhsBuf.memRef});
    return success();
  }

  if (candidate.isAccLoopCarried) {
    rewriter.setInsertionPointAfter(forOp);
    auto rank = dyn_cast<MemRefType>(accBuf.memRef.getType()).getRank();
    SmallVector<bool, 4> inBounds(rank, false);
    Value newVal =
        op_read(cast<VectorType>(toFp32(resTy)), accBuf.memRef, accBuf.indices);
    // We might need to cast back to the original type.
    newVal = maybeCast(loc, newVal, resElemTy, rewriter);
    int resIdx = op.getResult().getUses().begin()->getOperandNumber();
    Value loopRes = forOp.getResult(resIdx);
    loopRes.replaceAllUsesWith(newVal);
    rewriter.replaceOp(op, op.getC());
    return success();
  }
  LDBG("Loading the result to a vector to replace orig op result.");
  Value newVal = rewriter.create<vector::TransferReadOp>(
      loc, cast<VectorType>(toFp32(resTy)), accBuf.memRef, accBuf.indices);
  // We might need to cast back to the original type.
  newVal = maybeCast(loc, newVal, resElemTy, rewriter);
  op.getResult().replaceAllUsesWith(newVal);
  rewriter.eraseOp(op);
  return success();
}

struct ConvertDotOpToUkernelOps
    : public triton::cpu::impl::ConvertDotOpToUkernelOpsBase<
          ConvertDotOpToUkernelOps> {
  ConvertDotOpToUkernelOps() = default;
  ConvertDotOpToUkernelOps(Ukernels ukernels) { this->ukernels = ukernels; }

  void runOnOperation() override {
    MLIRContext *context = &getContext();
    ModuleOp mod = getOperation();

    ModuleTensorPtrShapeInfoAnalysis shapeInfoAnalysis(mod);

    SmallVector<DotOpCandidate, 2> candidates;
    mod->walk([&candidates, this](triton::cpu::DotOp op) {
      DotOpCandidate candidate;
      if (isUkernelsCandidate(op, candidate, this->ukernels)) {
        LLVM_DEBUG({
          LDBG("Found ukernel candidate");
          LDBG("  Op: " << candidate.op);
          LDBG("  blockM: " << candidate.blockM);
          LDBG("  blockN: " << candidate.blockN);
          LDBG("  blockK: " << candidate.blockK);
          LDBG("  isAccLoopCarried: " << candidate.isAccLoopCarried);
          LDBG("  canFuseLoop: " << candidate.canFuseLoop);
        });
        candidates.push_back(candidate);
      }
      return WalkResult::advance();
    });

    for (auto &candidate : candidates) {
      LDBG("Starting conversion of candidate: " << candidate.op);
      PatternRewriter rewriter(context);
      rewriter.setInsertionPoint(candidate.op);
      if (succeeded(convertCandidate(candidate, ukernels, shapeInfoAnalysis,
                                     rewriter))) {
        LDBG("Conversion succeeded!");
      } else {
        LDBG("Conversion failed!");
      }
    }
  }
};

} // namespace

namespace mlir::triton::cpu {

std::unique_ptr<OperationPass<ModuleOp>>
createConvertDotOpToUkernelOps(Ukernels ukernels) {
  return std::make_unique<ConvertDotOpToUkernelOps>(ukernels);
}

} // namespace mlir::triton::cpu
