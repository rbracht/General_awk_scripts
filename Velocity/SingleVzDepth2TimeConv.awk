BEGIN {
      #*********************************************************************
      #*********************************************************************
      #*****                                                           *****
      #***** This program will take an input (x,y,z) three column      *****
      #***** data and use the velocity function below to convert the   *****
      #***** depth "z" into two way time using a simple depth stretch, *****
      #***** no migration is done only a simple vertical depth         *****
      #***** stretch. If you need a new velocity function, the awk     *****
      #***** script IntVel2AveVelAwk.awk will regenerate the code      *****
      #***** below. You should not have to change anything in this     *****
      #***** program to run it.                                        *****
      #*****                                                           *****
      #*********************************************************************
      #*********************************************************************
 
  DepthInt =      25.00

  printf(" X-Coord     Y-Coord       2-Way    Z-Coord    Average \n")
  printf("Latitude    Longitude      Time      Depth     Velocity\n")

  AveVel[   1] =    0.00
  AveVel[   2] = 1500.00
  AveVel[   3] = 1528.48
  AveVel[   4] = 1582.99
  AveVel[   5] = 1634.92
  AveVel[   6] = 1682.12
  AveVel[   7] = 1724.99
  AveVel[   8] = 1764.19
  AveVel[   9] = 1800.31
  AveVel[  10] = 1833.84
  AveVel[  11] = 1865.16
  AveVel[  12] = 1894.57
  AveVel[  13] = 1922.32
  AveVel[  14] = 1948.61
  AveVel[  15] = 1973.61
  AveVel[  16] = 1997.45
  AveVel[  17] = 2020.26
  AveVel[  18] = 2042.13
  AveVel[  19] = 2063.15
  AveVel[  20] = 2083.39
  AveVel[  21] = 2102.91
  AveVel[  22] = 2121.78
  AveVel[  23] = 2140.03
  AveVel[  24] = 2157.73
  AveVel[  25] = 2174.89
  AveVel[  26] = 2191.57
  AveVel[  27] = 2207.79
  AveVel[  28] = 2223.58
  AveVel[  29] = 2238.96
  AveVel[  30] = 2253.96
  AveVel[  31] = 2268.61
  AveVel[  32] = 2282.91
  AveVel[  33] = 2296.90
  AveVel[  34] = 2310.57
  AveVel[  35] = 2323.96
  AveVel[  36] = 2337.07
  AveVel[  37] = 2349.92
  AveVel[  38] = 2362.52
  AveVel[  39] = 2374.87
  AveVel[  40] = 2387.00
  AveVel[  41] = 2398.91
  AveVel[  42] = 2410.60
  AveVel[  43] = 2422.10
  AveVel[  44] = 2433.40
  AveVel[  45] = 2444.51
  AveVel[  46] = 2455.45
  AveVel[  47] = 2466.21
  AveVel[  48] = 2476.81
  AveVel[  49] = 2487.24
  AveVel[  50] = 2497.52
  AveVel[  51] = 2507.65
  AveVel[  52] = 2517.64
  AveVel[  53] = 2527.48
  AveVel[  54] = 2537.19
  AveVel[  55] = 2546.77
  AveVel[  56] = 2556.23
  AveVel[  57] = 2565.55
  AveVel[  58] = 2574.76
  AveVel[  59] = 2583.86
  AveVel[  60] = 2592.84
  AveVel[  61] = 2601.71
  AveVel[  62] = 2610.47
  AveVel[  63] = 2619.14
  AveVel[  64] = 2627.70
  AveVel[  65] = 2636.16
  AveVel[  66] = 2644.53
  AveVel[  67] = 2652.80
  AveVel[  68] = 2660.99
  AveVel[  69] = 2669.09
  AveVel[  70] = 2677.10
  AveVel[  71] = 2685.02
  AveVel[  72] = 2692.87
  AveVel[  73] = 2700.63
  AveVel[  74] = 2708.32
  AveVel[  75] = 2715.93
  AveVel[  76] = 2723.47
  AveVel[  77] = 2730.93
  AveVel[  78] = 2738.33
  AveVel[  79] = 2745.65
  AveVel[  80] = 2752.90
  AveVel[  81] = 2760.09
  AveVel[  82] = 2767.22
  AveVel[  83] = 2774.28
  AveVel[  84] = 2781.27
  AveVel[  85] = 2788.21
  AveVel[  86] = 2795.09
  AveVel[  87] = 2801.90
  AveVel[  88] = 2808.66
  AveVel[  89] = 2815.37
  AveVel[  90] = 2822.02
  AveVel[  91] = 2828.61
  AveVel[  92] = 2835.15
  AveVel[  93] = 2841.64
  AveVel[  94] = 2848.07
  AveVel[  95] = 2854.46
  AveVel[  96] = 2860.80
  AveVel[  97] = 2867.09
  AveVel[  98] = 2873.33
  AveVel[  99] = 2879.52
  AveVel[ 100] = 2885.67
  AveVel[ 101] = 2891.77
  AveVel[ 102] = 2897.83
  AveVel[ 103] = 2903.84
  AveVel[ 104] = 2909.82
  AveVel[ 105] = 2915.74
  AveVel[ 106] = 2921.63
  AveVel[ 107] = 2927.48
  AveVel[ 108] = 2933.29
  AveVel[ 109] = 2939.05
  AveVel[ 110] = 2944.78
  AveVel[ 111] = 2950.47
  AveVel[ 112] = 2956.12
  AveVel[ 113] = 2961.74
  AveVel[ 114] = 2967.31
  AveVel[ 115] = 2972.86
  AveVel[ 116] = 2978.36
  AveVel[ 117] = 2983.83
  AveVel[ 118] = 2989.27
  AveVel[ 119] = 2994.67
  AveVel[ 120] = 3000.04
  AveVel[ 121] = 3005.38
  AveVel[ 122] = 3010.68
  AveVel[ 123] = 3015.95
  AveVel[ 124] = 3021.19
  AveVel[ 125] = 3026.40
  AveVel[ 126] = 3031.58
  AveVel[ 127] = 3036.73
  AveVel[ 128] = 3041.85
  AveVel[ 129] = 3046.93
  AveVel[ 130] = 3051.99
  AveVel[ 131] = 3057.02
  AveVel[ 132] = 3062.03
  AveVel[ 133] = 3067.00
  AveVel[ 134] = 3071.95
  AveVel[ 135] = 3076.87
  AveVel[ 136] = 3081.76
  AveVel[ 137] = 3086.63
  AveVel[ 138] = 3091.47
  AveVel[ 139] = 3096.28
  AveVel[ 140] = 3101.07
  AveVel[ 141] = 3105.83
  AveVel[ 142] = 3110.57
  AveVel[ 143] = 3115.28
  AveVel[ 144] = 3119.97
  AveVel[ 145] = 3124.64
  AveVel[ 146] = 3129.28
  AveVel[ 147] = 3133.89
  AveVel[ 148] = 3138.49
  AveVel[ 149] = 3143.06
  AveVel[ 150] = 3147.61
  AveVel[ 151] = 3152.14
  AveVel[ 152] = 3156.64
  AveVel[ 153] = 3161.12
  AveVel[ 154] = 3165.58
  AveVel[ 155] = 3170.02
  AveVel[ 156] = 3174.44
  AveVel[ 157] = 3178.84
  AveVel[ 158] = 3183.21
  AveVel[ 159] = 3187.57
  AveVel[ 160] = 3191.91
  AveVel[ 161] = 3196.22
  AveVel[ 162] = 3200.52
  AveVel[ 163] = 3204.79
  AveVel[ 164] = 3209.05
  AveVel[ 165] = 3213.29
  AveVel[ 166] = 3217.51
  AveVel[ 167] = 3221.71
  AveVel[ 168] = 3225.89
  AveVel[ 169] = 3230.05
  AveVel[ 170] = 3234.20
  AveVel[ 171] = 3238.32
  AveVel[ 172] = 3242.43
  AveVel[ 173] = 3246.52
  AveVel[ 174] = 3250.59
  AveVel[ 175] = 3254.65
  AveVel[ 176] = 3258.69
  AveVel[ 177] = 3262.71
  AveVel[ 178] = 3266.72
  AveVel[ 179] = 3270.71
  AveVel[ 180] = 3274.68
  AveVel[ 181] = 3278.63
  AveVel[ 182] = 3282.57
  AveVel[ 183] = 3286.50
  AveVel[ 184] = 3290.40
  AveVel[ 185] = 3294.30
  AveVel[ 186] = 3298.17
  AveVel[ 187] = 3302.03
  AveVel[ 188] = 3305.88
  AveVel[ 189] = 3309.71
  AveVel[ 190] = 3313.53
  AveVel[ 191] = 3317.33
  AveVel[ 192] = 3321.11
  AveVel[ 193] = 3324.88
  AveVel[ 194] = 3328.64
  AveVel[ 195] = 3332.38
  AveVel[ 196] = 3336.11
  AveVel[ 197] = 3339.83
  AveVel[ 198] = 3343.53
  AveVel[ 199] = 3347.21
  AveVel[ 200] = 3350.88
  AveVel[ 201] = 3354.54
  AveVel[ 202] = 3358.19
  AveVel[ 203] = 3361.82
  AveVel[ 204] = 3365.44
  AveVel[ 205] = 3369.05
  AveVel[ 206] = 3372.64
  AveVel[ 207] = 3376.22
  AveVel[ 208] = 3379.79
  AveVel[ 209] = 3383.34
  AveVel[ 210] = 3386.88
  AveVel[ 211] = 3390.41
  AveVel[ 212] = 3393.93
  AveVel[ 213] = 3397.43
  AveVel[ 214] = 3400.92
  AveVel[ 215] = 3404.41
  AveVel[ 216] = 3407.87
  AveVel[ 217] = 3411.33
  AveVel[ 218] = 3414.77
  AveVel[ 219] = 3418.21
  AveVel[ 220] = 3421.63
  AveVel[ 221] = 3425.04
  AveVel[ 222] = 3428.44
  AveVel[ 223] = 3431.82
  AveVel[ 224] = 3435.20
  AveVel[ 225] = 3438.56
  AveVel[ 226] = 3441.92
  AveVel[ 227] = 3445.26
  AveVel[ 228] = 3448.59
  AveVel[ 229] = 3451.91
  AveVel[ 230] = 3455.22
  AveVel[ 231] = 3458.52
  AveVel[ 232] = 3461.81
  AveVel[ 233] = 3465.09
  AveVel[ 234] = 3468.35
  AveVel[ 235] = 3471.61
  AveVel[ 236] = 3474.86
  AveVel[ 237] = 3478.10
  AveVel[ 238] = 3481.32
  AveVel[ 239] = 3484.54
  AveVel[ 240] = 3487.75
  AveVel[ 241] = 3490.94
  AveVel[ 242] = 3494.13
  AveVel[ 243] = 3497.31
  AveVel[ 244] = 3500.47
  AveVel[ 245] = 3503.63
  AveVel[ 246] = 3506.78
  AveVel[ 247] = 3509.92
  AveVel[ 248] = 3513.05
  AveVel[ 249] = 3516.17
  AveVel[ 250] = 3519.28
  AveVel[ 251] = 3522.38
  AveVel[ 252] = 3525.47
  AveVel[ 253] = 3528.55
  AveVel[ 254] = 3531.63
  AveVel[ 255] = 3534.69
  AveVel[ 256] = 3537.75
  AveVel[ 257] = 3540.80
  AveVel[ 258] = 3543.84
  AveVel[ 259] = 3546.87
  AveVel[ 260] = 3549.89
  AveVel[ 261] = 3552.90
  AveVel[ 262] = 3555.90
  AveVel[ 263] = 3558.90
  AveVel[ 264] = 3561.89
  AveVel[ 265] = 3564.86
  AveVel[ 266] = 3567.83
  AveVel[ 267] = 3570.80
  AveVel[ 268] = 3573.75
  AveVel[ 269] = 3576.70
  AveVel[ 270] = 3579.63
  AveVel[ 271] = 3582.56
  AveVel[ 272] = 3585.48
  AveVel[ 273] = 3588.40
  AveVel[ 274] = 3591.30
  AveVel[ 275] = 3594.20
  AveVel[ 276] = 3597.09
  AveVel[ 277] = 3599.97
  AveVel[ 278] = 3602.85
  AveVel[ 279] = 3605.71
  AveVel[ 280] = 3608.57
  AveVel[ 281] = 3611.42
}
{
  Index = int( $3/DepthInt + 0.5 )
  if ( AveVel[Index] == 0.0 ) Time = 0.0
  else Time = $3 / AveVel[Index]
  printf("%10.2f %10.2f %10.3f %10.2f %10.2f\n", $1, $2, Time*2.0, $3, AveVel[Index])
}
END{}
 