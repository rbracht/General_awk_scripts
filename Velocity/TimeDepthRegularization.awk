BEGIN{
	#***************************************************************
	#***************************************************************
	#****                                                       ****
	#**** Program to change time depth data and output a        ****
	#**** sampled version at regular intervals. The sampling    ****
	#**** occures over a user specified time interval and at    ****
	#**** user specified time increments.                       ****
	#****                                                       ****
	#**** Addtionally the program will output the associated    ****
	#**** RMS, Average and Interval velocities. An additional   ****
	#**** two columns will be read and assumed to be the        ****
	#**** Northing (Y) and Easting (X) value for the T-D curve. ****
	#**** This information will also be output.                 ****
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
	InitLineSkip = 15

	# Column number in file  of 2 Way Time
	Col_Time = 3

	# Column number in file  of Depth
	Col_Depth = 5

	# Column number in file of Northing (Y-coordinate)
	Col_Y = 2

	# Column number in file of Easting (X-coordinate)
	Col_X = 1


	# Minimum time to start regulariztion                      
	Min_Time = 0.0

	# Maximum time to end regulariztion                      
	Max_Time = 6000.0

	# Time sampling interval
	Time_Samp_Interval = 20.0

	# Minimum depth associated with minimum time
	Min_Depth = 0.0

	# 2Way Time units enter: (1) for milliseconds,
	#                        (2) for seconds
        TimeUnits = 1

	# Input depth units: (1) m
	#                    (2) ft
	DepthUnits = 1

	# Output velocity units: (1) m/s
	#                        (2) ft/s
	#                        (3) m/ms
	#                        (4) ft/ms
	VelUnits = 1


	# Title for Velocity file
	printf ("# Resampled Time-Depth curve             \n")

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
	  printf ("| Units of in/output depth is:%20s  |\n", PrintDepth)
	  printf ("| Units of output velocity is:%20s  |\n", PrintVel)
	  printf ("|                                                   |\n")
	  printf ("+---------------------------------------------------+\n")
	  printf ("|                                                   |\n")
	  printf ("| Input                                             |\n")
	  printf ("| Two way time is in column:  %20d  |\n", Col_Time)
          printf ("| Depth is in column:         %20d  |\n", Col_Depth)
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
	    T = Min_Time
	    T_Inc = 0
	    Dt = Time_Samp_Interval
}
{

  if (  NR > InitLineSkip ) {
    
    if ( $Col_Time * TimeScale < T2 && FirstLayer != 0 ) {
      FirstLayer = 0
      T = Min_Time
      T_Inc = 0
      V1 = 0.0
      Vrms = 0.0
      Depth = 0.0
    }
    if ( FirstLayer == 0 ) {

        D1 = Min_Depth
	T1 = Min_Time
        T2 = $Col_Time * TimeScale
	D2 = $Col_Depth * DepthScale
	X_Coord = $Col_X
	Y_Coord = $Col_Y

	T += T_Inc * Dt

	DelD = D2 - D1
	DelT = T2 - T1

	if ( DelT == 0.0 ) {
          m = 1.0
        }
        else {
          m = DelD / DelT
        }

	while ( T >= T2 ) {

	  Depth = m*(T - T1) + D1

	  if ( T-T1 == 0.0 ) {
	    IntVel = 0.0
	  }
	  else {
	    IntVel = 2.0 * (Depth - D1)/(T - T1)
	  }
	  V1 += 2.0 * IntVel * IntVel * Dt

	  if ( T == 0.0 ) {
	    Vrms = 0.0
          }
          else {
	    Vrms += sqrt( 2.0 * V1 / T )
	  }

	  printf ("%10.2f %10.2f ", X_Coord, Y_Coord )
	  printf ("%9.2f %9.2f ", T, Depth )
	  printf ("%9.2f %9.2f\n",  IntVel, Vrms )

	  T += T_Inc * Dt
	}
	FirstLayer = 1
    }
    if ( FirstLayer != 0 && T <= Max_Time) {

      D1 = D2
      D2 = $Col_Depth * DepthScale
      T1 = T2
      T2 = $Col_Time * TimeScale
      X_Coord = $Col_X
      Y_Coord = $Col_Y

      T += T_Inc * Dt

      DelD = D2 - D1
      DelT = T2 - T1

      if ( DelT == 0.0 ) {
        m = 1.0
      }
      else 
        m = DelD / DelT
      }


      while ( T <= T1 && T >= T2 ) {

	Depth = m*(T - T1) + D1

	if ( T-T1 == 0.0 ) {
	  IntVel = 0.0
	}
	else {
	  IntVel = 2.0 * (Depth - D1)/(T - T1)
	}

	IntVel = 2.0 * (Depth - D1)/(T - T1)
	V1 += 2.0 * IntVel * IntVel * Dt
	Vrms += sqrt( 2.0 * V1 / T )
	
	printf ("%10.2f %10.2f ", X_Coord, Y_Coord )
	printf ("%9.2f %9.2f ", X_Coord, Y_Coord )
	printf ("%9.2f %9.2f\n",  IntVel, Vrms )
	
	T += T_Inc * Dt
      }
    }

}
END{}
