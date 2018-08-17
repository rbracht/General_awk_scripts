BEGIN{

##########################################################################
##########################################################################
##                                                                      ##
## This program takes output from Promax Amplitude Analysis             ##
## output with ILINE_NO, XLINE_NO, CDP_X and CDP_Y  as                  ##
## chosen header word labels for the traces. All lines before           ##
## the first line containing the strings "ILINE_NO=" and "XLINE_NO="    ##
## as the first and third entries will be ignored (skips header stuff). ##
## The input is assumed to be Interval velocity and depth pairs the     ##
## program then outputs data as depth average velocity in TDQ's avf     ##
## format.                                                              ##
##                                                                      ##
##########################################################################
##########################################################################

#  +---------------------------------------------------------+
#  | You may wish to change some of the following variables  |
#  | for a particular run.                                   |
#  +---------------------------------------------------------+

# ____________________________________________________________
# Depth Sample interval of input data 
# 

  SampleInterval = 20.0
# ____________________________________________________________


# ____________________________________________________________
# Use only every N'th sample 
# (For every sample set to 1, every other set to 2 and so on)

  Every_N_Samples = 2
# ____________________________________________________________

# ____________________________________________________________
# Minimum Velocity allowed in function. If the velocity is 
# less than this, the velocity will be set to this value

  MinAllowVel = 4920

# ____________________________________________________________
# Maximum Velocity allowed in function. If the velocity is
# greater than this, the velocity will be set to this value

  MaxAllowVel = 40000
# ____________________________________________________________
# Some output at beginning of output
    printf("# Depth domain selected.\n")
    printf("# Output depth and average velocity pairs\n")
    printf("# LINEAR_UNITS = FEET\n")
    printf("# FUNCTION_TYPE = DVave\n")
    printf("# DATUM = 0.0           ### Check This ###\n")
    printf("#---------------------------------------------\n")
# ____________________________________________________________


# ____________________________________________________________
# This is the number of trace amplitude values in the Promax output
# per line which should remain as 5 per line but who knows look at 
# the file to make sure.
  SampPerLine = 5
# ____________________________________________________________

# ____________________________________________________________
# The following variable is the number of lines between 
# the first occurance of the strings "ILINE_NO=" and "XLINE_NO="
# as the first and third entries and the actual trace values, in the
# current situation it is 9 lines, but this may change, so check the 
# input file.
  SkipNumberLines = 9
# ____________________________________________________________


####################################################
####################################################
####################################################
###                                              ###
###                                              ###
###  You should be able to leave the rest alone  ###
###                                              ###
###                                              ###
####################################################
####################################################
####################################################

  SkipHeader = 0
  Depth = 0.0
  IntVel = 0.0
  CDP_X = 0.0
  CDP_Y = 0.0
  SkipLineCounter = 0
  VelocityFunctionNumber = 0
  DeltaD= SampleInterval
  EveryDeltaD= Every_N_Samples * DeltaD
}
{
  if ( $1 == "ILINE_NO=" && $3 == "XLINE_NO=" ){
    VelocityFunctionNumber ++
    CDP_X = $6
    CDP_Y = $8
    InvSumIntVel = 0.0
    AveIntVel = 0.0
    Depth = 0.0
    SkipLineCounter = -1
    SkipHeader = 1
  }
  if ( SkipHeader == 2 ){
    for ( i=3; i<= NF; i++ ){
      Depth = $2 + ((i-3) * DeltaD)
      IntVel = $i
      if ( IntVel < MinAllowVel ) {
	IntVel = MinAllowVel
      }
      if ( IntVel > MaxAllowVel ) {
	IntVel = MaxAllowVel
      }
      InvSumIntVel += 1.0 / IntVel
      AveIntVel = Depth / (DeltaD* InvSumIntVel)
      if ( int( Depth/EveryDeltaD ) == Depth/EveryDeltaD ){
	printf ("%5d%10.1f%11.1f", VelocityFunctionNumber, CDP_X, CDP_Y)
	printf ("%12.2f%10.2f\n", Depth, AveIntVel)
      }
    }
  }
  if ( SkipHeader == 1 ){
    SkipLineCounter ++
    if (SkipLineCounter > SkipNumberLines){
      SkipHeader = 2
      for ( i=3; i<= NF; i++ ){
	Depth = $2 + ((i-3) * DeltaD)
        IntVel = $i
        if ( IntVel < MinAllowVel ) {
	  IntVel = MinAllowVel
        }
        if ( IntVel > MaxAllowVel ) {
	  IntVel = MaxAllowVel
        }
	InvSumIntVel += 1.0 / IntVel
	AveIntVel = Depth / (DeltaD* InvSumIntVel)
	if ( int( Depth/EveryDeltaD ) == Depth/EveryDeltaD ){
	  printf ("%5d%10.1f%11.1f", VelocityFunctionNumber, CDP_X, CDP_Y)
	  printf ("%12.2f%10.2f\n", Depth, AveIntVel)
	}
      }
    }
  }
}
END{}
