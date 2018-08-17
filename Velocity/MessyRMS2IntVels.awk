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
	# data file.                        #
	#                                   #
	# You can also specify a minimum    #
	# interval velocity you will allow  #
	# if this is specified and positive #
	# any interval velocity below this  #
	# will be replaced by this value.   #
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

	# Minimum allowed interval velocity (if negative set to zero)
	Min_IntVel = 1500.00
	# Maximum allowed interval velocity (if negative set to 99999)
	Max_IntVel = 8000.00

	# 2Way Time units enter: (1) for milliseconds,
	#                        (2) for seconds
        TimeUnits = 1

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
	if ( Max_IntVel < 0.0 ) Max_IntVel = 99999.0
	TimeScale = 2000.00
        if ( TimeUnits == 1 ) TimeScale = 2000.0
	if ( TimeUnits == 2 ) TimeScale = 2.0
				print "Minimum interval velocity: ",Min_IntVel
				print "Maximum interval velocity: ",Max_IntVel
				print "TimeScale:                 ",TimeScale

	printf ("#   Column        Row    Easting   Northing   Time     Fixed Velocity  Interval Vel.  Depth          Original Vel.  Difference of Vels.\n")
}
{

  if ( NR > IntLineSkip ) {
    if ( $Col_Time < OldTime ) {
      FirstTimeFlag = 0
    }
    if ( FirstTimeFlag == 0 ) {
      OldVrms = $Col_Velocity
      OrigVrms = $Col_Velocity
      OldTime = $Col_Time
      OldEast = $Col_X_Coord
      OldNorth = $Col_Y_Coord
      OldCol = $Col_Surv_Col
      OldRow = $Col_Surv_Row
	
      Depth = 0
      IntVel = Min_IntVel
      FirstTimeFlag = 1
      DifVrms = OrigVrms - OldVrms
      printf ("%10d %10d " ,OldCol,OldRow )
      printf ("%10.1f %10.1f " ,OldEast,OldNorth )
      printf ("%8.1f %14.2f %10.1f %14.2f " ,OldTime,OldVrms,IntVel,Depth )
      printf ("%14.2f %14.2f\n" ,OrigVrms,DifVrms )

    }
    else {
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

	if ( DeltT > 0 ) {
	  if ( OldTemp > NewTemp ) {
	    NewIntVel = Min_IntVel
	  }
	  else {
	    NewIntVel = sqrt( (NewTemp - OldTemp) / DeltT )
	  }
	  if ( NewIntVel < Min_IntVel ) {
	    if ( IntVel < Min_IntVel ) IntVel = Min_IntVel
	    if ( IntVel > Max_IntVel ) IntVel = Max_IntVel
	    NewVrms = sqrt( OldTemp/NewTime + DeltT*IntVel*IntVel/NewTime )
	    Depth = Depth + IntVel * DeltT / TimeScale
	  }
	  else {
	    IntVel = NewIntVel
	    if ( IntVel > Max_IntVel ) IntVel = Max_IntVel
	    Depth = Depth + IntVel * DeltT / TimeScale
	  }
	  if ( NewIntVel < Min_IntVel ){
	    if ( IntVel < Min_IntVel ) {
	      IntVel = Min_IntVel
	    }
	    if ( IntVel > Max_IntVel ) {
	      IntVel = Max_IntVel
	    }
	    NewVrms = sqrt( OldTemp/NewTime + DeltT*IntVel*IntVel/NewTime )
	    Depth = Depth + IntVel * DeltT / TimeScale
	  }
	  else {
	    IntVel = NewIntVel
	    if ( IntVel > Max_IntVel ){
	      IntVel = Max_IntVel
	    }
	    Depth = Depth + IntVel * DeltT / TimeScale
	  }
			
	  OldVrms = NewVrms
	  OldTime = NewTime
			
	  DifVrms = OrigVrms - NewVrms

	  printf ("%10d %10d " ,NewCol,NewRow)				    
	  printf ("%10.1f %10.1f " ,NewEast,NewNorth)			    
	  printf ("%8.1f %14.2f %10.1f %14.2f " ,NewTime,NewVrms,IntVel,Depth)
	  printf ("%14.2f %14.2f\n" ,OrigVrms,DifVrms )                       
	}

      OldVrms = NewVrms
      OldTime = NewTime
			
      DifVrms = OrigVrms - NewVrms

      printf ("%10d %10d " ,NewCol,NewRow)				    
      printf ("%10.1f %10.1f " ,NewEast,NewNorth)			    
      printf ("%8.1f %14.2f %10.1f %14.2f " ,NewTime,NewVrms,IntVel,Depth)
      printf ("%14.2f %14.2f\n" ,OrigVrms,DifVrms )                       
    }
  }
}
END{}
