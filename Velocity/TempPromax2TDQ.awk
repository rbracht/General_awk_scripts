BEGIN{

##########################################################################
##########################################################################
##                                                                      ##
## This program takes output from Promax Amplitude Analysis             ##
## output with ILINE_NO, XLINE_NO, CDP_X and CDP_Y  as                  ##
## chosen header word labels for the traces. All lines before           ##
## the first line containing the strings "ILINE_NO=" and "XLINE_NO="    ##
## as the first and third entries will be ignored (skips header stuff). ##
##                                                                      ##
##########################################################################
##########################################################################

#  +---------------------------------------------------------+
#  | You may wish to change some of the following variables  |
#  | for a particular run.                                   |
#  +---------------------------------------------------------+

# ____________________________________________________________
# Sample interval of input data 
# (Time or Depth)

  SampleInterval = 50.0
# ____________________________________________________________


# ____________________________________________________________
# Use only every N'th sample 
# (For every sample set to 1, every other set to 2 and so on)

  Every_N_Samples = 1
# ____________________________________________________________

# ____________________________________________________________
# Some output at beginning of output
    printf("# Depth domain selected.\n")
    printf("# Output depth and average velocity pairs\n")
    printf("# LINEAR_UNITS = METERS\n")
    printf("# FUNCTION_TYPE = TVave\n")
    printf("# DATUM = 0.0           ### Check This ###\n")
    printf("#---------------------------------------------\n")
    printf("\n")
    printf("\n")
    printf("Number   In-line Cross-Line x-coord   y-coord     time/depth  Velocity\n")
# ____________________________________________________________


# ____________________________________________________________
# This is the number of trace amplitude values in the Promax output
# per lineand should remain as 5 per line but who knows look at 
# the file to make sure.
  SampPerLine = 5
# ____________________________________________________________

# ____________________________________________________________
# The following variable is the number of lines between 
# the first occurance of the strings "ILINE_NO=" and "XLINE_NO="
# as the first and third entries and the actual trace values, in the
# current situation it is 9 lines, but this may change, so check the 
# input file.
  skipno = 9
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

  skiphead = 0
  count = 0
  time = 0.0
  vel = 0.0
  cdpx = 0.0
  cdpy = 0.0
  skipcount = 0
  dt = SampleInterval
  everydt = Every_N_Samples * dt
  skipall = 0
}
{
  if ($1 == "Process" && $2 == "completed" && $3 == "normally"){
    skipall = 1
  }
  if ( skipall == 0 ){
    if ( $1 == "ILINE_NO=" && $3 == "XLINE_NO=" ){
      count ++
	iline = $2
	xline = $4
	cdpx = $6
	cdpy = $8
	skipcount = -1
	skiphead = 1
	}
    if ( skiphead == 1 ){
      skipcount ++
      if (skipcount > skipno){
	for ( i=3; i<= NF; i++ ){
	  time = $2 + ((i-3) * dt)
	  vel = $i
	  if ( int(time/everydt) == time/everydt ){
#	    if ( vel > 1400 && time > ($2 + ((i-4) *dt)) ){
	      printf ("%5d%10d%10d", count, iline, xline)
	      printf ("%10.1f%11.1f", cdpx, cdpy)
	      printf ("%12.2f%10.2f\n", time, vel)
#	    }
          }
        }
      }
    }
  }
}
END{}
