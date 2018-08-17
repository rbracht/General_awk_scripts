BEGIN{
Ave[ 1] =        2.4
Ave[ 2] =      747.0
Ave[ 3] =     1645.5
Ave[ 4] =     1847.3
Ave[ 5] =     2907.9
Ave[ 6] =     2304.0
Ave[ 7] =     3889.2
Ave[ 8] =     2629.2
Ave[ 9] =     3037.2
Ave[10] =     3262.2
Ave[11] =     3201.6
Ave[12] =     6000.0
Ave[13] =     4362.2
}
{
  NumFields = NF
  InLine = $1
  XLine = $2
  K0 = $3
  AveK0 = Ave[1] 
#    print InLine, XLine, K0, AveK0
  j = 0
  for ( i = 4; i <= NumFields; i=i+2 ) {
    j++
    if ( $i > 0.0 ) Depth[j] = $i
    if ( $(i+1) > 0.0 ) Velocity[j] = $(i+1)
    AveVel[j] = Ave[i-1]
#      print j, Depth[j], Velocity[j], AveVel[j]
  }
  DelDepth[1] = Depth[1]
  for ( i = 2; i <= j; i++ ) {
    DelDepth[i] = Depth[i] - Depth[i-1]
    if ( DelDepth[i] < 0.0 ){
      DelDepth[i] = 0.0
      Depth[i] = Depth[i-1]
    }
#    print i, DelDepth[i], DelDepth[i-1], Depth[i], Depth[i-1]
  }
  if ( K0 == 0.0 ) {
    NewDelDepth[1] = DelDepth[1] * AveVel[1] / Velocity[1]
    TotDepth[1] = NewDelDepth[1]
  }
  if ( K0 != 0.0) {
    Term1 = K0 * Depth[1] / Velocity[1]
    ExpTerm = exp( (AveK0/K0) * log(1.0 -  Term1) )
    NewDelDepth[1] = (AveVel[1]/AveK0) * ( 1.0 - ExpTerm )
    TotDepth[1] = NewDelDepth[1]
#    print K0, AveK0, Depth[1], Velocity[1], AveVel[1], Term1, ExpTerm, NewDelDepth[1], TotDepth[1]
  }
  for ( i = 2; i <= j; i++ ) {
    NewDelDepth[i] = DelDepth[i] * AveVel[i] / Velocity[i]
    TotDepth[i] = TotDepth[i-1] + NewDelDepth[i]
  }
  printf (" %5d %5d " ,InLine ,XLine)
  for ( i = 1; i <= j; i++ ) {
#    printf ("  %6.1f %6.1f" ,Depth[i] ,TotDepth[i])
    printf (" %6.1f" ,TotDepth[i]-Depth[i])
  }
  printf ("\n")

}
END{}

  
