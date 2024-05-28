debug=0, cpu=1, program=python/tutorials/01-vector-add.py
NUM_ELEMENTS = 98432, BLOCK_SIZE = 32, MASK = True
//===--LLVM IR-------------------------------------------------------------===//
; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(readwrite, inaccessiblemem: none)
define void @add_kernel(ptr %0, ptr %1, ptr %2, i32 %3, i32 %4, i32 %5, i32 %6) local_unnamed_addr #0 !dbg !3 {
  %8 = shl i32 %4, 5, !dbg !6
  %9 = insertelement <32 x i32> poison, i32 %8, i64 0, !dbg !7
  %10 = shufflevector <32 x i32> %9, <32 x i32> poison, <32 x i32> zeroinitializer, !dbg !7
  %11 = or disjoint <32 x i32> %10, <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 30, i32 31>, !dbg !7
  %12 = insertelement <32 x i32> poison, i32 %3, i64 0, !dbg !8
  %13 = shufflevector <32 x i32> %12, <32 x i32> poison, <32 x i32> zeroinitializer, !dbg !8
  %14 = icmp slt <32 x i32> %11, %13, !dbg !8
  %15 = ptrtoint ptr %0 to i64, !dbg !9
  %16 = extractelement <32 x i32> %11, i64 0, !dbg !10
  %17 = shl i32 %16, 2, !dbg !10
  %18 = sext i32 %17 to i64, !dbg !10
  %19 = add i64 %18, %15, !dbg !10
  %20 = inttoptr i64 %19 to ptr, !dbg !10
  %21 = tail call <32 x float> @llvm.masked.load.v32f32.p0(ptr %20, i32 4, <32 x i1> %14, <32 x float> zeroinitializer), !dbg !10
  %22 = ptrtoint ptr %1 to i64, !dbg !11
  %23 = add i64 %18, %22, !dbg !12
  %24 = inttoptr i64 %23 to ptr, !dbg !12
  %25 = tail call <32 x float> @llvm.masked.load.v32f32.p0(ptr %24, i32 4, <32 x i1> %14, <32 x float> zeroinitializer), !dbg !12
  %26 = fadd <32 x float> %21, %25, !dbg !13
  %27 = ptrtoint ptr %2 to i64, !dbg !14
  %28 = add i64 %18, %27, !dbg !15
  %29 = inttoptr i64 %28 to ptr, !dbg !15
  tail call void @llvm.masked.store.v32f32.p0(<32 x float> %26, ptr %29, i32 4, <32 x i1> %14), !dbg !15
  ret void, !dbg !16
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <32 x float> @llvm.masked.load.v32f32.p0(ptr nocapture, i32 immarg, <32 x i1>, <32 x float>) #1

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.masked.store.v32f32.p0(<32 x float>, ptr nocapture, i32 immarg, <32 x i1>) #2

attributes #0 = { mustprogress nofree norecurse nosync nounwind willreturn memory(readwrite, inaccessiblemem: none) }
attributes #1 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: read) }
attributes #2 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: write) }

!llvm.module.flags = !{!0}
!llvm.dbg.cu = !{!1}

!0 = !{i32 2, !"Debug Info Version", i32 3}
!1 = distinct !DICompileUnit(language: DW_LANG_C, file: !2, producer: "triton", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly)
!2 = !DIFile(filename: "01-vector-add.py", directory: "/data/users/minjang/triton-oss/triton-cpu-minjang/python/tutorials")
!3 = distinct !DISubprogram(name: "add_kernel", linkageName: "add_kernel", scope: !2, file: !2, line: 41, type: !4, scopeLine: 41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !1)
!4 = !DISubroutineType(cc: DW_CC_normal, types: !5)
!5 = !{}
!6 = !DILocation(line: 55, column: 24, scope: !3)
!7 = !DILocation(line: 56, column: 28, scope: !3)
!8 = !DILocation(line: 58, column: 21, scope: !3)
!9 = !DILocation(line: 61, column: 24, scope: !3)
!10 = !DILocation(line: 61, column: 16, scope: !3)
!11 = !DILocation(line: 62, column: 24, scope: !3)
!12 = !DILocation(line: 62, column: 16, scope: !3)
!13 = !DILocation(line: 63, column: 17, scope: !3)
!14 = !DILocation(line: 65, column: 26, scope: !3)
!15 = !DILocation(line: 65, column: 35, scope: !3)
!16 = !DILocation(line: 65, column: 4, scope: !3)


//===--ASM-----------------------------------------------------------------===//
	.text
	.file	"LLVMDialectModule"
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
.LCPI0_0:
	.long	16
	.long	17
	.long	18
	.long	19
	.long	20
	.long	21
	.long	22
	.long	23
	.long	24
	.long	25
	.long	26
	.long	27
	.long	28
	.long	29
	.long	30
	.long	31
.LCPI0_1:
	.long	0
	.long	1
	.long	2
	.long	3
	.long	4
	.long	5
	.long	6
	.long	7
	.long	8
	.long	9
	.long	10
	.long	11
	.long	12
	.long	13
	.long	14
	.long	15
	.text
	.globl	add_kernel
	.p2align	4, 0x90
	.type	add_kernel,@function
add_kernel:
.Lfunc_begin0:
	.cfi_sections .debug_frame
	.cfi_startproc
	.file	1 "/data/users/minjang/triton-oss/triton-cpu-minjang/python/tutorials" "01-vector-add.py"
	movl	%r8d, %eax
	shll	$5, %eax
	vpbroadcastd	%ecx, %zmm2
	shll	$7, %r8d
	vpbroadcastd	%eax, %zmm0
	vpord	.LCPI0_0(%rip), %zmm0, %zmm1
	vpord	.LCPI0_1(%rip), %zmm0, %zmm0
	movslq	%r8d, %rax
	vpcmpgtd	%zmm0, %zmm2, %k1
	vpcmpgtd	%zmm1, %zmm2, %k2
	vmovups	64(%rax,%rdi), %zmm0 {%k2} {z}
	vmovups	64(%rax,%rsi), %zmm2 {%k2} {z}
	vmovups	(%rax,%rdi), %zmm1 {%k1} {z}
	vmovups	(%rax,%rsi), %zmm3 {%k1} {z}
	vaddps	%zmm2, %zmm0, %zmm0
	vaddps	%zmm3, %zmm1, %zmm1
	vmovups	%zmm0, 64(%rax,%rdx) {%k2}
	vmovups	%zmm1, (%rax,%rdx) {%k1}
	vzeroupper
	retq
.Ltmp0:
.Lfunc_end0:
	.size	add_kernel, .Lfunc_end0-add_kernel
	.cfi_endproc

	.section	.debug_abbrev,"",@progbits
	.byte	1
	.byte	17
	.byte	0
	.byte	37
	.byte	14
	.byte	19
	.byte	5
	.byte	3
	.byte	14
	.byte	16
	.byte	23
	.byte	27
	.byte	14
	.byte	17
	.byte	1
	.byte	18
	.byte	6
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_info,"",@progbits
.Lcu_begin0:
	.long	.Ldebug_info_end0-.Ldebug_info_start0
.Ldebug_info_start0:
	.short	4
	.long	.debug_abbrev
	.byte	8
	.byte	1
	.long	.Linfo_string0
	.short	2
	.long	.Linfo_string1
	.long	.Lline_table_start0
	.long	.Linfo_string2
	.quad	.Lfunc_begin0
	.long	.Lfunc_end0-.Lfunc_begin0
.Ldebug_info_end0:
	.section	.debug_str,"MS",@progbits,1
.Linfo_string0:
	.asciz	"triton"
.Linfo_string1:
	.asciz	"01-vector-add.py"
.Linfo_string2:
	.asciz	"/data/users/minjang/triton-oss/triton-cpu-minjang/python/tutorials"
	.section	".note.GNU-stack","",@progbits
	.section	.debug_line,"",@progbits
.Lline_table_start0:

Test passed!
