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
## program then outputs 10 columns with (VelNumber,X,Y,InLine,XLine,    ##
## Time,Depth,IntervalVel,AverageVel,RmsVel).                           ##
##                                                                      ##
##########################################################################
##########################################################################


#  +---------------------------------------------------------+
#  | You may wish to change some of the following variables  |
#  | for a particular run.                                   |
#  +---------------------------------------------------------+

# ____________________________________________________________
# The depth sampling interval of input file
#

         DepthInterval = 20.0

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

# ____________________________________________________________
# The following variable is the number of lines including
# the first occurance of the strings "ILINE_NO=" and "XLINE_NO="
# as the first and third entries and the actual trace values, in the
# current situation it is 10 lines, but this may change, so check the 
# input file.

         NumLines2Skip = 10

# ____________________________________________________________


VelFunctNum = 0
SkipCount = 0
MinIntVel = 4915.0
MaxIntVel = 40000.0

}
{
	SkipCount++
	if ( $1 == "ILINE_NO=" && $3 == "XLINE_NO=" ){
		VelFunctNum++
		SkipCount = 1
		XCoord = $6
		YCoord = $8
		ILineNumb = $2
		XLineNumb = $4
		OneWayTime = 0.0
		AveVel = 0.0
		RmsVel = 0.0
		SumIntVel = 0.0
	}
	if (VelFunctNum >= 1 && SkipCount > NumLines2Skip) {
		for ( i=3; i<=NF; i++) {

			IntVel = $i

			if (IntVel < MinIntVel) IntVel = MinIntVel
			if (IntVel > MaxIntVel) IntVel = MaxIntVel

			Depth = $2 + ((i-3)*DepthInterval)

			DeltaTime = DepthInterval/IntVel

			OneWayTime += DeltaTime

			AveVel =  ( Depth + DepthInterval ) / OneWayTime

			SumIntVel += IntVel

			RmsVel = sqrt( DepthInterval * SumIntVel / OneWayTime )

			Time = 2000.0 * ( OneWayTime - DeltaTime )

			printf ("%5d %10.2f %10.2f %10d %10d  %7.0f %7.0f %10.0f %10.0f %10.0f\n", \
				VelFunctNum, XCoord, YCoord, ILineNumb, XLineNumb, \
				Time, Depth, IntVel, AveVel, RmsVel ) 
		}
	}
}
