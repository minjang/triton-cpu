debug=0, cpu=1, program=python/tutorials/01-vector-add.py
NUM_ELEMENTS = 98432, BLOCK_SIZE = 512, MASK = True
//===--LLVM IR-------------------------------------------------------------===//
; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(readwrite, inaccessiblemem: none)
define void @add_kernel(ptr %0, ptr %1, ptr %2, i32 %3, i32 %4, i32 %5, i32 %6) local_unnamed_addr #0 !dbg !3 {
  %8 = shl i32 %4, 9, !dbg !6
  %9 = insertelement <512 x i32> poison, i32 %8, i64 0, !dbg !7
  %10 = shufflevector <512 x i32> %9, <512 x i32> poison, <512 x i32> zeroinitializer, !dbg !7
  %11 = or disjoint <512 x i32> %10, <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 30, i32 31, i32 32, i32 33, i32 34, i32 35, i32 36, i32 37, i32 38, i32 39, i32 40, i32 41, i32 42, i32 43, i32 44, i32 45, i32 46, i32 47, i32 48, i32 49, i32 50, i32 51, i32 52, i32 53, i32 54, i32 55, i32 56, i32 57, i32 58, i32 59, i32 60, i32 61, i32 62, i32 63, i32 64, i32 65, i32 66, i32 67, i32 68, i32 69, i32 70, i32 71, i32 72, i32 73, i32 74, i32 75, i32 76, i32 77, i32 78, i32 79, i32 80, i32 81, i32 82, i32 83, i32 84, i32 85, i32 86, i32 87, i32 88, i32 89, i32 90, i32 91, i32 92, i32 93, i32 94, i32 95, i32 96, i32 97, i32 98, i32 99, i32 100, i32 101, i32 102, i32 103, i32 104, i32 105, i32 106, i32 107, i32 108, i32 109, i32 110, i32 111, i32 112, i32 113, i32 114, i32 115, i32 116, i32 117, i32 118, i32 119, i32 120, i32 121, i32 122, i32 123, i32 124, i32 125, i32 126, i32 127, i32 128, i32 129, i32 130, i32 131, i32 132, i32 133, i32 134, i32 135, i32 136, i32 137, i32 138, i32 139, i32 140, i32 141, i32 142, i32 143, i32 144, i32 145, i32 146, i32 147, i32 148, i32 149, i32 150, i32 151, i32 152, i32 153, i32 154, i32 155, i32 156, i32 157, i32 158, i32 159, i32 160, i32 161, i32 162, i32 163, i32 164, i32 165, i32 166, i32 167, i32 168, i32 169, i32 170, i32 171, i32 172, i32 173, i32 174, i32 175, i32 176, i32 177, i32 178, i32 179, i32 180, i32 181, i32 182, i32 183, i32 184, i32 185, i32 186, i32 187, i32 188, i32 189, i32 190, i32 191, i32 192, i32 193, i32 194, i32 195, i32 196, i32 197, i32 198, i32 199, i32 200, i32 201, i32 202, i32 203, i32 204, i32 205, i32 206, i32 207, i32 208, i32 209, i32 210, i32 211, i32 212, i32 213, i32 214, i32 215, i32 216, i32 217, i32 218, i32 219, i32 220, i32 221, i32 222, i32 223, i32 224, i32 225, i32 226, i32 227, i32 228, i32 229, i32 230, i32 231, i32 232, i32 233, i32 234, i32 235, i32 236, i32 237, i32 238, i32 239, i32 240, i32 241, i32 242, i32 243, i32 244, i32 245, i32 246, i32 247, i32 248, i32 249, i32 250, i32 251, i32 252, i32 253, i32 254, i32 255, i32 256, i32 257, i32 258, i32 259, i32 260, i32 261, i32 262, i32 263, i32 264, i32 265, i32 266, i32 267, i32 268, i32 269, i32 270, i32 271, i32 272, i32 273, i32 274, i32 275, i32 276, i32 277, i32 278, i32 279, i32 280, i32 281, i32 282, i32 283, i32 284, i32 285, i32 286, i32 287, i32 288, i32 289, i32 290, i32 291, i32 292, i32 293, i32 294, i32 295, i32 296, i32 297, i32 298, i32 299, i32 300, i32 301, i32 302, i32 303, i32 304, i32 305, i32 306, i32 307, i32 308, i32 309, i32 310, i32 311, i32 312, i32 313, i32 314, i32 315, i32 316, i32 317, i32 318, i32 319, i32 320, i32 321, i32 322, i32 323, i32 324, i32 325, i32 326, i32 327, i32 328, i32 329, i32 330, i32 331, i32 332, i32 333, i32 334, i32 335, i32 336, i32 337, i32 338, i32 339, i32 340, i32 341, i32 342, i32 343, i32 344, i32 345, i32 346, i32 347, i32 348, i32 349, i32 350, i32 351, i32 352, i32 353, i32 354, i32 355, i32 356, i32 357, i32 358, i32 359, i32 360, i32 361, i32 362, i32 363, i32 364, i32 365, i32 366, i32 367, i32 368, i32 369, i32 370, i32 371, i32 372, i32 373, i32 374, i32 375, i32 376, i32 377, i32 378, i32 379, i32 380, i32 381, i32 382, i32 383, i32 384, i32 385, i32 386, i32 387, i32 388, i32 389, i32 390, i32 391, i32 392, i32 393, i32 394, i32 395, i32 396, i32 397, i32 398, i32 399, i32 400, i32 401, i32 402, i32 403, i32 404, i32 405, i32 406, i32 407, i32 408, i32 409, i32 410, i32 411, i32 412, i32 413, i32 414, i32 415, i32 416, i32 417, i32 418, i32 419, i32 420, i32 421, i32 422, i32 423, i32 424, i32 425, i32 426, i32 427, i32 428, i32 429, i32 430, i32 431, i32 432, i32 433, i32 434, i32 435, i32 436, i32 437, i32 438, i32 439, i32 440, i32 441, i32 442, i32 443, i32 444, i32 445, i32 446, i32 447, i32 448, i32 449, i32 450, i32 451, i32 452, i32 453, i32 454, i32 455, i32 456, i32 457, i32 458, i32 459, i32 460, i32 461, i32 462, i32 463, i32 464, i32 465, i32 466, i32 467, i32 468, i32 469, i32 470, i32 471, i32 472, i32 473, i32 474, i32 475, i32 476, i32 477, i32 478, i32 479, i32 480, i32 481, i32 482, i32 483, i32 484, i32 485, i32 486, i32 487, i32 488, i32 489, i32 490, i32 491, i32 492, i32 493, i32 494, i32 495, i32 496, i32 497, i32 498, i32 499, i32 500, i32 501, i32 502, i32 503, i32 504, i32 505, i32 506, i32 507, i32 508, i32 509, i32 510, i32 511>, !dbg !7
  %12 = insertelement <512 x i32> poison, i32 %3, i64 0, !dbg !8
  %13 = shufflevector <512 x i32> %12, <512 x i32> poison, <512 x i32> zeroinitializer, !dbg !8
  %14 = icmp slt <512 x i32> %11, %13, !dbg !8
  %15 = ptrtoint ptr %0 to i64, !dbg !9
  %16 = extractelement <512 x i32> %11, i64 0, !dbg !10
  %17 = shl i32 %16, 2, !dbg !10
  %18 = sext i32 %17 to i64, !dbg !10
  %19 = add i64 %18, %15, !dbg !10
  %20 = inttoptr i64 %19 to ptr, !dbg !10
  %21 = tail call <512 x float> @llvm.masked.load.v512f32.p0(ptr %20, i32 4, <512 x i1> %14, <512 x float> zeroinitializer), !dbg !10
  %22 = ptrtoint ptr %1 to i64, !dbg !11
  %23 = add i64 %18, %22, !dbg !12
  %24 = inttoptr i64 %23 to ptr, !dbg !12
  %25 = tail call <512 x float> @llvm.masked.load.v512f32.p0(ptr %24, i32 4, <512 x i1> %14, <512 x float> zeroinitializer), !dbg !12
  %26 = fadd <512 x float> %21, %25, !dbg !13
  %27 = ptrtoint ptr %2 to i64, !dbg !14
  %28 = add i64 %18, %27, !dbg !15
  %29 = inttoptr i64 %28 to ptr, !dbg !15
  tail call void @llvm.masked.store.v512f32.p0(<512 x float> %26, ptr %29, i32 4, <512 x i1> %14), !dbg !15
  ret void, !dbg !16
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <512 x float> @llvm.masked.load.v512f32.p0(ptr nocapture, i32 immarg, <512 x i1>, <512 x float>) #1

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.masked.store.v512f32.p0(<512 x float>, ptr nocapture, i32 immarg, <512 x i1>) #2

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
	.long	496
	.long	497
	.long	498
	.long	499
	.long	500
	.long	501
	.long	502
	.long	503
	.long	504
	.long	505
	.long	506
	.long	507
	.long	508
	.long	509
	.long	510
	.long	511
.LCPI0_1:
	.long	480
	.long	481
	.long	482
	.long	483
	.long	484
	.long	485
	.long	486
	.long	487
	.long	488
	.long	489
	.long	490
	.long	491
	.long	492
	.long	493
	.long	494
	.long	495
.LCPI0_2:
	.long	464
	.long	465
	.long	466
	.long	467
	.long	468
	.long	469
	.long	470
	.long	471
	.long	472
	.long	473
	.long	474
	.long	475
	.long	476
	.long	477
	.long	478
	.long	479
.LCPI0_3:
	.long	448
	.long	449
	.long	450
	.long	451
	.long	452
	.long	453
	.long	454
	.long	455
	.long	456
	.long	457
	.long	458
	.long	459
	.long	460
	.long	461
	.long	462
	.long	463
.LCPI0_4:
	.long	432
	.long	433
	.long	434
	.long	435
	.long	436
	.long	437
	.long	438
	.long	439
	.long	440
	.long	441
	.long	442
	.long	443
	.long	444
	.long	445
	.long	446
	.long	447
.LCPI0_5:
	.long	416
	.long	417
	.long	418
	.long	419
	.long	420
	.long	421
	.long	422
	.long	423
	.long	424
	.long	425
	.long	426
	.long	427
	.long	428
	.long	429
	.long	430
	.long	431
.LCPI0_6:
	.long	400
	.long	401
	.long	402
	.long	403
	.long	404
	.long	405
	.long	406
	.long	407
	.long	408
	.long	409
	.long	410
	.long	411
	.long	412
	.long	413
	.long	414
	.long	415
.LCPI0_7:
	.long	384
	.long	385
	.long	386
	.long	387
	.long	388
	.long	389
	.long	390
	.long	391
	.long	392
	.long	393
	.long	394
	.long	395
	.long	396
	.long	397
	.long	398
	.long	399
.LCPI0_8:
	.long	368
	.long	369
	.long	370
	.long	371
	.long	372
	.long	373
	.long	374
	.long	375
	.long	376
	.long	377
	.long	378
	.long	379
	.long	380
	.long	381
	.long	382
	.long	383
.LCPI0_9:
	.long	352
	.long	353
	.long	354
	.long	355
	.long	356
	.long	357
	.long	358
	.long	359
	.long	360
	.long	361
	.long	362
	.long	363
	.long	364
	.long	365
	.long	366
	.long	367
.LCPI0_10:
	.long	336
	.long	337
	.long	338
	.long	339
	.long	340
	.long	341
	.long	342
	.long	343
	.long	344
	.long	345
	.long	346
	.long	347
	.long	348
	.long	349
	.long	350
	.long	351
.LCPI0_11:
	.long	320
	.long	321
	.long	322
	.long	323
	.long	324
	.long	325
	.long	326
	.long	327
	.long	328
	.long	329
	.long	330
	.long	331
	.long	332
	.long	333
	.long	334
	.long	335
.LCPI0_12:
	.long	304
	.long	305
	.long	306
	.long	307
	.long	308
	.long	309
	.long	310
	.long	311
	.long	312
	.long	313
	.long	314
	.long	315
	.long	316
	.long	317
	.long	318
	.long	319
.LCPI0_13:
	.long	288
	.long	289
	.long	290
	.long	291
	.long	292
	.long	293
	.long	294
	.long	295
	.long	296
	.long	297
	.long	298
	.long	299
	.long	300
	.long	301
	.long	302
	.long	303
.LCPI0_14:
	.long	272
	.long	273
	.long	274
	.long	275
	.long	276
	.long	277
	.long	278
	.long	279
	.long	280
	.long	281
	.long	282
	.long	283
	.long	284
	.long	285
	.long	286
	.long	287
.LCPI0_15:
	.long	256
	.long	257
	.long	258
	.long	259
	.long	260
	.long	261
	.long	262
	.long	263
	.long	264
	.long	265
	.long	266
	.long	267
	.long	268
	.long	269
	.long	270
	.long	271
.LCPI0_16:
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
.LCPI0_17:
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
.LCPI0_18:
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
.LCPI0_19:
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
.LCPI0_20:
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
.LCPI0_21:
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
.LCPI0_22:
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
.LCPI0_23:
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
.LCPI0_24:
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
.LCPI0_25:
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
.LCPI0_26:
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
.LCPI0_27:
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
.LCPI0_28:
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
.LCPI0_29:
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
.LCPI0_30:
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
.LCPI0_31:
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
	.file	1 "/data/users/minjang/triton-oss/triton-cpu-minjang/python/tutorials" "01-vector-add.py"
	.cfi_sections .debug_frame
	.cfi_startproc
	subq	$1928, %rsp
	.cfi_def_cfa_offset 1936
.Ltmp0:
	movl	%r8d, %eax
	shll	$9, %eax
	vpbroadcastd	%ecx, %zmm29
	shll	$11, %r8d
	vpbroadcastd	%eax, %zmm0
	vpord	.LCPI0_1(%rip), %zmm0, %zmm2
	vpord	.LCPI0_2(%rip), %zmm0, %zmm3
	vpord	.LCPI0_3(%rip), %zmm0, %zmm4
	movslq	%r8d, %rax
	vpord	.LCPI0_4(%rip), %zmm0, %zmm5
	vpord	.LCPI0_5(%rip), %zmm0, %zmm30
	vpord	.LCPI0_6(%rip), %zmm0, %zmm31
	vpord	.LCPI0_7(%rip), %zmm0, %zmm28
	vpord	.LCPI0_0(%rip), %zmm0, %zmm1
	vpord	.LCPI0_8(%rip), %zmm0, %zmm6
	vpord	.LCPI0_9(%rip), %zmm0, %zmm7
	vpord	.LCPI0_10(%rip), %zmm0, %zmm8
	vpord	.LCPI0_11(%rip), %zmm0, %zmm9
	vpord	.LCPI0_12(%rip), %zmm0, %zmm10
	vpord	.LCPI0_13(%rip), %zmm0, %zmm11
	vpord	.LCPI0_14(%rip), %zmm0, %zmm12
	vpord	.LCPI0_15(%rip), %zmm0, %zmm13
	vpord	.LCPI0_16(%rip), %zmm0, %zmm14
	vpord	.LCPI0_17(%rip), %zmm0, %zmm15
	vpord	.LCPI0_18(%rip), %zmm0, %zmm16
	vpord	.LCPI0_19(%rip), %zmm0, %zmm17
	vpord	.LCPI0_20(%rip), %zmm0, %zmm18
	vpord	.LCPI0_21(%rip), %zmm0, %zmm19
	vpord	.LCPI0_22(%rip), %zmm0, %zmm20
	vpord	.LCPI0_23(%rip), %zmm0, %zmm21
	vpord	.LCPI0_24(%rip), %zmm0, %zmm22
	vpord	.LCPI0_25(%rip), %zmm0, %zmm23
	vpord	.LCPI0_26(%rip), %zmm0, %zmm24
	vpord	.LCPI0_28(%rip), %zmm0, %zmm26
	vpord	.LCPI0_27(%rip), %zmm0, %zmm25
	vpord	.LCPI0_29(%rip), %zmm0, %zmm27
	vpcmpgtd	%zmm2, %zmm29, %k7
	vpcmpgtd	%zmm3, %zmm29, %k6
	vpcmpgtd	%zmm4, %zmm29, %k5
	vpcmpgtd	%zmm5, %zmm29, %k4
	vpcmpgtd	%zmm30, %zmm29, %k3
	vpcmpgtd	%zmm31, %zmm29, %k2
	vpcmpgtd	%zmm28, %zmm29, %k1
	vpord	.LCPI0_30(%rip), %zmm0, %zmm28
	vpord	.LCPI0_31(%rip), %zmm0, %zmm0
	vmovups	1920(%rax,%rdi), %zmm3 {%k7} {z}
	vmovups	1856(%rax,%rdi), %zmm2 {%k6} {z}
	kmovw	%k1, -122(%rsp)
	kmovw	%k2, -120(%rsp)
	vpcmpgtd	%zmm1, %zmm29, %k1
	kmovw	%k7, -78(%rsp)
	vpcmpgtd	%zmm21, %zmm29, %k7
	kmovw	%k4, -80(%rsp)
	kmovw	%k6, -86(%rsp)
	kmovw	%k5, -84(%rsp)
	kmovw	%k3, -82(%rsp)
	vmovups	1984(%rax,%rdi), %zmm5 {%k1} {z}
	vmovups	1984(%rax,%rsi), %zmm30 {%k1} {z}
	kmovw	%k1, -66(%rsp)
	vpcmpgtd	%zmm6, %zmm29, %k1
	kmovw	-78(%rsp), %k6
	kmovw	%k7, -70(%rsp)
	kmovw	%k1, -116(%rsp)
	vmovups	%zmm3, 1600(%rsp)
	vmovups	1792(%rax,%rdi), %zmm3 {%k5} {z}
	vmovups	%zmm2, 1664(%rsp)
	vmovups	1728(%rax,%rdi), %zmm2 {%k4} {z}
	vpcmpgtd	%zmm26, %zmm29, %k4
	vpcmpgtd	%zmm25, %zmm29, %k5
	vaddps	%zmm30, %zmm5, %zmm31
	vmovups	256(%rax,%rsi), %zmm26 {%k5} {z}
	vmovups	%zmm3, 1728(%rsp)
	vmovups	1664(%rax,%rdi), %zmm3 {%k3} {z}
	vmovups	%zmm2, 1792(%rsp)
	vmovups	1600(%rax,%rdi), %zmm2 {%k2} {z}
	kmovw	-122(%rsp), %k2
	vpcmpgtd	%zmm27, %zmm29, %k3
	vmovups	192(%rax,%rsi), %zmm27 {%k4} {z}
	kmovw	%k3, -68(%rsp)
	vmovups	1536(%rax,%rsi), %zmm6 {%k2} {z}
	vmovups	%zmm3, 1856(%rsp)
	vmovups	1536(%rax,%rdi), %zmm3 {%k2} {z}
	vmovups	%zmm2, -64(%rsp)
	vmovups	1472(%rax,%rdi), %zmm2 {%k1} {z}
	vpcmpgtd	%zmm7, %zmm29, %k1
	kmovw	-116(%rsp), %k2
	kmovw	%k1, -114(%rsp)
	vmovups	1472(%rax,%rsi), %zmm7 {%k2} {z}
	kmovw	-114(%rsp), %k2
	vmovups	%zmm3, 1536(%rsp)
	vmovups	1408(%rax,%rdi), %zmm3 {%k1} {z}
	vpcmpgtd	%zmm8, %zmm29, %k1
	vmovups	%zmm2, 1472(%rsp)
	vmovups	1344(%rax,%rdi), %zmm2 {%k1} {z}
	kmovw	%k1, -112(%rsp)
	vpcmpgtd	%zmm9, %zmm29, %k1
	kmovw	%k1, -110(%rsp)
	vmovups	1408(%rax,%rsi), %zmm8 {%k2} {z}
	kmovw	-112(%rsp), %k2
	vmovups	1344(%rax,%rsi), %zmm9 {%k2} {z}
	kmovw	-110(%rsp), %k2
	vmovups	%zmm3, 1408(%rsp)
	vmovups	1280(%rax,%rdi), %zmm3 {%k1} {z}
	vpcmpgtd	%zmm10, %zmm29, %k1
	vmovups	%zmm2, 1344(%rsp)
	vmovups	1216(%rax,%rdi), %zmm2 {%k1} {z}
	kmovw	%k1, -108(%rsp)
	vpcmpgtd	%zmm11, %zmm29, %k1
	kmovw	%k1, -106(%rsp)
	vmovups	1280(%rax,%rsi), %zmm10 {%k2} {z}
	kmovw	-108(%rsp), %k2
	vmovups	%zmm3, 1280(%rsp)
	vmovups	1152(%rax,%rdi), %zmm3 {%k1} {z}
	vpcmpgtd	%zmm12, %zmm29, %k1
	vmovups	%zmm2, 1216(%rsp)
	vmovups	1088(%rax,%rdi), %zmm2 {%k1} {z}
	kmovw	%k1, -104(%rsp)
	vpcmpgtd	%zmm13, %zmm29, %k1
	vmovups	1216(%rax,%rsi), %zmm11 {%k2} {z}
	kmovw	-106(%rsp), %k2
	kmovw	%k1, -102(%rsp)
	vmovups	1152(%rax,%rsi), %zmm12 {%k2} {z}
	kmovw	-104(%rsp), %k2
	vmovups	%zmm3, 1152(%rsp)
	vmovups	1024(%rax,%rdi), %zmm3 {%k1} {z}
	vpcmpgtd	%zmm14, %zmm29, %k1
	vmovups	%zmm2, 1088(%rsp)
	vmovups	960(%rax,%rdi), %zmm2 {%k1} {z}
	kmovw	%k1, -100(%rsp)
	vpcmpgtd	%zmm15, %zmm29, %k1
	kmovw	%k1, -98(%rsp)
	vmovups	1088(%rax,%rsi), %zmm13 {%k2} {z}
	kmovw	-102(%rsp), %k2
	vmovups	%zmm3, 1024(%rsp)
	vmovups	896(%rax,%rdi), %zmm3 {%k1} {z}
	vpcmpgtd	%zmm16, %zmm29, %k1
	vmovups	1024(%rax,%rsi), %zmm14 {%k2} {z}
	kmovw	-100(%rsp), %k2
	vmovups	%zmm2, 960(%rsp)
	vmovups	832(%rax,%rdi), %zmm2 {%k1} {z}
	kmovw	%k1, -96(%rsp)
	vpcmpgtd	%zmm17, %zmm29, %k1
	kmovw	%k1, -94(%rsp)
	vmovups	960(%rax,%rsi), %zmm15 {%k2} {z}
	kmovw	-98(%rsp), %k2
	vmovups	%zmm3, 896(%rsp)
	vmovups	768(%rax,%rdi), %zmm3 {%k1} {z}
	vpcmpgtd	%zmm18, %zmm29, %k1
	vmovups	%zmm2, 832(%rsp)
	vmovups	704(%rax,%rdi), %zmm2 {%k1} {z}
	kmovw	%k1, -92(%rsp)
	vpcmpgtd	%zmm19, %zmm29, %k1
	kmovw	%k1, -90(%rsp)
	vmovups	896(%rax,%rsi), %zmm16 {%k2} {z}
	kmovw	-96(%rsp), %k2
	vmovups	832(%rax,%rsi), %zmm17 {%k2} {z}
	kmovw	-94(%rsp), %k2
	vmovups	%zmm3, 768(%rsp)
	vmovups	640(%rax,%rdi), %zmm3 {%k1} {z}
	vpcmpgtd	%zmm20, %zmm29, %k1
	vmovups	%zmm2, 704(%rsp)
	vmovups	576(%rax,%rdi), %zmm2 {%k1} {z}
	kmovw	%k1, -88(%rsp)
	vpcmpgtd	%zmm22, %zmm29, %k1
	vmovups	512(%rax,%rsi), %zmm22 {%k7} {z}
	kmovw	%k1, -74(%rsp)
	vmovups	768(%rax,%rsi), %zmm18 {%k2} {z}
	kmovw	-92(%rsp), %k2
	vmovups	%zmm3, 640(%rsp)
	vmovups	512(%rax,%rdi), %zmm3 {%k7} {z}
	vmovups	%zmm2, 576(%rsp)
	vmovups	448(%rax,%rdi), %zmm2 {%k1} {z}
	vpcmpgtd	%zmm23, %zmm29, %k1
	vmovups	704(%rax,%rsi), %zmm19 {%k2} {z}
	kmovw	-90(%rsp), %k2
	kmovw	%k1, -118(%rsp)
	vmovups	640(%rax,%rsi), %zmm20 {%k2} {z}
	kmovw	-88(%rsp), %k2
	vmovups	%zmm3, 512(%rsp)
	vmovups	384(%rax,%rdi), %zmm3 {%k1} {z}
	vpcmpgtd	%zmm24, %zmm29, %k1
	vmovups	%zmm2, 448(%rsp)
	vmovups	320(%rax,%rdi), %zmm2 {%k1} {z}
	kmovw	%k1, -76(%rsp)
	vpcmpgtd	%zmm28, %zmm29, %k1
	vmovups	128(%rax,%rsi), %zmm28 {%k3} {z}
	kmovw	%k1, -72(%rsp)
	kmovw	-76(%rsp), %k7
	vmovups	576(%rax,%rsi), %zmm21 {%k2} {z}
	kmovw	-118(%rsp), %k2
	vmovups	320(%rax,%rsi), %zmm25 {%k7} {z}
	vmovups	%zmm3, 384(%rsp)
	vmovups	256(%rax,%rdi), %zmm3 {%k5} {z}
	vmovups	384(%rax,%rsi), %zmm24 {%k2} {z}
	kmovw	-66(%rsp), %k2
	vmovups	%zmm2, 320(%rsp)
	vmovups	192(%rax,%rdi), %zmm2 {%k4} {z}
	vmovups	%zmm3, 256(%rsp)
	vmovups	128(%rax,%rdi), %zmm3 {%k3} {z}
	kmovw	-72(%rsp), %k3
	vmovups	%zmm2, 192(%rsp)
	vmovups	64(%rax,%rdi), %zmm2 {%k1} {z}
	vpcmpgtd	%zmm0, %zmm29, %k1
	vmovups	(%rax,%rdi), %zmm0 {%k1} {z}
	vmovups	(%rax,%rsi), %zmm30 {%k1} {z}
	vmovups	64(%rax,%rsi), %zmm29 {%k3} {z}
	vmovups	%zmm3, 128(%rsp)
	vmovups	%zmm2, 64(%rsp)
	vmovups	%zmm0, (%rsp)
	vmovups	1920(%rax,%rsi), %zmm0 {%k6} {z}
	kmovw	-86(%rsp), %k6
	vaddps	1600(%rsp), %zmm0, %zmm0
	vmovups	1856(%rax,%rsi), %zmm1 {%k6} {z}
	kmovw	-84(%rsp), %k6
	vmovups	1792(%rax,%rsi), %zmm2 {%k6} {z}
	kmovw	-80(%rsp), %k6
	vmovups	1728(%rax,%rsi), %zmm3 {%k6} {z}
	kmovw	-82(%rsp), %k6
	vmovups	1664(%rax,%rsi), %zmm4 {%k6} {z}
	kmovw	-120(%rsp), %k6
	vmovups	1600(%rax,%rsi), %zmm5 {%k6} {z}
	kmovw	-74(%rsp), %k6
	vmovups	448(%rax,%rsi), %zmm23 {%k6} {z}
	vmovups	%zmm31, 1984(%rax,%rdx) {%k2}
	kmovw	-78(%rsp), %k2
	vaddps	1664(%rsp), %zmm1, %zmm31
	vaddps	1728(%rsp), %zmm2, %zmm1
	vaddps	1792(%rsp), %zmm3, %zmm2
	vmovups	%zmm0, 1920(%rax,%rdx) {%k2}
	kmovw	-86(%rsp), %k2
	vmovups	%zmm31, 1856(%rax,%rdx) {%k2}
	kmovw	-84(%rsp), %k2
	vmovups	%zmm1, 1792(%rax,%rdx) {%k2}
	kmovw	-80(%rsp), %k2
	vaddps	1856(%rsp), %zmm4, %zmm1
	vmovups	%zmm2, 1728(%rax,%rdx) {%k2}
	kmovw	-82(%rsp), %k2
	vaddps	-64(%rsp), %zmm5, %zmm2
	vmovups	%zmm1, 1664(%rax,%rdx) {%k2}
	kmovw	-120(%rsp), %k2
	vaddps	1536(%rsp), %zmm6, %zmm1
	vmovups	%zmm2, 1600(%rax,%rdx) {%k2}
	kmovw	-122(%rsp), %k2
	vaddps	1472(%rsp), %zmm7, %zmm2
	vmovups	%zmm1, 1536(%rax,%rdx) {%k2}
	kmovw	-116(%rsp), %k2
	vaddps	1408(%rsp), %zmm8, %zmm1
	vmovups	%zmm2, 1472(%rax,%rdx) {%k2}
	kmovw	-114(%rsp), %k2
	vaddps	1344(%rsp), %zmm9, %zmm2
	vmovups	%zmm1, 1408(%rax,%rdx) {%k2}
	kmovw	-112(%rsp), %k2
	vaddps	1280(%rsp), %zmm10, %zmm1
	vmovups	%zmm2, 1344(%rax,%rdx) {%k2}
	kmovw	-110(%rsp), %k2
	vaddps	1216(%rsp), %zmm11, %zmm2
	vmovups	%zmm1, 1280(%rax,%rdx) {%k2}
	kmovw	-108(%rsp), %k2
	vaddps	1152(%rsp), %zmm12, %zmm1
	vmovups	%zmm2, 1216(%rax,%rdx) {%k2}
	kmovw	-106(%rsp), %k2
	vaddps	1088(%rsp), %zmm13, %zmm2
	vmovups	%zmm1, 1152(%rax,%rdx) {%k2}
	kmovw	-104(%rsp), %k2
	vaddps	1024(%rsp), %zmm14, %zmm1
	vmovups	%zmm2, 1088(%rax,%rdx) {%k2}
	kmovw	-102(%rsp), %k2
	vaddps	960(%rsp), %zmm15, %zmm2
	vmovups	%zmm1, 1024(%rax,%rdx) {%k2}
	kmovw	-100(%rsp), %k2
	vaddps	896(%rsp), %zmm16, %zmm1
	vmovups	%zmm2, 960(%rax,%rdx) {%k2}
	kmovw	-98(%rsp), %k2
	vaddps	832(%rsp), %zmm17, %zmm2
	vmovups	%zmm1, 896(%rax,%rdx) {%k2}
	kmovw	-96(%rsp), %k2
	vaddps	768(%rsp), %zmm18, %zmm1
	vmovups	%zmm2, 832(%rax,%rdx) {%k2}
	kmovw	-94(%rsp), %k2
	vaddps	704(%rsp), %zmm19, %zmm2
	vmovups	%zmm1, 768(%rax,%rdx) {%k2}
	kmovw	-92(%rsp), %k2
	vaddps	640(%rsp), %zmm20, %zmm1
	vmovups	%zmm2, 704(%rax,%rdx) {%k2}
	kmovw	-90(%rsp), %k2
	vaddps	576(%rsp), %zmm21, %zmm2
	vmovups	%zmm1, 640(%rax,%rdx) {%k2}
	kmovw	-88(%rsp), %k2
	vaddps	512(%rsp), %zmm22, %zmm1
	vmovups	%zmm2, 576(%rax,%rdx) {%k2}
	kmovw	-70(%rsp), %k2
	vaddps	448(%rsp), %zmm23, %zmm2
	vmovups	%zmm1, 512(%rax,%rdx) {%k2}
	vaddps	384(%rsp), %zmm24, %zmm1
	kmovw	-118(%rsp), %k2
	vmovups	%zmm2, 448(%rax,%rdx) {%k6}
	vaddps	320(%rsp), %zmm25, %zmm2
	vmovups	%zmm1, 384(%rax,%rdx) {%k2}
	vaddps	256(%rsp), %zmm26, %zmm1
	kmovw	-68(%rsp), %k2
	vmovups	%zmm2, 320(%rax,%rdx) {%k7}
	vaddps	192(%rsp), %zmm27, %zmm2
	vmovups	%zmm1, 256(%rax,%rdx) {%k5}
	vaddps	128(%rsp), %zmm28, %zmm1
	vmovups	%zmm2, 192(%rax,%rdx) {%k4}
	vaddps	64(%rsp), %zmm29, %zmm2
	vmovups	%zmm1, 128(%rax,%rdx) {%k2}
	vaddps	(%rsp), %zmm30, %zmm1
	vmovups	%zmm2, 64(%rax,%rdx) {%k3}
	vmovups	%zmm1, (%rax,%rdx) {%k1}
	addq	$1928, %rsp
	.cfi_def_cfa_offset 8
	vzeroupper
	retq
.Ltmp1:
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
