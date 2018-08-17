BEGIN{
	#***************************************************************
	#***************************************************************
	#****                                                       ****
	#**** Program to resample interval velocity data in time or ****
	#**** depth and output the resampled interval velocities    ****
	#**** and the newly calculated RMS velocities. If the       ****
	#**** interval of resampling is larger than the interval    ****
	#**** of the data input then within the sampled interval    ****
	#**** the time weighted average of the velocities within    ****
	#**** that interval will be used to represent that block.   ****
	#**** If the interval of resampling is smaller than the     ****
	#**** intervals within the input file the interval velocity ****
	#**** will be kept constant for all resampled intervals     ****
	#**** within the block.                                     ****
	#****                                                       ****
	#**** This program will skip a user specified number of     ****
	#**** initial lines then use two user chosen columns for    ****
	#**** time/depth and interval velocity and resample these   ****
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
	# A maximum interval velocity can   #
	# also be specified and the all     #
	# values greater than this will be  #
	# clipped to this value.            #
	#                                   #
	#####################################

	# Number of Initial lines in file to skip
	IntLineSkip = 7

	# Column number in file  of X coordinates (Easting)
	Col_X_Coord = 1
	# Column number in file  of Y coordinates (Northing)
	Col_Y_Coord = 2
	# Column number in file  of 2 Way Time
	Col_Time = 3
	# Column number in file  of Velocity
	Col_Velocity = 4
	# Column number in file of Survey Column Number
	Col_Surv_Col = 5
	# Column number in file of Survey Row Number
	Col_Surv_Row = 2

	# Minimum allowed interval velocity (if negative set to zero)
	Min_IntVel = 1500.00

	# Maximum allowed interval velocity (if negative set to 99999.0)
	Max_IntVel = 7000.00

	# Interval velocity to use for the first or surface layer
	Top_IntVel = 1500.00

	# 2Way Time units enter: (1) for milliseconds,
	#                        (2) for seconds
        TimeUnits = 1

	# Title for Velocity file
	printf ("# Test of Hatem \n")
	printf ("# Adjusted to eliminate negative interval velocities\n")
	printf ("# The interval velocity is kept constant when this occures\n")
        printf ("# Interval velocities are not allowed to be beyond the range (%7.1f,%7.1f)\n", Min_IntVel, Max_IntVel )
	printf ("# If the interval velocities are beyond this range they will be forced within this range\n" )
	printf ("#\n")

	############################################
	#                                          #
	#  Should be able to leave the rest alone  #
	#                                          #
	############################################
