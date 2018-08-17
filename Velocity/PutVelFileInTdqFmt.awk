##############################################################################
#                                                                            #
# This Awk script takes a file of extracted velocity information in a 15     #
# column format and outputs them in a form, with cdp information, suitable   #
# to be imported into TDQ.                                                   #
#                                                                            #
# The imput file should be organized with the following column order:        #
#                                                                            #
#                1st column - X coordinate (Easting)                         #
#                2rd column - Y coordinate (Northing)                        #
#                3th column - k0 surface reference velocity                  #
#                4th column - z0 velocity gradient of layer from surface     #
#                5th column - v0 depth of surface layer                      #
#                6th column - z1                                             #
#                7th column - v1                                             #
#                    .                                                       #
#                    .                                                       #
#                    .                                                       #
#                14th column - z6                                            #
#                15th column - v6                                            #
#                                                                            #
# You also need to modify the number of lines to skip in your input file     #
# the depth increment of the first layer for the output, the basement or     #
# velocity at depth and the maximum depth to output below.                   #
#                                                                            #
##############################################################################

BEGIN {
##############################################################################
##############################################################################
###                                                                        ###
###  You may wish to modify the following parameters for a particular run  ###
###                                                                        ###
##############################################################################
##############################################################################

# Number of initial lines to skip in the input file
    LineSkip = 1

# Depth increment for interval velocities to be output for surface layer
    DepthInc = 20.0

# Reference depth for the surface layer
    Depth = 0.0

# Basement or velocity at depth 
    DeepVel = 4200.0

# Maximum depth for velocity output
    MaxDepth = 7000.0



####################################################################
####################################################################
###                                                              ###
###  You should be able to leave the rest of the program alone.  ###
###                                                              ###
####################################################################
####################################################################

printf ("# Velocity function from NGOS Prestack Migration Volume\n")
printf ("# FUNCTION_TYPE=DVint\n")
printf ("# LINEAR_UNITS=METERS\n")
printf ("# DATUM=0\n")
printf ("# X_OFFSET=0\n")
printf ("# Y_OFFSET=0\n")

ShotPoint = 0
}
{
    X_Coord = $1
    Y_Coord = $2

    k0 = $3
    z0 = $4
    v0 = $5
    z1 = $6
    v1 = $7
    z2 = $8
    v2 = $9
    z3 = $10
    v3 = $11
    z4 = $12
    v4 = $13
    z5 = $14
    v5 = $15

    if ( NR > LineSkip )
      {
	ShotPoint += 1
	  while ( Depth <= z0 ) 
	  {
	    Velocity = v0 + (k0 * Depth)
	      if ( Velocity >= DeepVel ) Velocity = DeepVel
	      printf ("%10d %12.3f %12.3f %10.3f %10.3f\n", ShotPoint, X_Coord, Y_Coord, Depth, Velocity) 
	      Depth += DepthInc
	  }
          printf ("%10d %12.3f %12.3f %10.3f %10.3f\n", ShotPoint, X_Coord, Y_Coord, Depth, v1)

	  if ( z1 > Depth ) {
	    printf ("%10d %12.3f %12.3f %10.3f %10.3f\n", ShotPoint, X_Coord, Y_Coord, z1, v1)
	  }

	  if ( z2 > z1 && z2 > Depth ) {
	    printf ("%10d %12.3f %12.3f %10.3f %10.3f\n", ShotPoint, X_Coord, Y_Coord, z2, v2)
	  }

	  if ( z3 > z2 && z3 > z1 && z3 > Depth ) {
	    printf ("%10d %12.3f %12.3f %10.3f %10.3f\n", ShotPoint, X_Coord, Y_Coord, z3, v3)
	  }

	  if ( z4 > z3 && z4 > z2 && z4 > z1 && z4 > Depth ) {
	    printf ("%10d %12.3f %12.3f %10.3f %10.3f\n", ShotPoint, X_Coord, Y_Coord, z4, v4)
	  }

	  if ( z5 > z4 && z5 > z3 && z5 > z2 && z5 > z1 && z5 > Depth ) {
	    printf ("%10d %12.3f %12.3f %10.3f %10.3f\n", ShotPoint, X_Coord, Y_Coord, z5, v5)
	  }

  printf ("%10d %12.3f %12.3f %10.3f %10.3f\n", ShotPoint, X_Coord, Y_Coord, MaxDepth, DeepVel) 
      }
    Depth = 0.0
}
END{}
