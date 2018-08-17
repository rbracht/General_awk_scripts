# +----------------------------------------------------------------+
# |                                                                |
# | This awk script changes the shear, compressional velocities    |
# | and densities to user specified values using the the template  |
# | file "LasEidtInput.las" as the starting template. This file    |
# | will not accomodate aribitrary las inputs at this time. Your   |
# | input must be in miroseconds per feet for velocities and     . |
# | densities in grams per cubic centimeter. If your input depths  |
# | are in meters this must be converted into english units. You   |
# | can do this by setting the "Convert2English" flag to 1.        |
# |                                                                |
# | You need input the number of interfaces in your model and the  |
# | rock properties ubove each of the interfaces (shear travel     |
# | time, compressional travel time and density). And if unit      |
# | conversion is desired (only for depths) set the above mentioned|
# | flag to 1.                                                     |
# |                                                                |
# +----------------------------------------------------------------+

BEGIN{


#######################################
#
# Enter the number of interfaces below
#
########################################
  N_Interfaces = 4


#######################################
#
# The following are "N_Interfaces" 
# entries of:
#
#     D[i] <= Depth to interface
#     DTS[i] <= shear travel time 
#     DTS[i] <= compresional travel
#     RHO[i] <= density
#     
# All properties refer to material 
# above the i'th interface.
#
########################################

  D[1] = 1500  
  DTS[1] = 356 
  DTP[1] = 141 
  RHO[1] = 2.23

  D[2] = 1515  
  DTS[2] = 348 
  DTP[2] = 167 
  RHO[2] = 1.86

  D[3] = 1530  
  DTS[3] = 348 
  DTP[3] = 167 
  RHO[3] = 1.86

  D[4] = 1531  
  DTS[4] = 356 
  DTP[4] = 141 
  RHO[4] = 2.23


#######################################
#
# Set the variable below to 1 if you
# wish to convert the depths above to
# the needed English units.
#
########################################
  Convert2English = 1

#####################################################
#####################################################
###                                               ###
###  You should be able to leave the rest alone.  ###
###                                               ###
#####################################################
#####################################################

  SkipLines = 47


    if (Convert2English == 1) {
      for ( i = 1; i <= N_Interfaces; i++) {
	D[i] = D[i] / .3048
      }
    }
}
{
  
  if ( NR > SkipLines) {

    Depth = $1
    Cali = $2
    Dtco = $3
    Dtsm = $4
    Gr = $5
    Nphi = $6
    Rhob = $7
    Rs = $8
    Rt = $9

    for ( i = 2; i <= N_Interfaces; i++ ) {
      if ( Depth >= 0 && Depth < D[1] ){
	Dtco = DTP[1]												   
	Dtsm = DTS[1]												   
	Rhob = RHO[1]												   
	printf ("%12.4f%13.4f%13.4f%13.4f",Depth,Cali,Dtco,Dtsm)
	printf ("%13.4f%13.4f%13.4f%13.4f%13.4f\n",Gr,Nhpi,Rhob,Rs,Rt)
      }
      else if ( Depth >= D[i-1] && Depth < D[i] ){
        Dtco = DTP[i-1] - ( (DTP[i-1] - DTP[i])/(D[i-1] - D[i]) ) * (D[i-1] - Depth)
        Dtsm = DTS[i-1] - ( (DTS[i-1] - DTS[i])/(D[i-1] - D[i]) ) * (D[i-1] - Depth)
        Rhob = RHO[i-1] - ( (RHO[i-1] - RHO[i])/(D[i-1] - D[i]) ) * (D[i-1] - Depth)
	printf ("%12.4f%13.4f%13.4f%13.4f",Depth,Cali,Dtco,Dtsm)
	printf ("%13.4f%13.4f%13.4f%13.4f%13.4f\n",Gr,Nhpi,Rhob,Rs,Rt)
      }
      else if ( Depth > D[N_Interfaces] ) {
	Dtco = DTP[N_Interfaces]
	Dtsm = DTS[N_Interfaces]
	Rhob = RHO[N_Interfaces]
	printf ("%12.4f%13.4f%13.4f%13.4f",Depth,Cali,Dtco,Dtsm)
	printf ("%13.4f%13.4f%13.4f%13.4f%13.4f\n",Gr,Nhpi,Rhob,Rs,Rt)
      }
    }
  }
  else print $0
}
END{}
	
      
      
