debug=0, cpu=1, program=python/tutorials/01-vector-add.py
NUM_ELEMENTS = 98432, BLOCK_SIZE = 256, MASK = True
//===--LLVM IR-------------------------------------------------------------===//
; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(readwrite, inaccessiblemem: none)
define void @add_kernel(ptr %0, ptr %1, ptr %2, i32 %3, i32 %4, i32 %5, i32 %6) local_unnamed_addr #0 !dbg !3 {
  %8 = shl i32 %4, 8, !dbg !6
  %9 = insertelement <256 x i32> poison, i32 %8, i64 0, !dbg !7
  %10 = shufflevector <256 x i32> %9, <256 x i32> poison, <256 x i32> zeroinitializer, !dbg !7
  %11 = or disjoint <256 x i32> %10, <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 30, i32 31, i32 32, i32 33, i32 34, i32 35, i32 36, i32 37, i32 38, i32 39, i32 40, i32 41, i32 42, i32 43, i32 44, i32 45, i32 46, i32 47, i32 48, i32 49, i32 50, i32 51, i32 52, i32 53, i32 54, i32 55, i32 56, i32 57, i32 58, i32 59, i32 60, i32 61, i32 62, i32 63, i32 64, i32 65, i32 66, i32 67, i32 68, i32 69, i32 70, i32 71, i32 72, i32 73, i32 74, i32 75, i32 76, i32 77, i32 78, i32 79, i32 80, i32 81, i32 82, i32 83, i32 84, i32 85, i32 86, i32 87, i32 88, i32 89, i32 90, i32 91, i32 92, i32 93, i32 94, i32 95, i32 96, i32 97, i32 98, i32 99, i32 100, i32 101, i32 102, i32 103, i32 104, i32 105, i32 106, i32 107, i32 108, i32 109, i32 110, i32 111, i32 112, i32 113, i32 114, i32 115, i32 116, i32 117, i32 118, i32 119, i32 120, i32 121, i32 122, i32 123, i32 124, i32 125, i32 126, i32 127, i32 128, i32 129, i32 130, i32 131, i32 132, i32 133, i32 134, i32 135, i32 136, i32 137, i32 138, i32 139, i32 140, i32 141, i32 142, i32 143, i32 144, i32 145, i32 146, i32 147, i32 148, i32 149, i32 150, i32 151, i32 152, i32 153, i32 154, i32 155, i32 156, i32 157, i32 158, i32 159, i32 160, i32 161, i32 162, i32 163, i32 164, i32 165, i32 166, i32 167, i32 168, i32 169, i32 170, i32 171, i32 172, i32 173, i32 174, i32 175, i32 176, i32 177, i32 178, i32 179, i32 180, i32 181, i32 182, i32 183, i32 184, i32 185, i32 186, i32 187, i32 188, i32 189, i32 190, i32 191, i32 192, i32 193, i32 194, i32 195, i32 196, i32 197, i32 198, i32 199, i32 200, i32 201, i32 202, i32 203, i32 204, i32 205, i32 206, i32 207, i32 208, i32 209, i32 210, i32 211, i32 212, i32 213, i32 214, i32 215, i32 216, i32 217, i32 218, i32 219, i32 220, i32 221, i32 222, i32 223, i32 224, i32 225, i32 226, i32 227, i32 228, i32 229, i32 230, i32 231, i32 232, i32 233, i32 234, i32 235, i32 236, i32 237, i32 238, i32 239, i32 240, i32 241, i32 242, i32 243, i32 244, i32 245, i32 246, i32 247, i32 248, i32 249, i32 250, i32 251, i32 252, i32 253, i32 254, i32 255>, !dbg !7
  %12 = insertelement <256 x i32> poison, i32 %3, i64 0, !dbg !8
  %13 = shufflevector <256 x i32> %12, <256 x i32> poison, <256 x i32> zeroinitializer, !dbg !8
  %14 = icmp slt <256 x i32> %11, %13, !dbg !8
  %15 = ptrtoint ptr %0 to i64, !dbg !9
  %16 = extractelement <256 x i32> %11, i64 0, !dbg !10
  %17 = shl i32 %16, 2, !dbg !10
  %18 = sext i32 %17 to i64, !dbg !10
  %19 = add i64 %18, %15, !dbg !10
  %20 = inttoptr i64 %19 to ptr, !dbg !10
  %21 = tail call <256 x float> @llvm.masked.load.v256f32.p0(ptr %20, i32 4, <256 x i1> %14, <256 x float> zeroinitializer), !dbg !10
  %22 = ptrtoint ptr %1 to i64, !dbg !11
  %23 = add i64 %18, %22, !dbg !12
  %24 = inttoptr i64 %23 to ptr, !dbg !12
  %25 = tail call <256 x float> @llvm.masked.load.v256f32.p0(ptr %24, i32 4, <256 x i1> %14, <256 x float> zeroinitializer), !dbg !12
  %26 = fadd <256 x float> %21, %25, !dbg !13
  %27 = ptrtoint ptr %2 to i64, !dbg !14
  %28 = add i64 %18, %27, !dbg !15
  %29 = inttoptr i64 %28 to ptr, !dbg !15
  tail call void @llvm.masked.store.v256f32.p0(<256 x float> %26, ptr %29, i32 4, <256 x i1> %14), !dbg !15
  ret void, !dbg !16
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <256 x float> @llvm.masked.load.v256f32.p0(ptr nocapture, i32 immarg, <256 x i1>, <256 x float>) #1

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.masked.store.v256f32.p0(<256 x float>, ptr nocapture, i32 immarg, <256 x i1>) #2

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
	.long	240
	.long	241
	.long	242
	.long	243
	.long	244
	.long	245
	.long	246
	.long	247
	.long	248
	.long	249
	.long	250
	.long	251
	.long	252
	.long	253
	.long	254
	.long	255
.LCPI0_1:
	.long	224
	.long	225
	.long	226
	.long	227
	.long	228
	.long	229
	.long	230
	.long	231
	.long	232
	.long	233
	.long	234
	.long	235
	.long	236
	.long	237
	.long	238
	.long	239
.LCPI0_2:
	.long	208
	.long	209
	.long	210
	.long	211
	.long	212
	.long	213
	.long	214
	.long	215
	.long	216
	.long	217
	.long	218
	.long	219
	.long	220
	.long	221
	.long	222
	.long	223
.LCPI0_3:
	.long	192
	.long	193
	.long	194
	.long	195
	.long	196
	.long	197
	.long	198
	.long	199
	.long	200
	.long	201
	.long	202
	.long	203
	.long	204
	.long	205
	.long	206
	.long	207
.LCPI0_4:
	.long	176
	.long	177
	.long	178
	.long	179
	.long	180
	.long	181
	.long	182
	.long	183
	.long	184
	.long	185
	.long	186
	.long	187
	.long	188
	.long	189
	.long	190
	.long	191
.LCPI0_5:
	.long	160
	.long	161
	.long	162
	.long	163
	.long	164
	.long	165
	.long	166
	.long	167
	.long	168
	.long	169
	.long	170
	.long	171
	.long	172
	.long	173
	.long	174
	.long	175
.LCPI0_6:
	.long	144
	.long	145
	.long	146
	.long	147
	.long	148
	.long	149
	.long	150
	.long	151
	.long	152
	.long	153
	.long	154
	.long	155
	.long	156
	.long	157
	.long	158
	.long	159
.LCPI0_7:
	.long	128
	.long	129
	.long	130
	.long	131
	.long	132
	.long	133
	.long	134
	.long	135
	.long	136
	.long	137
	.long	138
	.long	139
	.long	140
	.long	141
	.long	142
	.long	143
.LCPI0_8:
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
.LCPI0_9:
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
.LCPI0_10:
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
.LCPI0_11:
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
.LCPI0_12:
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
.LCPI0_13:
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
.LCPI0_14:
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
.LCPI0_15:
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
	shll	$8, %eax
	vpbroadcastd	%ecx, %zmm16
	shll	$10, %r8d
	vpbroadcastd	%eax, %zmm0
	vpord	.LCPI0_3(%rip), %zmm0, %zmm4
	vpord	.LCPI0_7(%rip), %zmm0, %zmm8
	vpord	.LCPI0_0(%rip), %zmm0, %zmm1
	vpord	.LCPI0_14(%rip), %zmm0, %zmm15
	vpord	.LCPI0_1(%rip), %zmm0, %zmm2
	vpord	.LCPI0_2(%rip), %zmm0, %zmm3
	vpord	.LCPI0_4(%rip), %zmm0, %zmm5
	vpord	.LCPI0_5(%rip), %zmm0, %zmm6
	vpord	.LCPI0_6(%rip), %zmm0, %zmm7
	vpord	.LCPI0_8(%rip), %zmm0, %zmm9
	vpord	.LCPI0_9(%rip), %zmm0, %zmm10
	vpord	.LCPI0_10(%rip), %zmm0, %zmm11
	vpord	.LCPI0_11(%rip), %zmm0, %zmm12
	vpord	.LCPI0_12(%rip), %zmm0, %zmm13
	vpord	.LCPI0_13(%rip), %zmm0, %zmm14
	vpord	.LCPI0_15(%rip), %zmm0, %zmm0
	movslq	%r8d, %rax
	vpcmpgtd	%zmm4, %zmm16, %k7
	vpcmpgtd	%zmm8, %zmm16, %k1
	vpcmpgtd	%zmm2, %zmm16, %k2
	vpcmpgtd	%zmm3, %zmm16, %k3
	vpcmpgtd	%zmm7, %zmm16, %k4
	vpcmpgtd	%zmm6, %zmm16, %k5
	vpcmpgtd	%zmm5, %zmm16, %k6
	kmovw	%k1, -32(%rsp)
	vpcmpgtd	%zmm1, %zmm16, %k1
	kmovw	%k7, -24(%rsp)
	vmovups	768(%rax,%rdi), %zmm4 {%k7} {z}
	vpcmpgtd	%zmm15, %zmm16, %k7
	vmovups	896(%rax,%rdi), %zmm2 {%k2} {z}
	kmovw	%k2, -12(%rsp)
	vmovups	832(%rax,%rdi), %zmm3 {%k3} {z}
	kmovw	%k3, -10(%rsp)
	vmovups	896(%rax,%rsi), %zmm31 {%k2} {z}
	vmovups	704(%rax,%rdi), %zmm5 {%k6} {z}
	kmovw	%k6, -8(%rsp)
	vmovups	640(%rax,%rdi), %zmm6 {%k5} {z}
	kmovw	%k5, -6(%rsp)
	vmovups	576(%rax,%rdi), %zmm7 {%k4} {z}
	kmovw	%k4, -4(%rsp)
	vmovups	704(%rax,%rsi), %zmm19 {%k6} {z}
	vmovups	640(%rax,%rsi), %zmm20 {%k5} {z}
	vmovups	576(%rax,%rsi), %zmm21 {%k4} {z}
	kmovw	%k1, -28(%rsp)
	kmovw	%k7, -30(%rsp)
	vmovups	64(%rax,%rdi), %zmm15 {%k7} {z}
	vpcmpgtd	%zmm0, %zmm16, %k7
	vmovups	960(%rax,%rdi), %zmm1 {%k1} {z}
	kmovw	-32(%rsp), %k1
	kmovw	%k7, -22(%rsp)
	vmovups	(%rax,%rdi), %zmm0 {%k7} {z}
	kmovw	-28(%rsp), %k7
	kmovw	-22(%rsp), %k6
	vmovups	512(%rax,%rdi), %zmm8 {%k1} {z}
	vpcmpgtd	%zmm9, %zmm16, %k1
	vmovups	960(%rax,%rsi), %zmm17 {%k7} {z}
	kmovw	%k1, -26(%rsp)
	vmovups	448(%rax,%rdi), %zmm9 {%k1} {z}
	vpcmpgtd	%zmm10, %zmm16, %k1
	kmovw	-24(%rsp), %k7
	kmovw	%k1, -20(%rsp)
	vmovups	384(%rax,%rdi), %zmm10 {%k1} {z}
	vpcmpgtd	%zmm11, %zmm16, %k1
	kmovw	-26(%rsp), %k2
	vmovups	(%rax,%rsi), %zmm30 {%k6} {z}
	kmovw	%k1, -18(%rsp)
	vmovups	320(%rax,%rdi), %zmm11 {%k1} {z}
	vpcmpgtd	%zmm12, %zmm16, %k1
	kmovw	-20(%rsp), %k5
	kmovw	%k1, -16(%rsp)
	vmovups	256(%rax,%rdi), %zmm12 {%k1} {z}
	vpcmpgtd	%zmm13, %zmm16, %k1
	kmovw	-18(%rsp), %k4
	kmovw	%k1, -14(%rsp)
	vmovups	192(%rax,%rdi), %zmm13 {%k1} {z}
	vpcmpgtd	%zmm14, %zmm16, %k1
	vmovups	128(%rax,%rdi), %zmm14 {%k1} {z}
	kmovw	%k1, -2(%rsp)
	vmovups	128(%rax,%rsi), %zmm28 {%k1} {z}
	kmovw	-30(%rsp), %k1
	vmovups	768(%rax,%rsi), %zmm18 {%k7} {z}
	vmovups	448(%rax,%rsi), %zmm23 {%k2} {z}
	kmovw	-14(%rsp), %k2
	vmovups	384(%rax,%rsi), %zmm24 {%k5} {z}
	vaddps	%zmm17, %zmm1, %zmm1
	vmovups	832(%rax,%rsi), %zmm17 {%k3} {z}
	kmovw	-32(%rsp), %k3
	vmovups	320(%rax,%rsi), %zmm25 {%k4} {z}
	vaddps	%zmm30, %zmm0, %zmm0
	vmovups	64(%rax,%rsi), %zmm29 {%k1} {z}
	kmovw	-28(%rsp), %k1
	vmovups	192(%rax,%rsi), %zmm27 {%k2} {z}
	vmovups	512(%rax,%rsi), %zmm22 {%k3} {z}
	kmovw	-16(%rsp), %k3
	vmovups	256(%rax,%rsi), %zmm26 {%k3} {z}
	vmovups	%zmm1, 960(%rax,%rdx) {%k1}
	kmovw	-12(%rsp), %k1
	vaddps	%zmm31, %zmm2, %zmm1
	vaddps	%zmm19, %zmm5, %zmm2
	vmovups	%zmm1, 896(%rax,%rdx) {%k1}
	kmovw	-10(%rsp), %k1
	vaddps	%zmm17, %zmm3, %zmm1
	vaddps	%zmm18, %zmm4, %zmm3
	vmovups	%zmm1, 832(%rax,%rdx) {%k1}
	kmovw	-8(%rsp), %k1
	vmovups	%zmm3, 768(%rax,%rdx) {%k7}
	vaddps	%zmm20, %zmm6, %zmm1
	kmovw	-32(%rsp), %k7
	vaddps	%zmm22, %zmm8, %zmm3
	vmovups	%zmm2, 704(%rax,%rdx) {%k1}
	kmovw	-6(%rsp), %k1
	vaddps	%zmm24, %zmm10, %zmm2
	vmovups	%zmm1, 640(%rax,%rdx) {%k1}
	kmovw	-4(%rsp), %k1
	vaddps	%zmm21, %zmm7, %zmm1
	vmovups	%zmm1, 576(%rax,%rdx) {%k1}
	vmovups	%zmm3, 512(%rax,%rdx) {%k7}
	kmovw	-26(%rsp), %k7
	vaddps	%zmm23, %zmm9, %zmm1
	vaddps	%zmm25, %zmm11, %zmm3
	kmovw	-2(%rsp), %k1
	vmovups	%zmm1, 448(%rax,%rdx) {%k7}
	vmovups	%zmm2, 384(%rax,%rdx) {%k5}
	vaddps	%zmm26, %zmm12, %zmm2
	vmovups	%zmm3, 320(%rax,%rdx) {%k4}
	vaddps	%zmm27, %zmm13, %zmm3
	vaddps	%zmm29, %zmm15, %zmm1
	vmovups	%zmm2, 256(%rax,%rdx) {%k3}
	vaddps	%zmm28, %zmm14, %zmm2
	vmovups	%zmm3, 192(%rax,%rdx) {%k2}
	vmovups	%zmm2, 128(%rax,%rdx) {%k1}
	kmovw	-30(%rsp), %k1
	vmovups	%zmm1, 64(%rax,%rdx) {%k1}
	vmovups	%zmm0, (%rax,%rdx) {%k6}
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
