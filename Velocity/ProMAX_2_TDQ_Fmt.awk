BEGIN{
  count = 0
  time = 0.0
  vel = 0.0
  cdpx = 0.0
  cdpy = 0.0
  everydt = 1.0
  dt = 100.0
  SampPerLine = 5
  skipno = 9
  skipcount = 0
    printf ("# Time/Depth domain selected.\n")
    printf("# Recommend Time/Depth pairs (meters)\n")
    printf("# LINEAR_UNITS = METERS\n")
    printf("# FUNCTION_TYPE = Depth\n")
    printf("# DATUM = 0.0           ### Check This ###\n")
    printf("#---------------------------------------------\n")
}
{
  if ( $1 == "ILINE_NO=" && $3 == "XLINE_NO=" ){
    count ++
    cdpx = $6
    cdpy = $8
    skipcount = -1
  }
  skipcount ++
  if (skipcount > skipno){
      for ( i=3; i<= NF; i++ ){
	time = $2 + ((i-3) * dt)
        vel = $i
	  if ( int(time/everydt) == time/everydt ){
#	    if ( vel > 1400 && time > ($2 + ((i-4) *dt)) ){
	    printf ("%5d%10.1f%11.1f", count, cdpx, cdpy)
	    printf ("%12.2f%10.2f\n", time, vel)
#	    }
	  }
      }
  }
}
END{}
