BEGIN{
	#***************************************************************
	#***************************************************************
	#****                                                       ****
	#**** Program to convert Geco supplied 6 column 3D velocity ****
	#**** informtion into 8 column format with new calculated   ****
	#**** Dix interval velocities and Depths included.          ****
	#**** If times do not increase the values will be deleted.  ****
	#****                                                       ****
	#***************************************************************
	#***************************************************************

	#####################################
	#                                   #
	#  You might want to change the     #
	#  following parameters for a       #
	#  particular run.                  #
	#                                   #
	#  This program is ment for data    #
	#  in a 6 column format containing: #
	#                                   #
	#  		Row,Column,         #
	#               Easting, Northing   #
	#               Time, Velocity      #
	#                                   #
	#  in any order which you can       #
	#  specify below.                   #
	#                                   #
	# However any file with Time and    #
	# Velocity will work by specifying  #
	# the other columns as repeats of   #
	# ones you actually have in your    #
	# data file. You must have time     #
	# and velocities in your input.     #
	#                                   #
	#####################################

	# Number of Initial lines in file to skip
	IntLineSkip = 0

	# Column number in file  of X coordinates (Easting)
	Col_X_Coord = 1
	# Column number in file  of Y coordinates (Northing)
	Col_Y_Coord = 2
	# Column number in file  of 2 Way Time
	Col_Time = 3
	# Column number in file  of Velocity
	Col_Velocity = 4
	# Column number in file of Survey Column Number
	Col_Surv_Col = 1
	# Column number in file of Survey Row Number
	Col_Surv_Row = 2

	# Title for Velocity file
	printf ("# Test of Hatem \n")
	printf ("# Adjusted to eliminate negative interval velocities\n")
	printf ("# The interval velocity is kept constant when this occures\n")
	printf ("#\n")

	############################################
	#                                          #
	#  Should be able to leave the rest alone  #
	#                                          #
	############################################

	FirstTimeFlag = 0
	OldTime = 0
        if ( Min_IntVel < 0.0 ) Min_IntVel = 0.0

	printf ("#   Column        Row    Easting   Northing   Time     Fixed Velocity  Interval Vel.  Depth          Original Vel.  Difference of Vels.\n")
}
{

	if ( NR > IntLineSkip )
	{
		if ( $Col_Time < OldTime )
		{
			FirstTimeFlag = 0
		}
		if ( FirstTimeFlag == 0 )
		{
			OldVrms = $Col_Velocity
			OrigVrms = $Col_Velocity
			OldTime = $Col_Time
			OldEast = $Col_X_Coord
			OldNorth = $Col_Y_Coord
			OldCol = $Col_Surv_Col
			OldRow = $Col_Surv_Row

			Depth = 0
			IntVel = 0
			FirstTimeFlag = 1
			DifVrms = OrigVrms - OldVrms
			printf ("%10d %10d %10.1f %10.1f %8.1f %14.2f %10.1f %14.2f %14.2f %14.2f\n" ,OldCol,OldRow,OldEast,OldNorth,OldTime,OldVrms,IntVel,Depth,OrigVrms,DifVrms )

		}
		else
		{
			NewVrms = $Col_Velocity
			OrigVrms = $Col_Velocity
			NewTime = $Col_Time
			NewEast = $Col_X_Coord
			NewNorth = $Col_Y_Coord
			NewCol = $Col_Surv_Col
			NewRow = $Col_Surv_Row

			OldTemp = OldTime*OldVrms*OldVrms
			NewTemp = NewTime*NewVrms*NewVrms
			DeltT = NewTime - OldTime
			if ( DeltT > 0 )
			{
				if ( OldTemp > NewTemp )
				{
	
					NewVrms = sqrt( OldTemp/NewTime + DeltT*IntVel*IntVel/NewTime )
					Depth = Depth + IntVel * DeltT / 2000.0
				}
				else
				{
					IntVel = sqrt( (NewTemp - OldTemp) / DeltT )
					Depth = Depth + IntVel * DeltT / 2000.0
				}

			
				OldVrms = NewVrms
				OldTime = NewTime
			
				DifVrms = OrigVrms - NewVrms

				printf ("%10d %10d %10.1f %10.1f %8.1f %14.2f %10.1f %14.2f %14.2f %14.2f\n" ,NewCol,NewRow,NewEast,NewNorth,NewTime,NewVrms,IntVel,Depth,OrigVrms,DifVrms )
			}
		}
	}
}
END{}


