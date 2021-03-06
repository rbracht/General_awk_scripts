BEGIN{
	#********************************************************************
	#********************************************************************
	#*****                                                          *****
	#***** This program will calculate the (X,Y) Coordinates of     *****
	#***** user specified lines and traces. These line, trace       *****
	#***** pairs will be expected to be in the input file with      *****
	#***** one pair on each line.                                   *****
	#*****                                                          *****
	#***** To specify the reference geometry needed                 *****
	#***** you need only supply three points in any order. These    *****
	#***** points are referenced by their trace and line (colmumn   *****
	#***** and row) numbers along with their corresponding x and y  *****
	#***** (easting and northing) coordinates.                      *****
	#*****                                                          *****
	#***** This program will calculate the                          *****
	#***** easting and northing from the supplied line and trace    *****
	#***** numbers using the three control points.                  *****
	#*****                                                          *****
	#***** The control points are specified below.                  *****
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

	# If you wish to supress discriptive header information
	# enter a 1 for the following variable.

	DiscriptInfo = 0

	#**********************Start of 1st Set of Parameters*****************
	#
	#       (Trace1 , Line1)                     
	#               |                           
	#               V                           
	#               1--------------------------------+
	#               |                                |
	#               |                                |  Note: points need
	#               |                                |        not be retangular
	#               |                                |        corner points
	#               |                                |
	# (Trace2, ---> 2--------------------------------3
	#   Line2)                                       ^
	#                                                |
	#                                        (Trace3 , Line3)
	#          
	#       
	# Defining three points of the survey in terms of traces and lines
        # or columns and rows. Again, these can be arbitrary points.
	# Refer to diagram above for these parameters.
	# This sets up the three points as numbered in the diagram.
	# The (x,y) or (easting,northing) values of these points 
	# will need to be input below.

	# Trace or column number for first point
	Trace1 = 14481
	# Line or row number for first point
	Line1 = 10001

	# Trace or column number for second point
	Trace2 = 10001
	# Line or row number for second point
	Line2 = 10001

	# Trace or column number for third point
	Trace3 = 10001
	# Line or row number for third point
	Line3 = 14001

	#**********************End of 1st set of Prameters********************


	#**********************Start of 2nd Set of Parameters***************
	#
        #                                            / \             
        #                                         /     \             
        #                                      /         \            
        #                                   /             \           
        #                                /                 \          
        #                             /                     \         
        #                          /                         \
        #                       /              (x3,y3) ---->  3
        #                    /                               /             
        #     (x1,y1) --->  1                             /              
        #                    \                         /                
        #                     \                     /                      
        #                      \                 /                         
        #                       \            /                             
        #                        \       /
        #                         \ /
        #           (x2,y2) ---->  2     
	#
	#     
	# Defining the three corner points in terms of (x,y) or
	# (easting,northing). These points should correspond to 
	# the three points you choose when specifying them
	# in terms of traces and Lines (rows and columns) above.
	# Refer to the diagram above for how the points are defined
	# the points 1,2,3 are the same 1,2,3 points of the previous
	# diagram.
 
	x1 = 447000.0
	y1 = 956400.0

	x2 = 559000.0
	y2 = 956400.0

	x3 = 559000.0
	y3 = 1056400.0

	#**********************End of 2nd set of Prameters*****************


	#**********************Start of 3rd Set of Parameters**************
	#
	# This third  parameter allows you to specify a unique indetifier
	# for this arbitrary line.

	UniqueID = "z3d_wst Corner Points"
	UniqueNum = 1

	#**********************End of 3rd set of Prameters******************

	#**********************Start of 4th Set of Parameters***************
	#
	# This set allows you to enter some comments into the file to be 
	# generated.
	# 

	if ( DiscriptInfo != 1 ){
		printf ("# User input control points.\n")
		printf ("#\n")				
		printf ("# Point number   Trace    Line   X-coordinate Y-coordinate\n")
		printf ("#      1       %6d   %6d    %10.2f   %10.2f\n", Trace1,Line1,x1,y1)
		printf ("#      2       %6d   %6d    %10.2f   %10.2f\n", Trace2,Line2,x2,y2)
		printf ("#      3       %6d   %6d    %10.2f   %10.2f\n", Trace3,Line3,x3,y3)
		printf ("#\n")					
		printf ("#\n")					

		printf ("# (X,Y) Values will be calculated for\n# the following Line, Traces pairs:\n")
		printf ("#\n")				
	}		

	#**********************End of 4th set of Prameters******************




	
	##################################################
	##################################################
	##################################################
	####                                          ####
	####  Should be able to leave the rest alone  ####
	####                                          ####
	##################################################
	##################################################
	##################################################




	# Intermediate results needed for
	# caculating trace and line increments

	  DL12 = Line2 - Line1
	  DL13 = Line3 - Line1
	  DL23 = Line3 - Line2

	  DT12 = Trace2 - Trace1
	  DT13 = Trace3 - Trace1
	  DT23 = Trace3 - Trace2

	  D12 = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1)
	  D13 = (x3-x1)*(x3-x1) + (y3-y1)*(y3-y1)
	  D23 = (x3-x2)*(x3-x2) + (y3-y2)*(y3-y2)


	  A11 = (DL12^4) + (DL13^4) + (DL23^4)
	  A12 = (DL12^2 * DT12^2) + (DL13^2 * DT13^2) + (DL23^2 * DT23^2) 
	  A22 = (DT12^4) + (DT13^4) + (DT23^4)

	  B1 = (DL12^2 * D12) + (DL13^2 * D13) + (DL23^2 * D23)
	  B2 = (DT12^2 * D12) + (DT13^2 * D13) + (DT23^2 * D23)

	  Det = (A11*A22 - A12*A12)
	  if ( Det == 0.0 )
	    {
	      print " "
	      print " "
              print "*******************************************************************"
              print "*******************************************************************"
	      print "*******************************************************************"
	      print "*****                                                         *****"
	      print "***** There appears to be a problem with your input points.   *****"
	      print "***** Check your input parameters and re-run program.         *****"
	      print "*****                                                         *****"
	      print "*******************************************************************"
	      print "*******************************************************************"
              print "*******************************************************************"
	      print " "
	      print " "
	      exit
	    }

	# Calculate the line and trace increments

	Dl = sqrt( (A22*B1 - A12*B2) / Det )
	Dt = sqrt( (A11*B2 - A12*B1) / Det )

	# Calculate line and trace offset from origin (0,0)
	  t1 = Trace1 * Dt
	  t2 = Trace2 * Dt
	  t3 = Trace3 * Dt

	  l1 = Line1 * Dl
	  l2 = Line2 * Dl
	  l3 = Line3 * Dl


	# Printing Q.C. information
#	print "Calculated Trace Increment:" Dt
#	print "Calculated Line Increment :" Dl
#	D12 = sqrt( (x2-x1)^2 + (y2-y1)^2 )
#	D13 = sqrt( (x3-x1)^2 + (y3-y1)^2 )
#	D23 = sqrt( (x3-x2)^2 + (y3-y2)^2 )
#	d12 = sqrt( (t2-t1)^2 + (l2-l1)^2 )
#	d13 = sqrt( (t3-t1)^2 + (l3-l1)^2 )
#	d23 = sqrt( (t3-t2)^2 + (l3-l2)^2 )
#	print "Distance from point 1 to 2: " D12 " " d12
#	print "Distance from point 1 to 3: " D13 " " d13
#	print "Distance from point 2 to 3: " D23 " " d23
	n = 0
}
{
	if ( $1 != "" && $2 != "" ){
		n = n + 1
		l[n] = $1
		t[n] = $2
		if ( DiscriptInfo != 1 ){
			printf ("#     line(%3d) =%6d , trace(%3d) =%6d\n", n, l[n], n, t[n] )
		}
	}
}
END{
	PointCount = 1
	if ( DiscriptInfo != 1 ){
		printf ("#\n")
		printf ("#\n")	
		print "#   Row      Col    Point#   X_Coord    Y_Coord         Unique        Unique"
		print "#  Line     Trace            Easting    Northing      Identifier      Number\n"
	}
	# Calculate and print (x,y) values for specified traces and lines.

	for (i = 1; i <= n; i = i + 1)
	{
		    Row = l[i]
		    Col = t[i]
		    t0 = Col * Dt
		    l0 = Row * Dl

		    d1 = (t0 - t1)^2 + (l0 - l1)^2
		    d2 = (t0 - t2)^2 + (l0 - l2)^2
		    d3 = (t0 - t3)^2 + (l0 - l3)^2

		    g1 = d1 - d2 + x2^2 - x1^2 + y2^2 - y1^2
		    g2 = d2 - d3 + x3^2 - x2^2 + y3^2 - y2^2

		    Det = (x2 - x1)*(y3 - y2) - (x3 - x2)*(y2 - y1)

		    New_X = ( (y3-y2)*g1 - (y2-y1)*g2 ) / (2*Det)
 		    New_Y = ( (x2-x1)*g2 - (x3-x2)*g1 ) / (2*Det)

		    printf (" %6d   %6d" ,Row ,Col )
		    printf (" %8d" ,PointCount )
		    printf (" %10.1f %10.1f " ,New_X ,New_Y )
		    printf (" %15s     %5d\n"  ,UniqueID ,UniqueNum )

		    PointCount += 1
	}

}
