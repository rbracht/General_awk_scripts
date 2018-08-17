BEGIN {
 	#********************************************************************
	#********************************************************************
	#*****                                                          *****
	#***** This program will take an input (depth,IntervalVelocity) *****
	#***** and generate an output awk file that will have average   *****
	#***** velocities that can be used to time convert an (x,y,z)   *****
	#***** into an (x,y,2-way_time,z,AveVel) file. Remeber this     *****
	#***** program only generates an awk file that will perform the *****
        #***** time conversion step. You don't have to have a fixed     *****
        #***** depth increment to run this program but the next step    *****
        #***** will only work at this time with a constant depth        *****
        #***** increment.                                               *****
	#*****                                                          *****
	#********************************************************************
	#********************************************************************


	#####################################
	#                                   #
	#  You might want to change the     #
	#  following parameters for a       #
	#  particular run.                  #
	#                                   #
	#####################################

# Number of initial lines of your input file to skip over.
  SkipLines = 3
# The depth increment of your input file.
  DepthInt = 25.0

	##################################################
	##################################################
	##################################################
	####                                          ####
	####  Should be able to leave the rest alone  ####
	####                                          ####
	##################################################
	##################################################
	##################################################


  Index = 0
  TotalTime = 0.0
  TotalDepthOld = 0.0
  OldDepthInt = 0.0
  IntTime = 0.0
  AveVel = 0.0
  printf("BEGIN {\n")
  printf("      #*********************************************************************\n")
  printf("      #*********************************************************************\n")
  printf("      #*****                                                           *****\n")
  printf("      #***** This program will take an input (x,y,z) three column      *****\n")
  printf("      #***** data and use the velocity function below to convert the   *****\n")
  printf("      #***** depth \"z\" into two way time using a simple depth stretch, *****\n")
  printf("      #***** no migration is done only a simple vertical depth         *****\n")
  printf("      #***** stretch. If you need a new velocity function, the awk     *****\n")
  printf("      #***** script IntVel2AveVelAwk.awk will regenerate the code      *****\n")
  printf("      #***** below. You should not have to change anything in this     *****\n")
  printf("      #***** program to run it.                                        *****\n")
  printf("      #*****                                                           *****\n")
  printf("      #*********************************************************************\n")
  printf("      #*********************************************************************\n")
  printf(" \n")
  printf("  DepthInt = %10.2f\n\n", DepthInt)
  printf("  printf(\" X-Coord     Y-Coord       2-Way    Z-Coord    Average \\n\")\n")
  printf("  printf(\"Latitude    Longitude      Time      Depth     Velocity\\n\")\n\n")
}
{
  IntVel = $2
  TotalDepth = $1
  OldDepthInt = TotalDepth - TotalDepthOld
  if ( OldDepthInt != DepthInt ) DepthInt = OldDepthInt
  if ( NR > SkipLines ){
    Index += 1
    if ( TotalDepth != 0.0 ) IntTime = DepthInt / IntVel
    TotalTime += IntTime
    if ( TotalTime != 0.0 ) AveVel = TotalDepth / TotalTime
    printf ("  AveVel[%4d] = %7.2f\n", Index, AveVel)
  }
  TotalDepthOld = TotalDepth
}
END{
  printf("}\n")
  printf("{\n")
  printf("  Index = int( $3/DepthInt + 0.5 )\n")
  printf("  if ( AveVel[Index] == 0.0 ) Time = 0.0\n")
  printf("  else Time = $3 / AveVel[Index]\n")
  print"  printf(\"%10.2f %10.2f %10.3f %10.2f %10.2f\\n\", $1, $2, Time*2.0, $3, AveVel[Index])"
  printf("}\n")
  printf("END{}\n")
  printf(" ")
}

