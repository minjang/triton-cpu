debug=0, cpu=1, program=python/tutorials/01-vector-add.py
NUM_ELEMENTS = 512, BLOCK_SIZE = 512, MASK = False
//===--LLVM IR-------------------------------------------------------------===//
; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(readwrite, inaccessiblemem: none)
define void @add_kernel(ptr %0, ptr %1, ptr %2, i32 %3, i32 %4, i32 %5, i32 %6) local_unnamed_addr #0 !dbg !3 {
  %8 = shl i32 %4, 11, !dbg !6
  %9 = ptrtoint ptr %0 to i64, !dbg !7
  %10 = sext i32 %8 to i64, !dbg !8
  %11 = add i64 %10, %9, !dbg !8
  %12 = inttoptr i64 %11 to ptr, !dbg !8
  %13 = load <512 x float>, ptr %12, align 4, !dbg !8
  %14 = ptrtoint ptr %1 to i64, !dbg !9
  %15 = add i64 %10, %14, !dbg !10
  %16 = inttoptr i64 %15 to ptr, !dbg !10
  %17 = load <512 x float>, ptr %16, align 4, !dbg !10
  %18 = fadd <512 x float> %13, %17, !dbg !11
  %19 = ptrtoint ptr %2 to i64, !dbg !12
  %20 = add i64 %10, %19, !dbg !13
  %21 = inttoptr i64 %20 to ptr, !dbg !13
  store <512 x float> %18, ptr %21, align 4, !dbg !13
  ret void, !dbg !14
}

attributes #0 = { mustprogress nofree norecurse nosync nounwind willreturn memory(readwrite, inaccessiblemem: none) }

!llvm.module.flags = !{!0}
!llvm.dbg.cu = !{!1}

!0 = !{i32 2, !"Debug Info Version", i32 3}
!1 = distinct !DICompileUnit(language: DW_LANG_C, file: !2, producer: "triton", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly)
!2 = !DIFile(filename: "01-vector-add.py", directory: "/data/users/minjang/triton-oss/triton-cpu-minjang/python/tutorials")
!3 = distinct !DISubprogram(name: "add_kernel", linkageName: "add_kernel", scope: !2, file: !2, line: 41, type: !4, scopeLine: 41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !1)
!4 = !DISubroutineType(cc: DW_CC_normal, types: !5)
!5 = !{}
!6 = !DILocation(line: 55, column: 24, scope: !3)
!7 = !DILocation(line: 61, column: 24, scope: !3)
!8 = !DILocation(line: 61, column: 16, scope: !3)
!9 = !DILocation(line: 62, column: 24, scope: !3)
!10 = !DILocation(line: 62, column: 16, scope: !3)
!11 = !DILocation(line: 63, column: 17, scope: !3)
!12 = !DILocation(line: 65, column: 26, scope: !3)
!13 = !DILocation(line: 65, column: 35, scope: !3)
!14 = !DILocation(line: 65, column: 4, scope: !3)


//===--ASM-----------------------------------------------------------------===//
	.text
	.file	"LLVMDialectModule"
	.globl	add_kernel
	.p2align	4, 0x90
	.type	add_kernel,@function
add_kernel:
.Lfunc_begin0:
	.cfi_sections .debug_frame
	.cfi_startproc
	.file	1 "/data/users/minjang/triton-oss/triton-cpu-minjang/python/tutorials" "01-vector-add.py"
	.loc	1 55 24 prologue_end
	shll	$11, %r8d
	.loc	1 61 16
	movslq	%r8d, %rax
	vmovups	1984(%rax,%rdi), %zmm0
	vmovups	1920(%rax,%rdi), %zmm1
	vmovups	1856(%rax,%rdi), %zmm2
	vmovups	1792(%rax,%rdi), %zmm3
	vmovups	1728(%rax,%rdi), %zmm4
	vmovups	1664(%rax,%rdi), %zmm5
	vmovups	1600(%rax,%rdi), %zmm6
	vmovups	1536(%rax,%rdi), %zmm7
	vmovups	1472(%rax,%rdi), %zmm8
	vmovups	1408(%rax,%rdi), %zmm9
	vmovups	1344(%rax,%rdi), %zmm10
	vmovups	1280(%rax,%rdi), %zmm11
	vmovups	1216(%rax,%rdi), %zmm12
	vmovups	1152(%rax,%rdi), %zmm13
	vmovups	1088(%rax,%rdi), %zmm14
	vmovups	1024(%rax,%rdi), %zmm15
	vmovups	960(%rax,%rdi), %zmm16
	vmovups	896(%rax,%rdi), %zmm17
	vmovups	832(%rax,%rdi), %zmm18
	vmovups	768(%rax,%rdi), %zmm19
	vmovups	704(%rax,%rdi), %zmm20
	vmovups	640(%rax,%rdi), %zmm21
	vmovups	576(%rax,%rdi), %zmm22
	vmovups	512(%rax,%rdi), %zmm23
	vmovups	448(%rax,%rdi), %zmm24
	vmovups	384(%rax,%rdi), %zmm25
	vmovups	320(%rax,%rdi), %zmm26
	vmovups	256(%rax,%rdi), %zmm27
	vmovups	(%rax,%rdi), %zmm28
	vmovups	64(%rax,%rdi), %zmm29
	vmovups	128(%rax,%rdi), %zmm30
	vmovups	192(%rax,%rdi), %zmm31
	.loc	1 63 17
	vaddps	(%rax,%rsi), %zmm28, %zmm28
	vaddps	64(%rax,%rsi), %zmm29, %zmm29
	vaddps	128(%rax,%rsi), %zmm30, %zmm30
	vaddps	192(%rax,%rsi), %zmm31, %zmm31
	vaddps	256(%rax,%rsi), %zmm27, %zmm27
	vaddps	320(%rax,%rsi), %zmm26, %zmm26
	vaddps	384(%rax,%rsi), %zmm25, %zmm25
	vaddps	448(%rax,%rsi), %zmm24, %zmm24
	vaddps	512(%rax,%rsi), %zmm23, %zmm23
	vaddps	576(%rax,%rsi), %zmm22, %zmm22
	vaddps	640(%rax,%rsi), %zmm21, %zmm21
	vaddps	704(%rax,%rsi), %zmm20, %zmm20
	vaddps	768(%rax,%rsi), %zmm19, %zmm19
	vaddps	832(%rax,%rsi), %zmm18, %zmm18
	vaddps	896(%rax,%rsi), %zmm17, %zmm17
	vaddps	960(%rax,%rsi), %zmm16, %zmm16
	vaddps	1024(%rax,%rsi), %zmm15, %zmm15
	vaddps	1088(%rax,%rsi), %zmm14, %zmm14
	vaddps	1152(%rax,%rsi), %zmm13, %zmm13
	vaddps	1216(%rax,%rsi), %zmm12, %zmm12
	vaddps	1280(%rax,%rsi), %zmm11, %zmm11
	vaddps	1344(%rax,%rsi), %zmm10, %zmm10
	vaddps	1408(%rax,%rsi), %zmm9, %zmm9
	vaddps	1472(%rax,%rsi), %zmm8, %zmm8
	vaddps	1536(%rax,%rsi), %zmm7, %zmm7
	vaddps	1600(%rax,%rsi), %zmm6, %zmm6
	vaddps	1664(%rax,%rsi), %zmm5, %zmm5
	vaddps	1728(%rax,%rsi), %zmm4, %zmm4
	vaddps	1792(%rax,%rsi), %zmm3, %zmm3
	vaddps	1856(%rax,%rsi), %zmm2, %zmm2
	vaddps	1920(%rax,%rsi), %zmm1, %zmm1
	vaddps	1984(%rax,%rsi), %zmm0, %zmm0
	.loc	1 65 35
	vmovups	%zmm0, 1984(%rax,%rdx)
	vmovups	%zmm1, 1920(%rax,%rdx)
	vmovups	%zmm2, 1856(%rax,%rdx)
	vmovups	%zmm3, 1792(%rax,%rdx)
	vmovups	%zmm4, 1728(%rax,%rdx)
	vmovups	%zmm5, 1664(%rax,%rdx)
	vmovups	%zmm6, 1600(%rax,%rdx)
	vmovups	%zmm7, 1536(%rax,%rdx)
	vmovups	%zmm8, 1472(%rax,%rdx)
	vmovups	%zmm9, 1408(%rax,%rdx)
	vmovups	%zmm10, 1344(%rax,%rdx)
	vmovups	%zmm11, 1280(%rax,%rdx)
	vmovups	%zmm12, 1216(%rax,%rdx)
	vmovups	%zmm13, 1152(%rax,%rdx)
	vmovups	%zmm14, 1088(%rax,%rdx)
	vmovups	%zmm15, 1024(%rax,%rdx)
	vmovups	%zmm16, 960(%rax,%rdx)
	vmovups	%zmm17, 896(%rax,%rdx)
	vmovups	%zmm18, 832(%rax,%rdx)
	vmovups	%zmm19, 768(%rax,%rdx)
	vmovups	%zmm20, 704(%rax,%rdx)
	vmovups	%zmm21, 640(%rax,%rdx)
	vmovups	%zmm22, 576(%rax,%rdx)
	vmovups	%zmm23, 512(%rax,%rdx)
	vmovups	%zmm24, 448(%rax,%rdx)
	vmovups	%zmm25, 384(%rax,%rdx)
	vmovups	%zmm26, 320(%rax,%rdx)
	vmovups	%zmm27, 256(%rax,%rdx)
	vmovups	%zmm31, 192(%rax,%rdx)
	vmovups	%zmm30, 128(%rax,%rdx)
	vmovups	%zmm29, 64(%rax,%rdx)
	vmovups	%zmm28, (%rax,%rdx)
	.loc	1 65 4 is_stmt 0
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
