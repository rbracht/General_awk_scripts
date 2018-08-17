##############################################################################
#                                                                            #
# This Awk script takes a file of extracted velocity information in a 14     #
# column format and outputs them in a form, with cdp information, suitable   #
# to be imported into ProMAX.                                                #
#                                                                            #
# The imput file should be organized with the following column order:        #
#                                                                            #
#                1st column - Shot point (Station) number                    #
#                2nd column - X coordinate (Easting)                         #
#                3rd column - Y coordinate (Northing)                        #
#                4th column - V0 surface reference velocity                  #
#                5th column - k0 velocity gradient of layer from surface     #
#                6th column - z0 depth of surface layer                      #
#           columns 7 to 14 - contain the velocity and depth of the          #
#                             subsiquent layers.                             #
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
    DepthInc = 50.0

# Reference depth for the surface layer
    Depth = 0.0

# Basement or velocity at depth 
    DeepVel = 4500.0

# Maximum depth for velocity output
    MaxDepth = 6000.0

# Reference Shotpoint 1
    Shot1 = 30

# Reference CDP 1
    Cdp1 = 58

# Reference Shotpoint 2
    Shot2 = 31

# Reference CDP 2
    Cdp2 = 60


####################################################################
####################################################################
###                                                              ###
###  You should be able to leave the rest of the program alone.  ###
###                                                              ###
####################################################################
####################################################################

}
{
    ShotPoint = $1
    X_Coord = $2
    Y_Coord = $3
    v0 = $4
    k0 = $5
    z0 = $6
    v1 = $7
    z1 = $8
    v2 = $9
    z2 = $10
    v3 = $11
    z3 = $12
    v4 = $13
    z4 = $14
    v5 = $15
    DeepVel = v5
    m = (Shot1 - Shot2) / (Cdp1 - Cdp2)
    cdp = (ShotPoint - Shot1)/m + Cdp1
    if ( NR > LineSkip )
      {
	  while ( Depth <= z0 ) 
	  {
	    Velocity = v0 + (k0 * Depth)
	      printf ("%10d %10d %12.3f %12.3f %10.3f %10.3f\n", cdp, ShotPoint, X_Coord, Y_Coord, Depth, Velocity) 
	      Depth += DepthInc
	  }
	  printf ("%10d %10d %12.3f %12.3f %10.3f %10.3f\n", cdp, ShotPoint, X_Coord, Y_Coord, z1, v1) 
	  printf ("%10d %10d %12.3f %12.3f %10.3f %10.3f\n", cdp, ShotPoint, X_Coord, Y_Coord, z2, v2) 
	  printf ("%10d %10d %12.3f %12.3f %10.3f %10.3f\n", cdp, ShotPoint, X_Coord, Y_Coord, z3, v3) 
	  printf ("%10d %10d %12.3f %12.3f %10.3f %10.3f\n", cdp, ShotPoint, X_Coord, Y_Coord, z4, v4) 
	  printf ("%10d %10d %12.3f %12.3f %10.3f %10.3f\n", cdp, ShotPoint, X_Coord, Y_Coord, MaxDepth, DeepVel) 
	  printf ("\n")
      }
    Depth = 0.0
}
END{}
