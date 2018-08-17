BEGIN{

##########################################################################
##########################################################################
##                                                                      ##
##  This program takes output from:                                     ##
##                                                                      ##
##             ReformatXYTDIntVelAveVelRmsVel2TDQ.nawk                  ##
##                                                                      ##
##  and reformats it into an avf file that is the format needed to      ##
##  import into TDQ. This program will make the assumption that the     ##
##  output will be a depth,average velocity file. If the depths         ##
##  do not increase monotonically they will not be output.              ##
##                                                                      ##
##########################################################################
##########################################################################

# Use only every N'th sample 
# (For every sample set to 1, every other set to 2 and so on)

  Every_N_Samples = 2
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
# Some output at beginning of output
    printf("# Depth domain selected.\n")
    printf("# Output depth and average velocity pairs\n")
    printf("# LINEAR_UNITS = FEET\n")
    printf("# FUNCTION_TYPE = DVave\n")
    printf("# DATUM = 0.0           ### Check This ###\n")
    printf("#---------------------------------------------\n")
# ____________________________________________________________


# ____________________________________________________________
# This variable is used to insure the depths are monotonically 
# increasing for each velocity function.

             OldDepth = -1.0

# ____________________________________________________________

OldVelFuncNum = 0
count = 0
}
{
	count ++
	VelFuncNum = $1
	if ( OldVelFuncNum != VelFuncNum ) {
		OldDepth = -1.0
		OldVelFuncNum = VelFuncNum
	}
	if ( int((count+1)/Every_N_Samples) == (count+1)/Every_N_Samples ){
		cdpx = $2
		cdpy = $3 
		depth = $7
		AveVel = $9
		if ( depth > OldDepth ){		  
			printf ("%5d%10.1f%11.1f",VelFuncNum , cdpx, cdpy)
			printf ("%12.2f%10.2f\n", depth, AveVel)
			OldDepth = depth
		}
	}
}
END{}

