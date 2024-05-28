debug=0, cpu=1, program=python/tutorials/01-vector-add.py
NUM_ELEMENTS = 98432, BLOCK_SIZE = 1024, MASK = True
//===--LLVM IR-------------------------------------------------------------===//
; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(readwrite, inaccessiblemem: none)
define void @add_kernel(ptr %0, ptr %1, ptr %2, i32 %3, i32 %4, i32 %5, i32 %6) local_unnamed_addr #0 !dbg !3 {
  %8 = shl i32 %4, 10, !dbg !6
  %9 = insertelement <1024 x i32> poison, i32 %8, i64 0, !dbg !7
  %10 = shufflevector <1024 x i32> %9, <1024 x i32> poison, <1024 x i32> zeroinitializer, !dbg !7
  %11 = or disjoint <1024 x i32> %10, <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 30, i32 31, i32 32, i32 33, i32 34, i32 35, i32 36, i32 37, i32 38, i32 39, i32 40, i32 41, i32 42, i32 43, i32 44, i32 45, i32 46, i32 47, i32 48, i32 49, i32 50, i32 51, i32 52, i32 53, i32 54, i32 55, i32 56, i32 57, i32 58, i32 59, i32 60, i32 61, i32 62, i32 63, i32 64, i32 65, i32 66, i32 67, i32 68, i32 69, i32 70, i32 71, i32 72, i32 73, i32 74, i32 75, i32 76, i32 77, i32 78, i32 79, i32 80, i32 81, i32 82, i32 83, i32 84, i32 85, i32 86, i32 87, i32 88, i32 89, i32 90, i32 91, i32 92, i32 93, i32 94, i32 95, i32 96, i32 97, i32 98, i32 99, i32 100, i32 101, i32 102, i32 103, i32 104, i32 105, i32 106, i32 107, i32 108, i32 109, i32 110, i32 111, i32 112, i32 113, i32 114, i32 115, i32 116, i32 117, i32 118, i32 119, i32 120, i32 121, i32 122, i32 123, i32 124, i32 125, i32 126, i32 127, i32 128, i32 129, i32 130, i32 131, i32 132, i32 133, i32 134, i32 135, i32 136, i32 137, i32 138, i32 139, i32 140, i32 141, i32 142, i32 143, i32 144, i32 145, i32 146, i32 147, i32 148, i32 149, i32 150, i32 151, i32 152, i32 153, i32 154, i32 155, i32 156, i32 157, i32 158, i32 159, i32 160, i32 161, i32 162, i32 163, i32 164, i32 165, i32 166, i32 167, i32 168, i32 169, i32 170, i32 171, i32 172, i32 173, i32 174, i32 175, i32 176, i32 177, i32 178, i32 179, i32 180, i32 181, i32 182, i32 183, i32 184, i32 185, i32 186, i32 187, i32 188, i32 189, i32 190, i32 191, i32 192, i32 193, i32 194, i32 195, i32 196, i32 197, i32 198, i32 199, i32 200, i32 201, i32 202, i32 203, i32 204, i32 205, i32 206, i32 207, i32 208, i32 209, i32 210, i32 211, i32 212, i32 213, i32 214, i32 215, i32 216, i32 217, i32 218, i32 219, i32 220, i32 221, i32 222, i32 223, i32 224, i32 225, i32 226, i32 227, i32 228, i32 229, i32 230, i32 231, i32 232, i32 233, i32 234, i32 235, i32 236, i32 237, i32 238, i32 239, i32 240, i32 241, i32 242, i32 243, i32 244, i32 245, i32 246, i32 247, i32 248, i32 249, i32 250, i32 251, i32 252, i32 253, i32 254, i32 255, i32 256, i32 257, i32 258, i32 259, i32 260, i32 261, i32 262, i32 263, i32 264, i32 265, i32 266, i32 267, i32 268, i32 269, i32 270, i32 271, i32 272, i32 273, i32 274, i32 275, i32 276, i32 277, i32 278, i32 279, i32 280, i32 281, i32 282, i32 283, i32 284, i32 285, i32 286, i32 287, i32 288, i32 289, i32 290, i32 291, i32 292, i32 293, i32 294, i32 295, i32 296, i32 297, i32 298, i32 299, i32 300, i32 301, i32 302, i32 303, i32 304, i32 305, i32 306, i32 307, i32 308, i32 309, i32 310, i32 311, i32 312, i32 313, i32 314, i32 315, i32 316, i32 317, i32 318, i32 319, i32 320, i32 321, i32 322, i32 323, i32 324, i32 325, i32 326, i32 327, i32 328, i32 329, i32 330, i32 331, i32 332, i32 333, i32 334, i32 335, i32 336, i32 337, i32 338, i32 339, i32 340, i32 341, i32 342, i32 343, i32 344, i32 345, i32 346, i32 347, i32 348, i32 349, i32 350, i32 351, i32 352, i32 353, i32 354, i32 355, i32 356, i32 357, i32 358, i32 359, i32 360, i32 361, i32 362, i32 363, i32 364, i32 365, i32 366, i32 367, i32 368, i32 369, i32 370, i32 371, i32 372, i32 373, i32 374, i32 375, i32 376, i32 377, i32 378, i32 379, i32 380, i32 381, i32 382, i32 383, i32 384, i32 385, i32 386, i32 387, i32 388, i32 389, i32 390, i32 391, i32 392, i32 393, i32 394, i32 395, i32 396, i32 397, i32 398, i32 399, i32 400, i32 401, i32 402, i32 403, i32 404, i32 405, i32 406, i32 407, i32 408, i32 409, i32 410, i32 411, i32 412, i32 413, i32 414, i32 415, i32 416, i32 417, i32 418, i32 419, i32 420, i32 421, i32 422, i32 423, i32 424, i32 425, i32 426, i32 427, i32 428, i32 429, i32 430, i32 431, i32 432, i32 433, i32 434, i32 435, i32 436, i32 437, i32 438, i32 439, i32 440, i32 441, i32 442, i32 443, i32 444, i32 445, i32 446, i32 447, i32 448, i32 449, i32 450, i32 451, i32 452, i32 453, i32 454, i32 455, i32 456, i32 457, i32 458, i32 459, i32 460, i32 461, i32 462, i32 463, i32 464, i32 465, i32 466, i32 467, i32 468, i32 469, i32 470, i32 471, i32 472, i32 473, i32 474, i32 475, i32 476, i32 477, i32 478, i32 479, i32 480, i32 481, i32 482, i32 483, i32 484, i32 485, i32 486, i32 487, i32 488, i32 489, i32 490, i32 491, i32 492, i32 493, i32 494, i32 495, i32 496, i32 497, i32 498, i32 499, i32 500, i32 501, i32 502, i32 503, i32 504, i32 505, i32 506, i32 507, i32 508, i32 509, i32 510, i32 511, i32 512, i32 513, i32 514, i32 515, i32 516, i32 517, i32 518, i32 519, i32 520, i32 521, i32 522, i32 523, i32 524, i32 525, i32 526, i32 527, i32 528, i32 529, i32 530, i32 531, i32 532, i32 533, i32 534, i32 535, i32 536, i32 537, i32 538, i32 539, i32 540, i32 541, i32 542, i32 543, i32 544, i32 545, i32 546, i32 547, i32 548, i32 549, i32 550, i32 551, i32 552, i32 553, i32 554, i32 555, i32 556, i32 557, i32 558, i32 559, i32 560, i32 561, i32 562, i32 563, i32 564, i32 565, i32 566, i32 567, i32 568, i32 569, i32 570, i32 571, i32 572, i32 573, i32 574, i32 575, i32 576, i32 577, i32 578, i32 579, i32 580, i32 581, i32 582, i32 583, i32 584, i32 585, i32 586, i32 587, i32 588, i32 589, i32 590, i32 591, i32 592, i32 593, i32 594, i32 595, i32 596, i32 597, i32 598, i32 599, i32 600, i32 601, i32 602, i32 603, i32 604, i32 605, i32 606, i32 607, i32 608, i32 609, i32 610, i32 611, i32 612, i32 613, i32 614, i32 615, i32 616, i32 617, i32 618, i32 619, i32 620, i32 621, i32 622, i32 623, i32 624, i32 625, i32 626, i32 627, i32 628, i32 629, i32 630, i32 631, i32 632, i32 633, i32 634, i32 635, i32 636, i32 637, i32 638, i32 639, i32 640, i32 641, i32 642, i32 643, i32 644, i32 645, i32 646, i32 647, i32 648, i32 649, i32 650, i32 651, i32 652, i32 653, i32 654, i32 655, i32 656, i32 657, i32 658, i32 659, i32 660, i32 661, i32 662, i32 663, i32 664, i32 665, i32 666, i32 667, i32 668, i32 669, i32 670, i32 671, i32 672, i32 673, i32 674, i32 675, i32 676, i32 677, i32 678, i32 679, i32 680, i32 681, i32 682, i32 683, i32 684, i32 685, i32 686, i32 687, i32 688, i32 689, i32 690, i32 691, i32 692, i32 693, i32 694, i32 695, i32 696, i32 697, i32 698, i32 699, i32 700, i32 701, i32 702, i32 703, i32 704, i32 705, i32 706, i32 707, i32 708, i32 709, i32 710, i32 711, i32 712, i32 713, i32 714, i32 715, i32 716, i32 717, i32 718, i32 719, i32 720, i32 721, i32 722, i32 723, i32 724, i32 725, i32 726, i32 727, i32 728, i32 729, i32 730, i32 731, i32 732, i32 733, i32 734, i32 735, i32 736, i32 737, i32 738, i32 739, i32 740, i32 741, i32 742, i32 743, i32 744, i32 745, i32 746, i32 747, i32 748, i32 749, i32 750, i32 751, i32 752, i32 753, i32 754, i32 755, i32 756, i32 757, i32 758, i32 759, i32 760, i32 761, i32 762, i32 763, i32 764, i32 765, i32 766, i32 767, i32 768, i32 769, i32 770, i32 771, i32 772, i32 773, i32 774, i32 775, i32 776, i32 777, i32 778, i32 779, i32 780, i32 781, i32 782, i32 783, i32 784, i32 785, i32 786, i32 787, i32 788, i32 789, i32 790, i32 791, i32 792, i32 793, i32 794, i32 795, i32 796, i32 797, i32 798, i32 799, i32 800, i32 801, i32 802, i32 803, i32 804, i32 805, i32 806, i32 807, i32 808, i32 809, i32 810, i32 811, i32 812, i32 813, i32 814, i32 815, i32 816, i32 817, i32 818, i32 819, i32 820, i32 821, i32 822, i32 823, i32 824, i32 825, i32 826, i32 827, i32 828, i32 829, i32 830, i32 831, i32 832, i32 833, i32 834, i32 835, i32 836, i32 837, i32 838, i32 839, i32 840, i32 841, i32 842, i32 843, i32 844, i32 845, i32 846, i32 847, i32 848, i32 849, i32 850, i32 851, i32 852, i32 853, i32 854, i32 855, i32 856, i32 857, i32 858, i32 859, i32 860, i32 861, i32 862, i32 863, i32 864, i32 865, i32 866, i32 867, i32 868, i32 869, i32 870, i32 871, i32 872, i32 873, i32 874, i32 875, i32 876, i32 877, i32 878, i32 879, i32 880, i32 881, i32 882, i32 883, i32 884, i32 885, i32 886, i32 887, i32 888, i32 889, i32 890, i32 891, i32 892, i32 893, i32 894, i32 895, i32 896, i32 897, i32 898, i32 899, i32 900, i32 901, i32 902, i32 903, i32 904, i32 905, i32 906, i32 907, i32 908, i32 909, i32 910, i32 911, i32 912, i32 913, i32 914, i32 915, i32 916, i32 917, i32 918, i32 919, i32 920, i32 921, i32 922, i32 923, i32 924, i32 925, i32 926, i32 927, i32 928, i32 929, i32 930, i32 931, i32 932, i32 933, i32 934, i32 935, i32 936, i32 937, i32 938, i32 939, i32 940, i32 941, i32 942, i32 943, i32 944, i32 945, i32 946, i32 947, i32 948, i32 949, i32 950, i32 951, i32 952, i32 953, i32 954, i32 955, i32 956, i32 957, i32 958, i32 959, i32 960, i32 961, i32 962, i32 963, i32 964, i32 965, i32 966, i32 967, i32 968, i32 969, i32 970, i32 971, i32 972, i32 973, i32 974, i32 975, i32 976, i32 977, i32 978, i32 979, i32 980, i32 981, i32 982, i32 983, i32 984, i32 985, i32 986, i32 987, i32 988, i32 989, i32 990, i32 991, i32 992, i32 993, i32 994, i32 995, i32 996, i32 997, i32 998, i32 999, i32 1000, i32 1001, i32 1002, i32 1003, i32 1004, i32 1005, i32 1006, i32 1007, i32 1008, i32 1009, i32 1010, i32 1011, i32 1012, i32 1013, i32 1014, i32 1015, i32 1016, i32 1017, i32 1018, i32 1019, i32 1020, i32 1021, i32 1022, i32 1023>, !dbg !7
  %12 = insertelement <1024 x i32> poison, i32 %3, i64 0, !dbg !8
  %13 = shufflevector <1024 x i32> %12, <1024 x i32> poison, <1024 x i32> zeroinitializer, !dbg !8
  %14 = icmp slt <1024 x i32> %11, %13, !dbg !8
  %15 = ptrtoint ptr %0 to i64, !dbg !9
  %16 = extractelement <1024 x i32> %11, i64 0, !dbg !10
  %17 = shl i32 %16, 2, !dbg !10
  %18 = sext i32 %17 to i64, !dbg !10
  %19 = add i64 %18, %15, !dbg !10
  %20 = inttoptr i64 %19 to ptr, !dbg !10
  %21 = tail call <1024 x float> @llvm.masked.load.v1024f32.p0(ptr %20, i32 4, <1024 x i1> %14, <1024 x float> zeroinitializer), !dbg !10
  %22 = ptrtoint ptr %1 to i64, !dbg !11
  %23 = add i64 %18, %22, !dbg !12
  %24 = inttoptr i64 %23 to ptr, !dbg !12
  %25 = tail call <1024 x float> @llvm.masked.load.v1024f32.p0(ptr %24, i32 4, <1024 x i1> %14, <1024 x float> zeroinitializer), !dbg !12
  %26 = fadd <1024 x float> %21, %25, !dbg !13
  %27 = ptrtoint ptr %2 to i64, !dbg !14
  %28 = add i64 %18, %27, !dbg !15
  %29 = inttoptr i64 %28 to ptr, !dbg !15
  tail call void @llvm.masked.store.v1024f32.p0(<1024 x float> %26, ptr %29, i32 4, <1024 x i1> %14), !dbg !15
  ret void, !dbg !16
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <1024 x float> @llvm.masked.load.v1024f32.p0(ptr nocapture, i32 immarg, <1024 x i1>, <1024 x float>) #1

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.masked.store.v1024f32.p0(<1024 x float>, ptr nocapture, i32 immarg, <1024 x i1>) #2

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
	.long	1008
	.long	1009
	.long	1010
	.long	1011
	.long	1012
	.long	1013
	.long	1014
	.long	1015
	.long	1016
	.long	1017
	.long	1018
	.long	1019
	.long	1020
	.long	1021
	.long	1022
	.long	1023
.LCPI0_1:
	.long	992
	.long	993
	.long	994
	.long	995
	.long	996
	.long	997
	.long	998
	.long	999
	.long	1000
	.long	1001
	.long	1002
	.long	1003
	.long	1004
	.long	1005
	.long	1006
	.long	1007
.LCPI0_2:
	.long	976
	.long	977
	.long	978
	.long	979
	.long	980
	.long	981
	.long	982
	.long	983
	.long	984
	.long	985
	.long	986
	.long	987
	.long	988
	.long	989
	.long	990
	.long	991
.LCPI0_3:
	.long	960
	.long	961
	.long	962
	.long	963
	.long	964
	.long	965
	.long	966
	.long	967
	.long	968
	.long	969
	.long	970
	.long	971
	.long	972
	.long	973
	.long	974
	.long	975
.LCPI0_4:
	.long	944
	.long	945
	.long	946
	.long	947
	.long	948
	.long	949
	.long	950
	.long	951
	.long	952
	.long	953
	.long	954
	.long	955
	.long	956
	.long	957
	.long	958
	.long	959
.LCPI0_5:
	.long	928
	.long	929
	.long	930
	.long	931
	.long	932
	.long	933
	.long	934
	.long	935
	.long	936
	.long	937
	.long	938
	.long	939
	.long	940
	.long	941
	.long	942
	.long	943
.LCPI0_6:
	.long	912
	.long	913
	.long	914
	.long	915
	.long	916
	.long	917
	.long	918
	.long	919
	.long	920
	.long	921
	.long	922
	.long	923
	.long	924
	.long	925
	.long	926
	.long	927
.LCPI0_7:
	.long	896
	.long	897
	.long	898
	.long	899
	.long	900
	.long	901
	.long	902
	.long	903
	.long	904
	.long	905
	.long	906
	.long	907
	.long	908
	.long	909
	.long	910
	.long	911
.LCPI0_8:
	.long	880
	.long	881
	.long	882
	.long	883
	.long	884
	.long	885
	.long	886
	.long	887
	.long	888
	.long	889
	.long	890
	.long	891
	.long	892
	.long	893
	.long	894
	.long	895
.LCPI0_9:
	.long	864
	.long	865
	.long	866
	.long	867
	.long	868
	.long	869
	.long	870
	.long	871
	.long	872
	.long	873
	.long	874
	.long	875
	.long	876
	.long	877
	.long	878
	.long	879
.LCPI0_10:
	.long	848
	.long	849
	.long	850
	.long	851
	.long	852
	.long	853
	.long	854
	.long	855
	.long	856
	.long	857
	.long	858
	.long	859
	.long	860
	.long	861
	.long	862
	.long	863
.LCPI0_11:
	.long	832
	.long	833
	.long	834
	.long	835
	.long	836
	.long	837
	.long	838
	.long	839
	.long	840
	.long	841
	.long	842
	.long	843
	.long	844
	.long	845
	.long	846
	.long	847
.LCPI0_12:
	.long	816
	.long	817
	.long	818
	.long	819
	.long	820
	.long	821
	.long	822
	.long	823
	.long	824
	.long	825
	.long	826
	.long	827
	.long	828
	.long	829
	.long	830
	.long	831
.LCPI0_13:
	.long	800
	.long	801
	.long	802
	.long	803
	.long	804
	.long	805
	.long	806
	.long	807
	.long	808
	.long	809
	.long	810
	.long	811
	.long	812
	.long	813
	.long	814
	.long	815
.LCPI0_14:
	.long	784
	.long	785
	.long	786
	.long	787
	.long	788
	.long	789
	.long	790
	.long	791
	.long	792
	.long	793
	.long	794
	.long	795
	.long	796
	.long	797
	.long	798
	.long	799
.LCPI0_15:
	.long	768
	.long	769
	.long	770
	.long	771
	.long	772
	.long	773
	.long	774
	.long	775
	.long	776
	.long	777
	.long	778
	.long	779
	.long	780
	.long	781
	.long	782
	.long	783
.LCPI0_16:
	.long	752
	.long	753
	.long	754
	.long	755
	.long	756
	.long	757
	.long	758
	.long	759
	.long	760
	.long	761
	.long	762
	.long	763
	.long	764
	.long	765
	.long	766
	.long	767
.LCPI0_17:
	.long	736
	.long	737
	.long	738
	.long	739
	.long	740
	.long	741
	.long	742
	.long	743
	.long	744
	.long	745
	.long	746
	.long	747
	.long	748
	.long	749
	.long	750
	.long	751
.LCPI0_18:
	.long	720
	.long	721
	.long	722
	.long	723
	.long	724
	.long	725
	.long	726
	.long	727
	.long	728
	.long	729
	.long	730
	.long	731
	.long	732
	.long	733
	.long	734
	.long	735
.LCPI0_19:
	.long	704
	.long	705
	.long	706
	.long	707
	.long	708
	.long	709
	.long	710
	.long	711
	.long	712
	.long	713
	.long	714
	.long	715
	.long	716
	.long	717
	.long	718
	.long	719
.LCPI0_20:
	.long	688
	.long	689
	.long	690
	.long	691
	.long	692
	.long	693
	.long	694
	.long	695
	.long	696
	.long	697
	.long	698
	.long	699
	.long	700
	.long	701
	.long	702
	.long	703
.LCPI0_21:
	.long	672
	.long	673
	.long	674
	.long	675
	.long	676
	.long	677
	.long	678
	.long	679
	.long	680
	.long	681
	.long	682
	.long	683
	.long	684
	.long	685
	.long	686
	.long	687
.LCPI0_22:
	.long	656
	.long	657
	.long	658
	.long	659
	.long	660
	.long	661
	.long	662
	.long	663
	.long	664
	.long	665
	.long	666
	.long	667
	.long	668
	.long	669
	.long	670
	.long	671
.LCPI0_23:
	.long	640
	.long	641
	.long	642
	.long	643
	.long	644
	.long	645
	.long	646
	.long	647
	.long	648
	.long	649
	.long	650
	.long	651
	.long	652
	.long	653
	.long	654
	.long	655
.LCPI0_24:
	.long	624
	.long	625
	.long	626
	.long	627
	.long	628
	.long	629
	.long	630
	.long	631
	.long	632
	.long	633
	.long	634
	.long	635
	.long	636
	.long	637
	.long	638
	.long	639
.LCPI0_25:
	.long	608
	.long	609
	.long	610
	.long	611
	.long	612
	.long	613
	.long	614
	.long	615
	.long	616
	.long	617
	.long	618
	.long	619
	.long	620
	.long	621
	.long	622
	.long	623
.LCPI0_26:
	.long	592
	.long	593
	.long	594
	.long	595
	.long	596
	.long	597
	.long	598
	.long	599
	.long	600
	.long	601
	.long	602
	.long	603
	.long	604
	.long	605
	.long	606
	.long	607
.LCPI0_27:
	.long	576
	.long	577
	.long	578
	.long	579
	.long	580
	.long	581
	.long	582
	.long	583
	.long	584
	.long	585
	.long	586
	.long	587
	.long	588
	.long	589
	.long	590
	.long	591
.LCPI0_28:
	.long	560
	.long	561
	.long	562
	.long	563
	.long	564
	.long	565
	.long	566
	.long	567
	.long	568
	.long	569
	.long	570
	.long	571
	.long	572
	.long	573
	.long	574
	.long	575
.LCPI0_29:
	.long	544
	.long	545
	.long	546
	.long	547
	.long	548
	.long	549
	.long	550
	.long	551
	.long	552
	.long	553
	.long	554
	.long	555
	.long	556
	.long	557
	.long	558
	.long	559
.LCPI0_30:
	.long	528
	.long	529
	.long	530
	.long	531
	.long	532
	.long	533
	.long	534
	.long	535
	.long	536
	.long	537
	.long	538
	.long	539
	.long	540
	.long	541
	.long	542
	.long	543
.LCPI0_31:
	.long	512
	.long	513
	.long	514
	.long	515
	.long	516
	.long	517
	.long	518
	.long	519
	.long	520
	.long	521
	.long	522
	.long	523
	.long	524
	.long	525
	.long	526
	.long	527
.LCPI0_32:
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
.LCPI0_33:
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
.LCPI0_34:
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
.LCPI0_35:
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
.LCPI0_36:
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
.LCPI0_37:
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
.LCPI0_38:
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
.LCPI0_39:
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
.LCPI0_40:
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
.LCPI0_41:
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
.LCPI0_42:
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
.LCPI0_43:
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
.LCPI0_44:
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
.LCPI0_45:
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
.LCPI0_46:
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
.LCPI0_47:
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
.LCPI0_48:
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
.LCPI0_49:
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
.LCPI0_50:
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
.LCPI0_51:
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
.LCPI0_52:
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
.LCPI0_53:
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
.LCPI0_54:
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
.LCPI0_55:
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
.LCPI0_56:
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
.LCPI0_57:
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
.LCPI0_58:
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
.LCPI0_59:
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
.LCPI0_60:
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
.LCPI0_61:
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
.LCPI0_62:
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
.LCPI0_63:
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
	subq	$7704, %rsp
	.cfi_def_cfa_offset 7712
.Ltmp0:
	movl	%r8d, %eax
	shll	$10, %eax
	shll	$12, %r8d
	vpbroadcastd	%eax, %zmm1
	vpord	.LCPI0_8(%rip), %zmm1, %zmm0
	vpord	.LCPI0_1(%rip), %zmm1, %zmm6
	vpord	.LCPI0_7(%rip), %zmm1, %zmm29
	vpord	.LCPI0_2(%rip), %zmm1, %zmm4
	movslq	%r8d, %rax
	vpord	.LCPI0_3(%rip), %zmm1, %zmm3
	vpord	.LCPI0_4(%rip), %zmm1, %zmm2
	vpord	.LCPI0_5(%rip), %zmm1, %zmm20
	vpord	.LCPI0_6(%rip), %zmm1, %zmm21
	vpord	.LCPI0_0(%rip), %zmm1, %zmm5
	vpord	.LCPI0_9(%rip), %zmm1, %zmm7
	vpord	.LCPI0_10(%rip), %zmm1, %zmm8
	vpord	.LCPI0_31(%rip), %zmm1, %zmm30
	vpord	.LCPI0_32(%rip), %zmm1, %zmm31
	vpord	.LCPI0_43(%rip), %zmm1, %zmm9
	vpord	.LCPI0_44(%rip), %zmm1, %zmm10
	vpord	.LCPI0_45(%rip), %zmm1, %zmm11
	vpord	.LCPI0_46(%rip), %zmm1, %zmm12
	vpord	.LCPI0_47(%rip), %zmm1, %zmm13
	vpord	.LCPI0_48(%rip), %zmm1, %zmm14
	vpord	.LCPI0_49(%rip), %zmm1, %zmm15
	vpord	.LCPI0_50(%rip), %zmm1, %zmm16
	vpord	.LCPI0_51(%rip), %zmm1, %zmm17
	vpord	.LCPI0_52(%rip), %zmm1, %zmm18
	vpord	.LCPI0_53(%rip), %zmm1, %zmm19
	vpord	.LCPI0_56(%rip), %zmm1, %zmm22
	vpord	.LCPI0_57(%rip), %zmm1, %zmm23
	vpord	.LCPI0_58(%rip), %zmm1, %zmm24
	vpord	.LCPI0_59(%rip), %zmm1, %zmm25
	vpord	.LCPI0_60(%rip), %zmm1, %zmm26
	vpord	.LCPI0_61(%rip), %zmm1, %zmm27
	vpord	.LCPI0_62(%rip), %zmm1, %zmm28
	vmovdqu64	%zmm0, 144(%rsp)
	vpbroadcastd	%ecx, %zmm0
	vmovdqu64	%zmm7, 208(%rsp)
	vmovdqu64	%zmm8, 272(%rsp)
	vpord	.LCPI0_11(%rip), %zmm1, %zmm7
	vpord	.LCPI0_12(%rip), %zmm1, %zmm8
	vpcmpgtd	%zmm6, %zmm0, %k7
	vpcmpgtd	%zmm29, %zmm0, %k1
	vpcmpgtd	%zmm4, %zmm0, %k6
	vpcmpgtd	%zmm3, %zmm0, %k5
	vpcmpgtd	%zmm2, %zmm0, %k4
	vpord	.LCPI0_33(%rip), %zmm1, %zmm2
	vpcmpgtd	%zmm20, %zmm0, %k3
	vpcmpgtd	%zmm21, %zmm0, %k2
	vpord	.LCPI0_38(%rip), %zmm1, %zmm4
	vpord	.LCPI0_40(%rip), %zmm1, %zmm6
	vpord	.LCPI0_54(%rip), %zmm1, %zmm20
	vpord	.LCPI0_55(%rip), %zmm1, %zmm21
	vmovups	3968(%rax,%rdi), %zmm29 {%k7} {z}
	kmovw	%k1, -126(%rsp)
	vpcmpgtd	%zmm5, %zmm0, %k1
	vpord	.LCPI0_39(%rip), %zmm1, %zmm5
	kmovw	%k5, -124(%rsp)
	kmovw	%k4, -122(%rsp)
	kmovw	%k3, -120(%rsp)
	kmovw	%k2, -118(%rsp)
	kmovw	%k7, -62(%rsp)
	kmovw	%k6, -54(%rsp)
	kmovw	%k1, -50(%rsp)
	vmovups	4032(%rax,%rsi), %zmm3 {%k1} {z}
	vmovdqu64	%zmm7, 336(%rsp)
	vmovdqu64	%zmm8, 400(%rsp)
	vpord	.LCPI0_13(%rip), %zmm1, %zmm7
	vpord	.LCPI0_14(%rip), %zmm1, %zmm8
	vmovdqu64	%zmm2, 16(%rsp)
	vpord	.LCPI0_34(%rip), %zmm1, %zmm2
	vmovups	%zmm29, 3664(%rsp)
	vmovups	3904(%rax,%rdi), %zmm29 {%k6} {z}
	vmovdqu64	%zmm7, 464(%rsp)
	vmovdqu64	%zmm8, 528(%rsp)
	vpord	.LCPI0_15(%rip), %zmm1, %zmm7
	vpord	.LCPI0_16(%rip), %zmm1, %zmm8
	vmovdqu64	%zmm2, -48(%rsp)
	vpord	.LCPI0_35(%rip), %zmm1, %zmm2
	vmovups	%zmm29, 3728(%rsp)
	vmovups	3840(%rax,%rdi), %zmm29 {%k5} {z}
	vpcmpgtd	%zmm19, %zmm0, %k5
	kmovw	%k5, -60(%rsp)
	vmovdqu64	%zmm7, 592(%rsp)
	vmovdqu64	%zmm8, 656(%rsp)
	vpord	.LCPI0_17(%rip), %zmm1, %zmm7
	vpord	.LCPI0_18(%rip), %zmm1, %zmm8
	vmovdqu64	%zmm2, 1552(%rsp)
	vmovups	4032(%rax,%rdi), %zmm2 {%k1} {z}
	kmovw	-126(%rsp), %k1
	vmovups	%zmm29, 3792(%rsp)
	vmovups	3776(%rax,%rdi), %zmm29 {%k4} {z}
	vpcmpgtd	%zmm20, %zmm0, %k4
	kmovw	%k4, -58(%rsp)
	vmovdqu64	%zmm7, 720(%rsp)
	vmovdqu64	%zmm8, 784(%rsp)
	vpord	.LCPI0_19(%rip), %zmm1, %zmm7
	vpord	.LCPI0_20(%rip), %zmm1, %zmm8
	vaddps	%zmm3, %zmm2, %zmm2
	vpord	.LCPI0_37(%rip), %zmm1, %zmm3
	vmovups	%zmm29, 3856(%rsp)
	vmovups	3712(%rax,%rdi), %zmm29 {%k3} {z}
	vpcmpgtd	%zmm21, %zmm0, %k3
	kmovw	%k3, -56(%rsp)
	vmovups	%zmm2, 7632(%rsp)
	vpord	.LCPI0_36(%rip), %zmm1, %zmm2
	vmovdqu64	%zmm7, 848(%rsp)
	vmovdqu64	%zmm8, 912(%rsp)
	vpord	.LCPI0_21(%rip), %zmm1, %zmm7
	vpord	.LCPI0_22(%rip), %zmm1, %zmm8
	vmovups	%zmm29, 3920(%rsp)
	vmovups	3648(%rax,%rdi), %zmm29 {%k2} {z}
	kmovw	-124(%rsp), %k2
	vmovdqu64	%zmm7, 976(%rsp)
	vmovdqu64	%zmm8, 1040(%rsp)
	vpord	.LCPI0_23(%rip), %zmm1, %zmm7
	vpord	.LCPI0_24(%rip), %zmm1, %zmm8
	vmovups	%zmm29, 3984(%rsp)
	vmovups	3584(%rax,%rdi), %zmm29 {%k1} {z}
	vpcmpgtd	144(%rsp), %zmm0, %k1
	vmovdqu64	%zmm7, 1104(%rsp)
	vmovdqu64	%zmm8, 1168(%rsp)
	vpord	.LCPI0_25(%rip), %zmm1, %zmm7
	vpord	.LCPI0_26(%rip), %zmm1, %zmm8
	vmovups	%zmm29, 7568(%rsp)
	vmovups	3520(%rax,%rdi), %zmm29 {%k1} {z}
	kmovw	%k1, -116(%rsp)
	vpcmpgtd	208(%rsp), %zmm0, %k1
	vmovdqu64	%zmm7, 1232(%rsp)
	vmovdqu64	%zmm8, 1296(%rsp)
	vpord	.LCPI0_27(%rip), %zmm1, %zmm7
	vpord	.LCPI0_28(%rip), %zmm1, %zmm8
	vmovups	%zmm29, 7504(%rsp)
	vmovups	3456(%rax,%rdi), %zmm29 {%k1} {z}
	kmovw	%k1, -114(%rsp)
	vpcmpgtd	272(%rsp), %zmm0, %k1
	vmovdqu64	%zmm7, 1360(%rsp)
	vmovdqu64	%zmm8, 1424(%rsp)
	vpord	.LCPI0_29(%rip), %zmm1, %zmm7
	vpord	.LCPI0_42(%rip), %zmm1, %zmm8
	vmovups	%zmm29, 7440(%rsp)
	vmovups	3392(%rax,%rdi), %zmm29 {%k1} {z}
	kmovw	%k1, -112(%rsp)
	vpcmpgtd	336(%rsp), %zmm0, %k1
	vmovdqu64	%zmm7, 1488(%rsp)
	vpord	.LCPI0_30(%rip), %zmm1, %zmm7
	vmovups	%zmm29, 7376(%rsp)
	vmovups	3328(%rax,%rdi), %zmm29 {%k1} {z}
	kmovw	%k1, -110(%rsp)
	vpcmpgtd	400(%rsp), %zmm0, %k1
	vmovdqu64	%zmm7, 80(%rsp)
	vpord	.LCPI0_41(%rip), %zmm1, %zmm7
	vpord	.LCPI0_63(%rip), %zmm1, %zmm1
	vmovups	%zmm29, 7312(%rsp)
	vmovups	3264(%rax,%rdi), %zmm29 {%k1} {z}
	kmovw	%k1, -108(%rsp)
	vpcmpgtd	464(%rsp), %zmm0, %k1
	vmovups	%zmm29, 7248(%rsp)
	vmovups	3200(%rax,%rdi), %zmm29 {%k1} {z}
	kmovw	%k1, -106(%rsp)
	vpcmpgtd	528(%rsp), %zmm0, %k1
	vmovups	%zmm29, 7184(%rsp)
	vmovups	3136(%rax,%rdi), %zmm29 {%k1} {z}
	kmovw	%k1, -104(%rsp)
	vpcmpgtd	592(%rsp), %zmm0, %k1
	vmovups	%zmm29, 7120(%rsp)
	vmovups	3072(%rax,%rdi), %zmm29 {%k1} {z}
	kmovw	%k1, -102(%rsp)
	vpcmpgtd	656(%rsp), %zmm0, %k1
	vmovups	%zmm29, 7056(%rsp)
	vmovups	3008(%rax,%rdi), %zmm29 {%k1} {z}
	kmovw	%k1, -100(%rsp)
	vpcmpgtd	720(%rsp), %zmm0, %k1
	vmovups	%zmm29, 6992(%rsp)
	vmovups	2944(%rax,%rdi), %zmm29 {%k1} {z}
	kmovw	%k1, -98(%rsp)
	vpcmpgtd	784(%rsp), %zmm0, %k1
	vmovups	%zmm29, 6928(%rsp)
	vmovups	2880(%rax,%rdi), %zmm29 {%k1} {z}
	kmovw	%k1, -96(%rsp)
	vpcmpgtd	848(%rsp), %zmm0, %k1
	vmovups	%zmm29, 6864(%rsp)
	vmovups	2816(%rax,%rdi), %zmm29 {%k1} {z}
	kmovw	%k1, -94(%rsp)
	vpcmpgtd	912(%rsp), %zmm0, %k1
	vmovups	%zmm29, 6800(%rsp)
	vmovups	2752(%rax,%rdi), %zmm29 {%k1} {z}
	kmovw	%k1, -92(%rsp)
	vpcmpgtd	976(%rsp), %zmm0, %k1
	vmovups	%zmm29, 6736(%rsp)
	vmovups	2688(%rax,%rdi), %zmm29 {%k1} {z}
	kmovw	%k1, -90(%rsp)
	vpcmpgtd	1040(%rsp), %zmm0, %k1
	vmovups	%zmm29, 6672(%rsp)
	vmovups	2624(%rax,%rdi), %zmm29 {%k1} {z}
	kmovw	%k1, -88(%rsp)
	vpcmpgtd	1104(%rsp), %zmm0, %k1
	vmovups	%zmm29, 6608(%rsp)
	vmovups	2560(%rax,%rdi), %zmm29 {%k1} {z}
	kmovw	%k1, -86(%rsp)
	vpcmpgtd	1168(%rsp), %zmm0, %k1
	vmovups	%zmm29, 6544(%rsp)
	vmovups	2496(%rax,%rdi), %zmm29 {%k1} {z}
	kmovw	%k1, -84(%rsp)
	vpcmpgtd	1232(%rsp), %zmm0, %k1
	vmovups	%zmm29, 6480(%rsp)
	vmovups	2432(%rax,%rdi), %zmm29 {%k1} {z}
	kmovw	%k1, -82(%rsp)
	vpcmpgtd	1296(%rsp), %zmm0, %k1
	vmovups	%zmm29, 6416(%rsp)
	vmovups	2368(%rax,%rdi), %zmm29 {%k1} {z}
	kmovw	%k1, -80(%rsp)
	vpcmpgtd	1360(%rsp), %zmm0, %k1
	vmovups	%zmm29, 6352(%rsp)
	vmovups	2304(%rax,%rdi), %zmm29 {%k1} {z}
	kmovw	%k1, -78(%rsp)
	vpcmpgtd	1424(%rsp), %zmm0, %k1
	vmovups	%zmm29, 6288(%rsp)
	vmovups	2240(%rax,%rdi), %zmm29 {%k1} {z}
	kmovw	%k1, -76(%rsp)
	vpcmpgtd	1488(%rsp), %zmm0, %k1
	vmovups	%zmm29, 6224(%rsp)
	vmovups	2176(%rax,%rdi), %zmm29 {%k1} {z}
	kmovw	%k1, 144(%rsp)
	vpcmpgtd	80(%rsp), %zmm0, %k1
	vmovups	%zmm29, 6160(%rsp)
	vmovups	2112(%rax,%rdi), %zmm29 {%k1} {z}
	kmovw	%k1, 208(%rsp)
	vpcmpgtd	%zmm30, %zmm0, %k1
	kmovw	%k1, 272(%rsp)
	vmovups	%zmm29, 6096(%rsp)
	vmovups	2048(%rax,%rdi), %zmm29 {%k1} {z}
	vpcmpgtd	%zmm31, %zmm0, %k1
	vmovups	1984(%rax,%rdi), %zmm30 {%k1} {z}
	kmovw	%k1, 336(%rsp)
	vpcmpgtd	16(%rsp), %zmm0, %k1
	vmovups	%zmm29, 6032(%rsp)
	vmovups	1920(%rax,%rdi), %zmm29 {%k1} {z}
	kmovw	%k1, 400(%rsp)
	vpcmpgtd	-48(%rsp), %zmm0, %k1
	vmovups	%zmm30, 5968(%rsp)
	vmovups	%zmm29, 5904(%rsp)
	vmovups	1856(%rax,%rdi), %zmm29 {%k1} {z}
	kmovw	%k1, 464(%rsp)
	vpcmpgtd	1552(%rsp), %zmm0, %k1
	vmovups	%zmm29, 5840(%rsp)
	vmovups	1792(%rax,%rdi), %zmm29 {%k1} {z}
	kmovw	%k1, 528(%rsp)
	vpcmpgtd	%zmm2, %zmm0, %k1
	vmovups	1728(%rax,%rdi), %zmm2 {%k1} {z}
	kmovw	%k1, 592(%rsp)
	vpcmpgtd	%zmm3, %zmm0, %k1
	kmovw	%k1, 656(%rsp)
	vmovups	%zmm29, 1552(%rsp)
	vmovups	1664(%rax,%rdi), %zmm29 {%k1} {z}
	vpcmpgtd	%zmm4, %zmm0, %k1
	vmovups	1600(%rax,%rdi), %zmm3 {%k1} {z}
	kmovw	%k1, 720(%rsp)
	vpcmpgtd	%zmm5, %zmm0, %k1
	vmovups	%zmm2, 5776(%rsp)
	vmovups	3968(%rax,%rsi), %zmm2 {%k7} {z}
	vmovups	1536(%rax,%rdi), %zmm4 {%k1} {z}
	kmovw	%k1, 784(%rsp)
	vpcmpgtd	%zmm6, %zmm0, %k1
	vaddps	3664(%rsp), %zmm2, %zmm2
	kmovw	%k1, 848(%rsp)
	vmovups	%zmm29, 5712(%rsp)
	vmovups	%zmm3, 5648(%rsp)
	vmovups	1472(%rax,%rdi), %zmm3 {%k1} {z}
	vpcmpgtd	%zmm7, %zmm0, %k1
	vmovups	%zmm4, 5584(%rsp)
	vmovups	1408(%rax,%rdi), %zmm4 {%k1} {z}
	kmovw	%k1, 912(%rsp)
	vpcmpgtd	%zmm8, %zmm0, %k1
	kmovw	%k1, 976(%rsp)
	vmovups	%zmm3, 5520(%rsp)
	vmovups	1344(%rax,%rdi), %zmm3 {%k1} {z}
	vpcmpgtd	%zmm9, %zmm0, %k1
	vmovups	%zmm4, 5456(%rsp)
	vmovups	1280(%rax,%rdi), %zmm4 {%k1} {z}
	kmovw	%k1, 1040(%rsp)
	vpcmpgtd	%zmm10, %zmm0, %k1
	kmovw	%k1, 1104(%rsp)
	vmovups	%zmm3, 5392(%rsp)
	vmovups	1216(%rax,%rdi), %zmm3 {%k1} {z}
	vpcmpgtd	%zmm11, %zmm0, %k1
	vmovups	%zmm4, 5328(%rsp)
	vmovups	1152(%rax,%rdi), %zmm4 {%k1} {z}
	kmovw	%k1, 1168(%rsp)
	vpcmpgtd	%zmm12, %zmm0, %k1
	kmovw	%k1, 1232(%rsp)
	vmovups	%zmm3, 5264(%rsp)
	vmovups	1088(%rax,%rdi), %zmm3 {%k1} {z}
	vpcmpgtd	%zmm13, %zmm0, %k1
	vmovups	%zmm4, 5200(%rsp)
	vmovups	1024(%rax,%rdi), %zmm4 {%k1} {z}
	kmovw	%k1, 1296(%rsp)
	vpcmpgtd	%zmm14, %zmm0, %k1
	kmovw	%k1, 1360(%rsp)
	vmovups	%zmm3, 5136(%rsp)
	vmovups	960(%rax,%rdi), %zmm3 {%k1} {z}
	vpcmpgtd	%zmm15, %zmm0, %k1
	vmovups	%zmm4, 5072(%rsp)
	vmovups	896(%rax,%rdi), %zmm4 {%k1} {z}
	kmovw	%k1, 1424(%rsp)
	vpcmpgtd	%zmm16, %zmm0, %k1
	kmovw	%k1, 1488(%rsp)
	vmovups	%zmm3, 5008(%rsp)
	vmovups	832(%rax,%rdi), %zmm3 {%k1} {z}
	vpcmpgtd	%zmm17, %zmm0, %k1
	vmovups	%zmm4, 4944(%rsp)
	vmovups	768(%rax,%rdi), %zmm4 {%k1} {z}
	kmovw	%k1, -48(%rsp)
	vpcmpgtd	%zmm18, %zmm0, %k1
	kmovw	%k1, 16(%rsp)
	vmovups	%zmm3, 4880(%rsp)
	vmovups	704(%rax,%rdi), %zmm3 {%k1} {z}
	vpcmpgtd	%zmm22, %zmm0, %k1
	vmovups	%zmm4, 4816(%rsp)
	vmovups	640(%rax,%rdi), %zmm4 {%k5} {z}
	kmovw	%k1, -64(%rsp)
	vmovups	%zmm3, 4752(%rsp)
	vmovups	576(%rax,%rdi), %zmm3 {%k4} {z}
	vmovups	%zmm4, 4688(%rsp)
	vmovups	512(%rax,%rdi), %zmm4 {%k3} {z}
	vmovups	%zmm3, 4624(%rsp)
	vmovups	448(%rax,%rdi), %zmm3 {%k1} {z}
	vpcmpgtd	%zmm23, %zmm0, %k1
	vmovups	%zmm4, 4560(%rsp)
	vmovups	384(%rax,%rdi), %zmm4 {%k1} {z}
	kmovw	%k1, 80(%rsp)
	vpcmpgtd	%zmm24, %zmm0, %k1
	kmovw	%k1, -74(%rsp)
	kmovw	-74(%rsp), %k7
	vmovups	%zmm3, 4496(%rsp)
	vmovups	320(%rax,%rdi), %zmm3 {%k1} {z}
	vpcmpgtd	%zmm25, %zmm0, %k1
	vmovups	%zmm4, 4432(%rsp)
	vmovups	256(%rax,%rdi), %zmm4 {%k1} {z}
	kmovw	%k1, -72(%rsp)
	vpcmpgtd	%zmm26, %zmm0, %k1
	kmovw	%k1, -70(%rsp)
	vmovups	%zmm3, 4368(%rsp)
	vmovups	192(%rax,%rdi), %zmm3 {%k1} {z}
	vpcmpgtd	%zmm27, %zmm0, %k1
	vmovups	%zmm4, 4304(%rsp)
	vmovups	128(%rax,%rdi), %zmm4 {%k1} {z}
	kmovw	%k1, -68(%rsp)
	vpcmpgtd	%zmm28, %zmm0, %k1
	kmovw	%k1, -66(%rsp)
	vmovups	%zmm3, 4240(%rsp)
	vmovups	64(%rax,%rdi), %zmm3 {%k1} {z}
	vpcmpgtd	%zmm1, %zmm0, %k1
	vmovups	%zmm4, 4176(%rsp)
	vmovups	3840(%rax,%rsi), %zmm4 {%k2} {z}
	kmovw	-122(%rsp), %k2
	vmovups	(%rax,%rdi), %zmm0 {%k1} {z}
	kmovw	%k1, -52(%rsp)
	vmovups	3776(%rax,%rsi), %zmm25 {%k2} {z}
	kmovw	-120(%rsp), %k2
	vmovups	%zmm3, 4112(%rsp)
	vmovups	3904(%rax,%rsi), %zmm3 {%k6} {z}
	kmovw	-72(%rsp), %k6
	vmovups	%zmm0, 4048(%rsp)
	vmovups	3712(%rax,%rsi), %zmm1 {%k2} {z}
	kmovw	-118(%rsp), %k2
	vmovups	%zmm1, 3600(%rsp)
	vmovups	3648(%rax,%rsi), %zmm1 {%k2} {z}
	kmovw	-126(%rsp), %k2
	vmovups	3584(%rax,%rsi), %zmm24 {%k2} {z}
	kmovw	-116(%rsp), %k2
	vmovups	3520(%rax,%rsi), %zmm5 {%k2} {z}
	kmovw	-114(%rsp), %k2
	vmovups	3456(%rax,%rsi), %zmm23 {%k2} {z}
	kmovw	-112(%rsp), %k2
	vmovups	3392(%rax,%rsi), %zmm6 {%k2} {z}
	kmovw	-110(%rsp), %k2
	vmovups	3328(%rax,%rsi), %zmm22 {%k2} {z}
	kmovw	-108(%rsp), %k2
	vmovups	3264(%rax,%rsi), %zmm7 {%k2} {z}
	kmovw	-106(%rsp), %k2
	vmovups	3200(%rax,%rsi), %zmm8 {%k2} {z}
	kmovw	-104(%rsp), %k2
	vmovups	3136(%rax,%rsi), %zmm9 {%k2} {z}
	kmovw	-102(%rsp), %k2
	vmovups	3072(%rax,%rsi), %zmm10 {%k2} {z}
	kmovw	-100(%rsp), %k2
	vmovups	3008(%rax,%rsi), %zmm11 {%k2} {z}
	kmovw	-98(%rsp), %k2
	vmovups	2944(%rax,%rsi), %zmm12 {%k2} {z}
	kmovw	-96(%rsp), %k2
	vmovups	2880(%rax,%rsi), %zmm13 {%k2} {z}
	kmovw	-94(%rsp), %k2
	vmovups	2816(%rax,%rsi), %zmm14 {%k2} {z}
	kmovw	-92(%rsp), %k2
	vmovups	2752(%rax,%rsi), %zmm15 {%k2} {z}
	kmovw	-90(%rsp), %k2
	vmovups	2688(%rax,%rsi), %zmm16 {%k2} {z}
	kmovw	-88(%rsp), %k2
	vmovups	2624(%rax,%rsi), %zmm17 {%k2} {z}
	kmovw	-86(%rsp), %k2
	vmovups	2560(%rax,%rsi), %zmm18 {%k2} {z}
	kmovw	-84(%rsp), %k2
	vmovups	2496(%rax,%rsi), %zmm19 {%k2} {z}
	kmovw	-82(%rsp), %k2
	vmovups	2432(%rax,%rsi), %zmm20 {%k2} {z}
	kmovw	-80(%rsp), %k2
	vmovups	2368(%rax,%rsi), %zmm21 {%k2} {z}
	kmovw	-78(%rsp), %k2
	vmovups	2304(%rax,%rsi), %zmm26 {%k2} {z}
	kmovw	-76(%rsp), %k2
	vmovups	2240(%rax,%rsi), %zmm27 {%k2} {z}
	kmovw	144(%rsp), %k2
	vmovups	2176(%rax,%rsi), %zmm28 {%k2} {z}
	kmovw	208(%rsp), %k2
	vmovups	2112(%rax,%rsi), %zmm29 {%k2} {z}
	kmovw	272(%rsp), %k2
	vmovups	2048(%rax,%rsi), %zmm30 {%k2} {z}
	kmovw	336(%rsp), %k2
	vmovups	1984(%rax,%rsi), %zmm31 {%k2} {z}
	kmovw	400(%rsp), %k2
	vmovups	1920(%rax,%rsi), %zmm0 {%k2} {z}
	kmovw	464(%rsp), %k2
	vmovups	%zmm0, 3536(%rsp)
	vmovups	1856(%rax,%rsi), %zmm0 {%k2} {z}
	kmovw	528(%rsp), %k2
	vmovups	%zmm0, 3472(%rsp)
	vmovups	1792(%rax,%rsi), %zmm0 {%k2} {z}
	kmovw	592(%rsp), %k2
	vmovups	%zmm0, 3408(%rsp)
	vmovups	1728(%rax,%rsi), %zmm0 {%k2} {z}
	kmovw	656(%rsp), %k2
	vmovups	%zmm0, 3344(%rsp)
	vmovups	1664(%rax,%rsi), %zmm0 {%k2} {z}
	kmovw	720(%rsp), %k2
	vmovups	%zmm0, 3280(%rsp)
	vmovups	1600(%rax,%rsi), %zmm0 {%k2} {z}
	kmovw	784(%rsp), %k2
	vmovups	%zmm0, 3216(%rsp)
	vmovups	1536(%rax,%rsi), %zmm0 {%k2} {z}
	kmovw	848(%rsp), %k2
	vmovups	%zmm0, 3152(%rsp)
	vmovups	1472(%rax,%rsi), %zmm0 {%k2} {z}
	kmovw	912(%rsp), %k2
	vmovups	%zmm0, 3088(%rsp)
	vmovups	1408(%rax,%rsi), %zmm0 {%k2} {z}
	kmovw	976(%rsp), %k2
	vmovups	%zmm0, 3024(%rsp)
	vmovups	1344(%rax,%rsi), %zmm0 {%k2} {z}
	kmovw	1040(%rsp), %k2
	vmovups	%zmm0, 2960(%rsp)
	vmovups	1280(%rax,%rsi), %zmm0 {%k2} {z}
	kmovw	1104(%rsp), %k2
	vmovups	%zmm0, 2896(%rsp)
	vmovups	1216(%rax,%rsi), %zmm0 {%k2} {z}
	kmovw	1168(%rsp), %k2
	vmovups	%zmm0, 2832(%rsp)
	vmovups	1152(%rax,%rsi), %zmm0 {%k2} {z}
	kmovw	1232(%rsp), %k2
	vmovups	%zmm0, 2768(%rsp)
	vmovups	1088(%rax,%rsi), %zmm0 {%k2} {z}
	kmovw	1296(%rsp), %k2
	vmovups	%zmm0, 2704(%rsp)
	vmovups	1024(%rax,%rsi), %zmm0 {%k2} {z}
	kmovw	1360(%rsp), %k2
	vmovups	%zmm0, 2640(%rsp)
	vmovups	960(%rax,%rsi), %zmm0 {%k2} {z}
	kmovw	1424(%rsp), %k2
	vmovups	%zmm0, 2576(%rsp)
	vmovups	896(%rax,%rsi), %zmm0 {%k2} {z}
	kmovw	1488(%rsp), %k2
	vmovups	%zmm0, 2512(%rsp)
	vmovups	832(%rax,%rsi), %zmm0 {%k2} {z}
	kmovw	-48(%rsp), %k2
	vmovups	%zmm0, 2448(%rsp)
	vmovups	768(%rax,%rsi), %zmm0 {%k2} {z}
	kmovw	16(%rsp), %k2
	vmovups	%zmm0, 2384(%rsp)
	vmovups	704(%rax,%rsi), %zmm0 {%k2} {z}
	kmovw	-64(%rsp), %k2
	vmovups	%zmm0, 2320(%rsp)
	vmovups	640(%rax,%rsi), %zmm0 {%k5} {z}
	kmovw	-70(%rsp), %k5
	vmovups	%zmm0, 2256(%rsp)
	vmovups	576(%rax,%rsi), %zmm0 {%k4} {z}
	kmovw	-68(%rsp), %k4
	vmovups	%zmm0, 2192(%rsp)
	vmovups	512(%rax,%rsi), %zmm0 {%k3} {z}
	kmovw	80(%rsp), %k3
	vmovups	%zmm0, 2128(%rsp)
	vmovups	448(%rax,%rsi), %zmm0 {%k2} {z}
	vmovups	%zmm0, 2064(%rsp)
	vmovups	384(%rax,%rsi), %zmm0 {%k3} {z}
	kmovw	-66(%rsp), %k3
	vmovups	%zmm0, 2000(%rsp)
	vmovups	320(%rax,%rsi), %zmm0 {%k7} {z}
	vmovups	%zmm0, 1936(%rsp)
	vmovups	256(%rax,%rsi), %zmm0 {%k6} {z}
	vmovups	%zmm0, 1872(%rsp)
	vmovups	192(%rax,%rsi), %zmm0 {%k5} {z}
	vmovups	%zmm0, 1808(%rsp)
	vmovups	128(%rax,%rsi), %zmm0 {%k4} {z}
	vmovups	%zmm0, 1744(%rsp)
	vmovups	64(%rax,%rsi), %zmm0 {%k3} {z}
	vmovups	%zmm0, 1680(%rsp)
	vmovups	(%rax,%rsi), %zmm0 {%k1} {z}
	kmovw	-50(%rsp), %k1
	vmovups	%zmm0, 1616(%rsp)
	vmovups	7632(%rsp), %zmm0
	vmovups	%zmm0, 4032(%rax,%rdx) {%k1}
	kmovw	-62(%rsp), %k1
	vaddps	3728(%rsp), %zmm3, %zmm0
	vaddps	3792(%rsp), %zmm4, %zmm3
	vmovups	%zmm2, 3968(%rax,%rdx) {%k1}
	kmovw	-54(%rsp), %k1
	vaddps	3984(%rsp), %zmm1, %zmm2
	vaddps	7568(%rsp), %zmm24, %zmm1
	vmovups	%zmm0, 3904(%rax,%rdx) {%k1}
	kmovw	-124(%rsp), %k1
	vaddps	3856(%rsp), %zmm25, %zmm0
	vmovups	%zmm3, 3840(%rax,%rdx) {%k1}
	kmovw	-122(%rsp), %k1
	vmovups	%zmm0, 3776(%rax,%rdx) {%k1}
	vmovups	3600(%rsp), %zmm0
	kmovw	-120(%rsp), %k1
	vaddps	3920(%rsp), %zmm0, %zmm0
	vmovups	%zmm0, 3712(%rax,%rdx) {%k1}
	kmovw	-118(%rsp), %k1
	vmovups	%zmm2, 3648(%rax,%rdx) {%k1}
	kmovw	-126(%rsp), %k1
	vaddps	7504(%rsp), %zmm5, %zmm2
	vmovups	%zmm1, 3584(%rax,%rdx) {%k1}
	kmovw	-116(%rsp), %k1
	vaddps	7440(%rsp), %zmm23, %zmm1
	vmovups	%zmm2, 3520(%rax,%rdx) {%k1}
	kmovw	-114(%rsp), %k1
	vaddps	7376(%rsp), %zmm6, %zmm2
	vmovups	%zmm1, 3456(%rax,%rdx) {%k1}
	kmovw	-112(%rsp), %k1
	vaddps	7312(%rsp), %zmm22, %zmm1
	vmovups	%zmm2, 3392(%rax,%rdx) {%k1}
	kmovw	-110(%rsp), %k1
	vaddps	7248(%rsp), %zmm7, %zmm2
	vmovups	%zmm1, 3328(%rax,%rdx) {%k1}
	kmovw	-108(%rsp), %k1
	vaddps	7184(%rsp), %zmm8, %zmm1
	vmovups	%zmm2, 3264(%rax,%rdx) {%k1}
	kmovw	-106(%rsp), %k1
	vaddps	7120(%rsp), %zmm9, %zmm2
	vmovups	%zmm1, 3200(%rax,%rdx) {%k1}
	kmovw	-104(%rsp), %k1
	vaddps	7056(%rsp), %zmm10, %zmm1
	vmovups	%zmm2, 3136(%rax,%rdx) {%k1}
	kmovw	-102(%rsp), %k1
	vaddps	6992(%rsp), %zmm11, %zmm2
	vmovups	%zmm1, 3072(%rax,%rdx) {%k1}
	kmovw	-100(%rsp), %k1
	vaddps	6928(%rsp), %zmm12, %zmm1
	vmovups	%zmm2, 3008(%rax,%rdx) {%k1}
	kmovw	-98(%rsp), %k1
	vaddps	6864(%rsp), %zmm13, %zmm2
	vmovups	%zmm1, 2944(%rax,%rdx) {%k1}
	kmovw	-96(%rsp), %k1
	vaddps	6800(%rsp), %zmm14, %zmm1
	vmovups	%zmm2, 2880(%rax,%rdx) {%k1}
	kmovw	-94(%rsp), %k1
	vaddps	6736(%rsp), %zmm15, %zmm2
	vmovups	%zmm1, 2816(%rax,%rdx) {%k1}
	kmovw	-92(%rsp), %k1
	vaddps	6672(%rsp), %zmm16, %zmm1
	vmovups	%zmm2, 2752(%rax,%rdx) {%k1}
	kmovw	-90(%rsp), %k1
	vaddps	6608(%rsp), %zmm17, %zmm2
	vmovups	%zmm1, 2688(%rax,%rdx) {%k1}
	kmovw	-88(%rsp), %k1
	vaddps	6544(%rsp), %zmm18, %zmm1
	vmovups	%zmm2, 2624(%rax,%rdx) {%k1}
	kmovw	-86(%rsp), %k1
	vaddps	6480(%rsp), %zmm19, %zmm2
	vmovups	%zmm1, 2560(%rax,%rdx) {%k1}
	kmovw	-84(%rsp), %k1
	vaddps	6416(%rsp), %zmm20, %zmm1
	vmovups	%zmm2, 2496(%rax,%rdx) {%k1}
	kmovw	-82(%rsp), %k1
	vaddps	6352(%rsp), %zmm21, %zmm2
	vmovups	%zmm1, 2432(%rax,%rdx) {%k1}
	kmovw	-80(%rsp), %k1
	vaddps	6288(%rsp), %zmm26, %zmm1
	vmovups	%zmm2, 2368(%rax,%rdx) {%k1}
	kmovw	-78(%rsp), %k1
	vaddps	6224(%rsp), %zmm27, %zmm2
	vmovups	%zmm1, 2304(%rax,%rdx) {%k1}
	kmovw	-76(%rsp), %k1
	vaddps	6160(%rsp), %zmm28, %zmm1
	vmovups	%zmm2, 2240(%rax,%rdx) {%k1}
	kmovw	144(%rsp), %k1
	vaddps	6096(%rsp), %zmm29, %zmm2
	vmovups	%zmm1, 2176(%rax,%rdx) {%k1}
	kmovw	208(%rsp), %k1
	vaddps	6032(%rsp), %zmm30, %zmm1
	vmovups	%zmm2, 2112(%rax,%rdx) {%k1}
	kmovw	272(%rsp), %k1
	vaddps	5968(%rsp), %zmm31, %zmm2
	vmovups	%zmm1, 2048(%rax,%rdx) {%k1}
	vmovups	3536(%rsp), %zmm1
	kmovw	336(%rsp), %k1
	vaddps	5904(%rsp), %zmm1, %zmm0
	vmovups	3408(%rsp), %zmm1
	vmovups	%zmm2, 1984(%rax,%rdx) {%k1}
	kmovw	400(%rsp), %k1
	vmovups	3472(%rsp), %zmm2
	vmovups	%zmm0, 1920(%rax,%rdx) {%k1}
	vaddps	5840(%rsp), %zmm2, %zmm0
	kmovw	464(%rsp), %k1
	vmovups	3344(%rsp), %zmm2
	vmovups	%zmm0, 1856(%rax,%rdx) {%k1}
	vaddps	1552(%rsp), %zmm1, %zmm0
	kmovw	528(%rsp), %k1
	vmovups	3280(%rsp), %zmm1
	vmovups	%zmm0, 1792(%rax,%rdx) {%k1}
	vaddps	5776(%rsp), %zmm2, %zmm0
	kmovw	592(%rsp), %k1
	vmovups	3216(%rsp), %zmm2
	vmovups	%zmm0, 1728(%rax,%rdx) {%k1}
	vaddps	5712(%rsp), %zmm1, %zmm0
	kmovw	656(%rsp), %k1
	vmovups	3152(%rsp), %zmm1
	vmovups	%zmm0, 1664(%rax,%rdx) {%k1}
	vaddps	5648(%rsp), %zmm2, %zmm0
	kmovw	720(%rsp), %k1
	vmovups	3088(%rsp), %zmm2
	vmovups	%zmm0, 1600(%rax,%rdx) {%k1}
	vaddps	5584(%rsp), %zmm1, %zmm0
	kmovw	784(%rsp), %k1
	vmovups	3024(%rsp), %zmm1
	vmovups	%zmm0, 1536(%rax,%rdx) {%k1}
	vaddps	5520(%rsp), %zmm2, %zmm0
	kmovw	848(%rsp), %k1
	vmovups	2960(%rsp), %zmm2
	vmovups	%zmm0, 1472(%rax,%rdx) {%k1}
	vaddps	5456(%rsp), %zmm1, %zmm0
	kmovw	912(%rsp), %k1
	vmovups	2896(%rsp), %zmm1
	vmovups	%zmm0, 1408(%rax,%rdx) {%k1}
	vaddps	5392(%rsp), %zmm2, %zmm0
	kmovw	976(%rsp), %k1
	vmovups	2832(%rsp), %zmm2
	vmovups	%zmm0, 1344(%rax,%rdx) {%k1}
	vaddps	5328(%rsp), %zmm1, %zmm0
	kmovw	1040(%rsp), %k1
	vmovups	2768(%rsp), %zmm1
	vmovups	%zmm0, 1280(%rax,%rdx) {%k1}
	vaddps	5264(%rsp), %zmm2, %zmm0
	kmovw	1104(%rsp), %k1
	vmovups	2704(%rsp), %zmm2
	vmovups	%zmm0, 1216(%rax,%rdx) {%k1}
	vaddps	5200(%rsp), %zmm1, %zmm0
	kmovw	1168(%rsp), %k1
	vmovups	2640(%rsp), %zmm1
	vmovups	%zmm0, 1152(%rax,%rdx) {%k1}
	vaddps	5136(%rsp), %zmm2, %zmm0
	kmovw	1232(%rsp), %k1
	vmovups	2576(%rsp), %zmm2
	vmovups	%zmm0, 1088(%rax,%rdx) {%k1}
	vaddps	5072(%rsp), %zmm1, %zmm0
	kmovw	1296(%rsp), %k1
	vmovups	2512(%rsp), %zmm1
	vmovups	%zmm0, 1024(%rax,%rdx) {%k1}
	vaddps	5008(%rsp), %zmm2, %zmm0
	kmovw	1360(%rsp), %k1
	vmovups	2448(%rsp), %zmm2
	vmovups	%zmm0, 960(%rax,%rdx) {%k1}
	vaddps	4944(%rsp), %zmm1, %zmm0
	kmovw	1424(%rsp), %k1
	vmovups	2384(%rsp), %zmm1
	vmovups	%zmm0, 896(%rax,%rdx) {%k1}
	vaddps	4880(%rsp), %zmm2, %zmm0
	kmovw	1488(%rsp), %k1
	vmovups	2320(%rsp), %zmm2
	vmovups	%zmm0, 832(%rax,%rdx) {%k1}
	vaddps	4816(%rsp), %zmm1, %zmm0
	kmovw	-48(%rsp), %k1
	vmovups	2256(%rsp), %zmm1
	vmovups	%zmm0, 768(%rax,%rdx) {%k1}
	vaddps	4752(%rsp), %zmm2, %zmm0
	kmovw	16(%rsp), %k1
	vmovups	2192(%rsp), %zmm2
	vmovups	%zmm0, 704(%rax,%rdx) {%k1}
	vaddps	4688(%rsp), %zmm1, %zmm0
	kmovw	-60(%rsp), %k1
	vmovups	2128(%rsp), %zmm1
	vmovups	%zmm0, 640(%rax,%rdx) {%k1}
	vaddps	4624(%rsp), %zmm2, %zmm0
	kmovw	-58(%rsp), %k1
	vmovups	2064(%rsp), %zmm2
	vmovups	%zmm0, 576(%rax,%rdx) {%k1}
	vaddps	4560(%rsp), %zmm1, %zmm0
	kmovw	-56(%rsp), %k1
	vmovups	2000(%rsp), %zmm1
	vmovups	%zmm0, 512(%rax,%rdx) {%k1}
	vaddps	4496(%rsp), %zmm2, %zmm0
	kmovw	80(%rsp), %k1
	vmovups	1936(%rsp), %zmm2
	vmovups	%zmm0, 448(%rax,%rdx) {%k2}
	vaddps	4432(%rsp), %zmm1, %zmm0
	vmovups	1872(%rsp), %zmm1
	vmovups	%zmm0, 384(%rax,%rdx) {%k1}
	vaddps	4368(%rsp), %zmm2, %zmm0
	vmovups	1808(%rsp), %zmm2
	kmovw	-52(%rsp), %k1
	vmovups	%zmm0, 320(%rax,%rdx) {%k7}
	vaddps	4304(%rsp), %zmm1, %zmm0
	vmovups	1744(%rsp), %zmm1
	vmovups	%zmm0, 256(%rax,%rdx) {%k6}
	vaddps	4240(%rsp), %zmm2, %zmm0
	vmovups	1680(%rsp), %zmm2
	vmovups	%zmm0, 192(%rax,%rdx) {%k5}
	vaddps	4176(%rsp), %zmm1, %zmm0
	vmovups	1616(%rsp), %zmm1
	vmovups	%zmm0, 128(%rax,%rdx) {%k4}
	vaddps	4112(%rsp), %zmm2, %zmm0
	vmovups	%zmm0, 64(%rax,%rdx) {%k3}
	vaddps	4048(%rsp), %zmm1, %zmm0
	vmovups	%zmm0, (%rax,%rdx) {%k1}
	addq	$7704, %rsp
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
