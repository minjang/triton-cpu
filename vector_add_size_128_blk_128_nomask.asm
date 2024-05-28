debug=0, cpu=1, program=python/tutorials/01-vector-add.py
NUM_ELEMENTS = 128, BLOCK_SIZE = 128, MASK = False
//===--LLVM IR-------------------------------------------------------------===//
; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(readwrite, inaccessiblemem: none)
define void @add_kernel(ptr %0, ptr %1, ptr %2, i32 %3, i32 %4, i32 %5, i32 %6) local_unnamed_addr #0 !dbg !3 {
  %8 = shl i32 %4, 9, !dbg !6
  %9 = ptrtoint ptr %0 to i64, !dbg !7
  %10 = sext i32 %8 to i64, !dbg !8
  %11 = add i64 %10, %9, !dbg !8
  %12 = inttoptr i64 %11 to ptr, !dbg !8
  %13 = load <128 x float>, ptr %12, align 4, !dbg !8
  %14 = ptrtoint ptr %1 to i64, !dbg !9
  %15 = add i64 %10, %14, !dbg !10
  %16 = inttoptr i64 %15 to ptr, !dbg !10
  %17 = load <128 x float>, ptr %16, align 4, !dbg !10
  %18 = fadd <128 x float> %13, %17, !dbg !11
  %19 = ptrtoint ptr %2 to i64, !dbg !12
  %20 = add i64 %10, %19, !dbg !13
  %21 = inttoptr i64 %20 to ptr, !dbg !13
  store <128 x float> %18, ptr %21, align 4, !dbg !13
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
	shll	$9, %r8d
	.loc	1 61 16
	movslq	%r8d, %rax
	vmovups	384(%rax,%rdi), %zmm0
	vmovups	448(%rax,%rdi), %zmm1
	vmovups	256(%rax,%rdi), %zmm2
	vmovups	320(%rax,%rdi), %zmm3
	vmovups	(%rax,%rdi), %zmm4
	vmovups	64(%rax,%rdi), %zmm5
	vmovups	128(%rax,%rdi), %zmm6
	vmovups	192(%rax,%rdi), %zmm7
	.loc	1 63 17
	vaddps	64(%rax,%rsi), %zmm5, %zmm5
	vaddps	(%rax,%rsi), %zmm4, %zmm4
	vaddps	192(%rax,%rsi), %zmm7, %zmm7
	vaddps	128(%rax,%rsi), %zmm6, %zmm6
	vaddps	320(%rax,%rsi), %zmm3, %zmm3
	vaddps	256(%rax,%rsi), %zmm2, %zmm2
	vaddps	448(%rax,%rsi), %zmm1, %zmm1
	vaddps	384(%rax,%rsi), %zmm0, %zmm0
	.loc	1 65 35
	vmovups	%zmm0, 384(%rax,%rdx)
	vmovups	%zmm1, 448(%rax,%rdx)
	vmovups	%zmm2, 256(%rax,%rdx)
	vmovups	%zmm3, 320(%rax,%rdx)
	vmovups	%zmm6, 128(%rax,%rdx)
	vmovups	%zmm7, 192(%rax,%rdx)
	vmovups	%zmm4, (%rax,%rdx)
	vmovups	%zmm5, 64(%rax,%rdx)
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
