BEGIN{
	#********************************************************************
	#********************************************************************
	#*****                                                          *****
	#***** This program will take as input a file with 7 columns    *****
	#***** (like the output of "ArbLine2XY_Conversion.nawk")        *****
	#*****                                                          *****
	#*****      In-line #, X-line #, point counter, Easting,        *****
	#*****      Northing, Arbitrary text, Arbitrary Integer         *****
	#*****                                                          *****
	#***** and interpolate at a user specified increment            *****
	#*****                                                          *****
	#*****      "InterpDist"                                        *****
	#*****                                                          *****
	#***** the points and interpolated points are output in a 7     *****
	#***** column format with the same order and content as the     *****
	#***** input.                                                   *****
	#*****                                                          *****
	#***** The interpolation distance is the only required          *****
	#***** variable below to be set by the user.                    *****
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

  # The distance between points
  #
  InterpDist = 500.0



	
	##################################################
	##################################################
	##################################################
	####                                          ####
	####  Should be able to leave the rest alone  ####
	####                                          ####
	##################################################
	##################################################
	##################################################




  First = 1
  spno = 1
  id = InterpDist
}
{
  if ( First != 1) {
    il2 = $1
    xl2 = $2
    x2 = $4
    y2 = $5

    m = (x1-x2)/(y1-y2)
    dx = x2 - x1
    dy = y2 - y1
    dil = il2 - il1
    dxl = xl2 - xl1
    Dist = sqrt( dx*dx + dy*dy )
    IntDist = id 

    while ( IntDist < Dist ) {
        ratio = IntDist/Dist
        spno = spno + 1
        newy = y1 + ( dy * ratio )
        newx = x1 + ( dx * ratio )
        newil = il1 + ( dil * ratio)
        newxl = xl1 + ( dxl * ratio)
        printf("%7.1f  %7.1f ",newil, newxl)
        printf("%8d ", spno)
        printf("%10.1f %10.1f ", newx, newy)
        printf("%16s %9d\n", UniqueId, UniqueNum)
	IntDist = IntDist + id
    }

    spno = spno + 1
    printf("%7.1f  %7.1f ",il2, xl2)
    printf("%8d ", spno)
    printf("%10.1f %10.1f ", x2, y2)
    printf("%16s %9d\n", UniqueId, UniqueNum)

    x1 = x2
    y1 = y2
    il1 = il2
    xl1 = xl2

  }
  if ( First == 1 ) {
    il1 = $1
    xl1 = $2
    x1 = $4
    y1 = $5
    UniqueId = $6
    UniqueNum = $7
    printf("%7.1f  %7.1f ",il1, xl1)
    printf("%8d ", spno)
    printf("%10.1f %10.1f ", x1, y1)
    printf("%16s %9d\n", UniqueId, UniqueNum)
    First = 2
  }
}
END{}



    
