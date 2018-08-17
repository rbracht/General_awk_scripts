# +----------------------------------------------------------------+
# |                                                                |
# |  This awk script will take user input parameters: zero         |
# |  offset twt,interval velocity, rms velocity. The input file    |
# |  should contain the offsets in consistent units (eg. m, m/s,s) |
# |  The output file will be the same as the input file with       |
# |  one additional column added with the calculated incident      |
# |  angle calculated (Leading Edge, Elastic Impedence, Patrick    |
# |  Connolly pg 448 equation (2.1) April 1999)                    |
# |                                                                |
# +----------------------------------------------------------------+

BEGIN{

# You may wish to change the following for a particular run

# The zero offset two way transit time to target
  TwoWayTime = 1.240

# The root mean square velocity at target
  Vrms = 7560.0

# The interval velocity above target
  Vint = 7989.0

# The column number containing the offset in input file
  OffsetColNum = 1

# The number of initial lines to skip
  SkipLines = 3

################################################ 
#                                              #
#  You should be able to leave the rest alone  #
#                                              #
################################################
 
  pi = atan2(1,1)*4

}
{

  if ( NR <= SkipLines ) {
    print $0
  }
  else {
    Off = $OffsetColNum
    OffSq = Off * Off
    TwtSq = TwoWayTime * TwoWayTime
    VintSq = Vint * Vint
    VrmsSq = Vrms * Vrms
    SinSq = (OffSq * VintSq)/(VrmsSq*(VrmsSq*TwtSq + OffSq))
    SinTheta = sqrt(SinSq)
    Theta = atan2(SinTheta,sqrt(1-SinSq))
    print $0,"   ",Theta*(180/pi)
  }
 
}
