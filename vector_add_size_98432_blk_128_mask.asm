debug=0, cpu=1, program=python/tutorials/01-vector-add.py
NUM_ELEMENTS = 98432, BLOCK_SIZE = 128, MASK = True
//===--LLVM IR-------------------------------------------------------------===//
; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(readwrite, inaccessiblemem: none)
define void @add_kernel(ptr %0, ptr %1, ptr %2, i32 %3, i32 %4, i32 %5, i32 %6) local_unnamed_addr #0 !dbg !3 {
  %8 = shl i32 %4, 7, !dbg !6
  %9 = insertelement <128 x i32> poison, i32 %8, i64 0, !dbg !7
  %10 = shufflevector <128 x i32> %9, <128 x i32> poison, <128 x i32> zeroinitializer, !dbg !7
  %11 = or disjoint <128 x i32> %10, <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 30, i32 31, i32 32, i32 33, i32 34, i32 35, i32 36, i32 37, i32 38, i32 39, i32 40, i32 41, i32 42, i32 43, i32 44, i32 45, i32 46, i32 47, i32 48, i32 49, i32 50, i32 51, i32 52, i32 53, i32 54, i32 55, i32 56, i32 57, i32 58, i32 59, i32 60, i32 61, i32 62, i32 63, i32 64, i32 65, i32 66, i32 67, i32 68, i32 69, i32 70, i32 71, i32 72, i32 73, i32 74, i32 75, i32 76, i32 77, i32 78, i32 79, i32 80, i32 81, i32 82, i32 83, i32 84, i32 85, i32 86, i32 87, i32 88, i32 89, i32 90, i32 91, i32 92, i32 93, i32 94, i32 95, i32 96, i32 97, i32 98, i32 99, i32 100, i32 101, i32 102, i32 103, i32 104, i32 105, i32 106, i32 107, i32 108, i32 109, i32 110, i32 111, i32 112, i32 113, i32 114, i32 115, i32 116, i32 117, i32 118, i32 119, i32 120, i32 121, i32 122, i32 123, i32 124, i32 125, i32 126, i32 127>, !dbg !7
  %12 = insertelement <128 x i32> poison, i32 %3, i64 0, !dbg !8
  %13 = shufflevector <128 x i32> %12, <128 x i32> poison, <128 x i32> zeroinitializer, !dbg !8
  %14 = icmp slt <128 x i32> %11, %13, !dbg !8
  %15 = ptrtoint ptr %0 to i64, !dbg !9
  %16 = extractelement <128 x i32> %11, i64 0, !dbg !10
  %17 = shl i32 %16, 2, !dbg !10
  %18 = sext i32 %17 to i64, !dbg !10
  %19 = add i64 %18, %15, !dbg !10
  %20 = inttoptr i64 %19 to ptr, !dbg !10
  %21 = tail call <128 x float> @llvm.masked.load.v128f32.p0(ptr %20, i32 4, <128 x i1> %14, <128 x float> zeroinitializer), !dbg !10
  %22 = ptrtoint ptr %1 to i64, !dbg !11
  %23 = add i64 %18, %22, !dbg !12
  %24 = inttoptr i64 %23 to ptr, !dbg !12
  %25 = tail call <128 x float> @llvm.masked.load.v128f32.p0(ptr %24, i32 4, <128 x i1> %14, <128 x float> zeroinitializer), !dbg !12
  %26 = fadd <128 x float> %21, %25, !dbg !13
  %27 = ptrtoint ptr %2 to i64, !dbg !14
  %28 = add i64 %18, %27, !dbg !15
  %29 = inttoptr i64 %28 to ptr, !dbg !15
  tail call void @llvm.masked.store.v128f32.p0(<128 x float> %26, ptr %29, i32 4, <128 x i1> %14), !dbg !15
  ret void, !dbg !16
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <128 x float> @llvm.masked.load.v128f32.p0(ptr nocapture, i32 immarg, <128 x i1>, <128 x float>) #1

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.masked.store.v128f32.p0(<128 x float>, ptr nocapture, i32 immarg, <128 x i1>) #2

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
	.long	112
	.long	113
	.long	114
	.long	115
	.long	116
	.long	117
	.long	118
	.long	119
	.long	120
	.long	121
	.long	122
	.long	123
	.long	124
	.long	125
	.long	126
	.long	127
.LCPI0_1:
	.long	96
	.long	97
	.long	98
	.long	99
	.long	100
	.long	101
	.long	102
	.long	103
	.long	104
	.long	105
	.long	106
	.long	107
	.long	108
	.long	109
	.long	110
	.long	111
.LCPI0_2:
	.long	80
	.long	81
	.long	82
	.long	83
	.long	84
	.long	85
	.long	86
	.long	87
	.long	88
	.long	89
	.long	90
	.long	91
	.long	92
	.long	93
	.long	94
	.long	95
.LCPI0_3:
	.long	64
	.long	65
	.long	66
	.long	67
	.long	68
	.long	69
	.long	70
	.long	71
	.long	72
	.long	73
	.long	74
	.long	75
	.long	76
	.long	77
	.long	78
	.long	79
.LCPI0_4:
	.long	48
	.long	49
	.long	50
	.long	51
	.long	52
	.long	53
	.long	54
	.long	55
	.long	56
	.long	57
	.long	58
	.long	59
	.long	60
	.long	61
	.long	62
	.long	63
.LCPI0_5:
	.long	32
	.long	33
	.long	34
	.long	35
	.long	36
	.long	37
	.long	38
	.long	39
	.long	40
	.long	41
	.long	42
	.long	43
	.long	44
	.long	45
	.long	46
	.long	47
.LCPI0_6:
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
.LCPI0_7:
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
	shll	$7, %eax
	vpbroadcastd	%ecx, %zmm8
	shll	$9, %r8d
	vpbroadcastd	%eax, %zmm0
	vpord	.LCPI0_0(%rip), %zmm0, %zmm1
	vpord	.LCPI0_1(%rip), %zmm0, %zmm2
	vpord	.LCPI0_2(%rip), %zmm0, %zmm3
	vpord	.LCPI0_3(%rip), %zmm0, %zmm4
	vpord	.LCPI0_4(%rip), %zmm0, %zmm5
	vpord	.LCPI0_5(%rip), %zmm0, %zmm6
	vpord	.LCPI0_6(%rip), %zmm0, %zmm7
	vpord	.LCPI0_7(%rip), %zmm0, %zmm0
	movslq	%r8d, %rax
	vpcmpgtd	%zmm2, %zmm8, %k6
	vpcmpgtd	%zmm1, %zmm8, %k7
	vpcmpgtd	%zmm0, %zmm8, %k1
	vpcmpgtd	%zmm3, %zmm8, %k5
	vpcmpgtd	%zmm4, %zmm8, %k4
	vpcmpgtd	%zmm6, %zmm8, %k2
	vpcmpgtd	%zmm5, %zmm8, %k3
	vmovups	448(%rax,%rdi), %zmm0 {%k7} {z}
	vmovups	448(%rax,%rsi), %zmm10 {%k7} {z}
	vmovups	384(%rax,%rdi), %zmm1 {%k6} {z}
	vmovups	384(%rax,%rsi), %zmm9 {%k6} {z}
	vmovups	320(%rax,%rdi), %zmm2 {%k5} {z}
	vmovups	256(%rax,%rdi), %zmm3 {%k4} {z}
	vmovups	192(%rax,%rdi), %zmm4 {%k3} {z}
	vmovups	128(%rax,%rdi), %zmm5 {%k2} {z}
	kmovw	%k1, -2(%rsp)
	vpcmpgtd	%zmm7, %zmm8, %k1
	kmovw	%k2, -4(%rsp)
	kmovw	%k1, -6(%rsp)
	vmovups	64(%rax,%rdi), %zmm6 {%k1} {z}
	kmovw	-2(%rsp), %k1
	vmovups	(%rax,%rdi), %zmm7 {%k1} {z}
	vaddps	%zmm10, %zmm0, %zmm0
	vaddps	%zmm9, %zmm1, %zmm1
	vmovups	320(%rax,%rsi), %zmm10 {%k5} {z}
	vmovups	256(%rax,%rsi), %zmm9 {%k4} {z}
	vaddps	%zmm10, %zmm2, %zmm2
	vaddps	%zmm9, %zmm3, %zmm3
	vmovups	128(%rax,%rsi), %zmm9 {%k2} {z}
	vmovups	192(%rax,%rsi), %zmm10 {%k3} {z}
	kmovw	-6(%rsp), %k2
	vaddps	%zmm10, %zmm4, %zmm4
	vmovups	64(%rax,%rsi), %zmm10 {%k2} {z}
	vaddps	%zmm9, %zmm5, %zmm5
	vmovups	(%rax,%rsi), %zmm9 {%k1} {z}
	kmovw	-4(%rsp), %k2
	vmovups	%zmm0, 448(%rax,%rdx) {%k7}
	vmovups	%zmm1, 384(%rax,%rdx) {%k6}
	vmovups	%zmm2, 320(%rax,%rdx) {%k5}
	vmovups	%zmm3, 256(%rax,%rdx) {%k4}
	vmovups	%zmm4, 192(%rax,%rdx) {%k3}
	vmovups	%zmm5, 128(%rax,%rdx) {%k2}
	kmovw	-6(%rsp), %k2
	vaddps	%zmm10, %zmm6, %zmm6
	vaddps	%zmm9, %zmm7, %zmm7
	vmovups	%zmm6, 64(%rax,%rdx) {%k2}
	vmovups	%zmm7, (%rax,%rdx) {%k1}
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
