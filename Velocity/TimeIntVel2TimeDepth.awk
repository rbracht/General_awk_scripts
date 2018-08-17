BEGIN{
	#***************************************************************
	#***************************************************************
	#****                                                       ****
	#**** Program to change time interval velocities to time    ****
	#**** depth curves. The input file can contain any number   ****
	#**** of columns of which 2 must be time and interval       ****
	#**** velocity. This program will attach an additional      ****
	#**** column to the data which will be the depth. The       ****
	#**** columns with the time and interval velocities is      ****
	#**** specified by the user. The user can also specify      ****
	#**** an initial velocity that will be used for the first   ****
	#**** layer if this is negative or zero the first velocity  ****
	#**** encountered will be used. If this value is used then  ****
	#**** interval velocities read are assume to be for the     ****
	#**** below the associated time otherwise it will be        ****
	#**** assumed to be above.                                  ****
	#****                                                       ****
	#**** This program will skip a user specified number of     ****
	#**** initial lines then use two user chosen columns for    ****
	#**** time and interval velocity and resample these         ****
	#**** to user specified increments.                         ****
	#****                                                       ****
	#***************************************************************
	#***************************************************************


	#####################################
	#                                   #
	#  You might want to change the     #
	#  following parameters for a       #
	#  particular run.                  #
	#                                   #
	#####################################

	# Number of Initial lines in file to skip
	InitLineSkip = 0

	# Column number in file  of 2 Way Time
	Col_Time = 3
	# Column number in file  of Interval Velocity
	Col_Velocity = 4

	# Interval velocity to use for the first or surface layer
	# If negative or zero defaults to first velocity encountered
	# The units should be the same as your input file units.
	Top_IntVel = -1500.00

	# 2Way Time units enter: (1) for milliseconds,
	#                        (2) for seconds
        TimeUnits = 1

	# Interval velocity units: (1) m/s
	#                          (2) ft/s
	#                          (3) m/ms
	#                          (4) ft/ms
	VelUnits = 1

	# Output depth units: (1) m
	#                     (2) ft
	DepthUnits = 1


	# Title for Velocity file
	printf ("# Time/Depth from Time/Interval Velocity \n")

	############################################
	#                                          #
	#  Should be able to leave the rest alone  #
	#                                          #
	############################################
	  if ( TimeUnits == 1 ) {
	    PrintTime = "milliseconds"
	  }
	  else if ( TimeUnits == 2 ) {
	    PrintTime = "seconds"
	  }
	  else {
	    PrintTime = "default to milliseconds"
	    TimeUnits = 1
          }
	
    	  if ( DepthUnits == 1 ) {
	    PrintDepth = "meters"
	  }
	  else if ( DepthUnits == 2 ) {
	    PrintDepth = "feet"
	  }
	  else {
	    PrintDepth = "default to meters"
	    DepthUnits = 1
	  }
	    
    	  if ( VelUnits == 1 ) {
	    PrintVel = "meters/second"
	  }
	  else if ( VelUnits == 2 ) {
	    PrintVel = "feet/second"
	  }
	  else if ( VelUnits == 3 ) {
	    PrintDepth = "meters/milliseconds"
	  }
	  else if ( VelUnits == 4 ) {
	    PrintVel = "feet/millisecond"
	  }
	  else {
	    PrintVel = "default to meters/second"
	    VelUnits = 1
	  }
	  printf ("+---------------------------------------------------+\n")
	  printf ("|                                                   |\n")
	  printf ("| Units of input time is:     %20s  |\n", PrintTime)
	  printf ("| Units of input velocity is: %20s  |\n", PrintVel)
	  printf ("| Units of output depth is:   %20s  |\n", PrintDepth)
	  printf ("|                                                   |\n")
	  printf ("| Two way time is in column:  %20d  |\n", Col_Time)
          printf ("| Interval Vel is in column:  %20d  |\n", Col_Velocity)
	  printf ("|                                                   |\n")
	  printf ("| Last column will contain the calculated depths    |\n")
	  printf ("|                                                   |\n")
	  printf ("+---------------------------------------------------+\n")
	  printf ("\n\n")

#        All internal calculation will be done in meters and milliseconds
	    
	    if ( TimeUnits == 1 ) {
	      TimeScale = 1.0
	    }
	    else if ( TimeUnits == 2 ) {
	      TimeScale = 1000.0
	    }

	    if ( VelUnits == 1 ) {
	      VelScale = 0.001
	    }
	    else if ( VelUnits == 2 ) {
	      VelScale = 0.000305
	    }
	    else if ( VelUnits == 3 ) {
	      VelScale = 1.0
	    }
	    else if ( VelUnits == 4 ) {
	      VelScale = 0.3048
	    }

	    if ( DepthUnits == 1 ) {
	      DepthScale = 1.0
	    }
	    else if ( DepthUnits == 2 ) {
	      DepthScale = 3.2808
	    }

	    FirstLayer = 0
	    Depth = 0.0
}
{

  if (  NR > InitLineSkip ) {
    
    if ( $Col_Time * TimeScale < T2 && FirstLayer != 0 ) {
      FirstLayer = 0
      Depth = 0.0
    }

    if ( Top_IntVel <= 0.0 && FirstLayer == 0 ) {
      Depth = 0.0
      V1 = $Col_Velocity * VelScale
      T1 = 0.0
      T2 = $Col_Time * TimeScale
      DT = T2 - T1
      FirstLayer = 1
      Depth += V1 * DT / 2.0
    }
    else if ( Top_IntVel > 0.0 && FirstLayer == 0  ) {
      Depth = 0.0
      V1 = Top_IntVel * VelScale
      V2 = $Col_Velocity * VelScale
      T1 = 0.0
      T2 = $Col_Time * TimeScale
      DT = T2 - T1
      Depth += V1 * DT / 2.0
      FirstLayer = 1
    }
    else if ( Top_IntVel <= 0.0 && FirstLayer != 0 ) {
      V1 = $Col_Velocity * VelScale
      T1 = T2
      T2 = $Col_Time * TimeScale
      DT = T2 - T1
      Depth += V1 * DT / 2.0    
    }
    else if ( Top_IntVel > 0.0 && FirstLayer != 0  ) {
      V1 = V2
      V2 = $Col_Velocity * VelScale
      T1 = T2
      T2 = $Col_Time * TimeScale
      DT = T2 - T1
      Depth += V1 * DT / 2.0
    }


    DepthOut = Depth * DepthScale

    print $0,"  ",DepthOut
  }
}
END{}
