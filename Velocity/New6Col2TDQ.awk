BEGIN{
	#***************************************************************
	#***************************************************************
	#****                                                       ****
	#**** Program to convert Geco supplied 6 column 3D velocity ****
	#**** informtion into TDQ format appropriate for input into ****
	#**** seisworks.                                            ****
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
	#  in a 6 column format conatining: #
	#                                   #
	#  		Row,Column,         #
	#               Easting, Northing   #
	#               Time, Velocity      #
	#                                   #
	#  in any order which you can       #
	#  specify below.                   #
	#                                   #
	#####################################

	# Number of Initial lines in file to skip
	IntLineSkip = 10

	# Column number in file  of X coordinates (Easting)
	Col_X_Coord = 1
	# Column number in file  of Y coordinates (Northing)
	Col_Y_Coord = 2
	# Column number in file  of 2 Way Time
	Col_Time = 3
	# Column number in file  of Velocity
	Col_Velocity = 4
	# Column number in file of Survey Column Number (Line)
	Col_Surv_Col = 1
	# Column number in file of Survey Row Number (Trace)
	Col_Surv_Row = 2

	# Title for Velocity file
	printf ("# WM03 Fasttrack processing velocities\n")
	printf ("# Sent by Mohamed Fekry of PGS to Jim Keggin at BP\n")
	printf ("# Received on July 15, 2003\n")
	printf ("#\n")
	# Enter spatial units
	printf ("# FUNCTION_TYPE = TVrms\n")
	printf ("# Linear_Units = Meters\n")
	# Enter Static Datum level
	Datum_Level = 0

	############################################
	#                                          #
	#  Should be able to leave the rest alone  #
	#                                          #
	############################################

	printf ("# DATUM = %5d\n" ,Datum_Level)
	printf ("#\n")
	FirstTimeFlag = 0
	LastColNum = 9999999
	LastRowNum = 9999999
	PointCount = 1
}
{
	if ( NR > IntLineSkip )
	{
		if ( FirstTimeFlag == 0 )
		{
			printf ("%8.1f" ,PointCount )
			printf ("%10.1f%10.1f" ,$Col_X_Coord ,$Col_Y_Coord )
			printf ("%8.1f%14.2f\n" ,$Col_Time ,$Col_Velocity )
			LastColNum = $Col_Surv_Col
			LastRowNum = $Col_Surv_Row
			PointCount += 1
			FirstTimeFlag = 1
		}
		else
		{
			if ( $Col_Surv_Col == LastColNum && $Col_Surv_Row == LastRowNum )
			{
				printf ("                            " )
				printf ("%8.1f%14.2f\n" ,$Col_Time ,$Col_Velocity )
			}
			else
			{
				printf ("# DATUM = %5d\n" ,Datum_Level)
				printf ("%8.1f" ,PointCount )
				printf ("%10.1f%10.1f" ,$Col_X_Coord ,$Col_Y_Coord )
				printf ("%8.1f%14.2f\n" ,$Col_Time ,$Col_Velocity )
				LastColNum = $Col_Surv_Col
				LastRowNum = $Col_Surv_Row
				PointCount += 1
			}
		}
	}
}
END{}
