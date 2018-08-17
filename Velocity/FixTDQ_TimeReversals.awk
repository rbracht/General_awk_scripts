BEGIN{
  Start = 0
  NewVelNum = 0
  MinVel = 4920
  MaxVel = 20000
}
{
  if ( substr($1,1,1) == "#" ) {
    print $0
  }
  if (Start == 0 && substr($1,1,1) != "#" ) {
    VelNum = $1
    CdpX = $2
    CdpY = $3
    Time = $4
    Velo = $5
    if ( Velo < MinVel) {
      Velo = MinVel
    }
    if ( Velo > MaxVel ) {
      Velo = MaxVel
    }
    Time0 = $4
    printf ("%5d%10.1f%11.1f", VelNum, CdpX, CdpY)
    printf ("%12.2f%10.2f\n", Time, Velo)
    Start = 1
    NewVelNum = 1
  }
  if ( Start == 1 && $4 > Time0 && VelNum == $1 ) {
    VelNum = $1
    CdpX = $2
    CdpY = $3
    Time = $4
    Velo = $5
    if ( Velo < MinVel) {
      Velo = MinVel
    }
    if ( Velo > MaxVel ) {
      Velo = MaxVel
    }
    printf ("%5d%10.1f%11.1f", VelNum, CdpX, CdpY)
    printf ("%12.2f%10.2f\n", Time, Velo)
    Time0 = Time
  }
  if ( Start == 1 && VelNum != $1 ) {
    VelNum = $1
    CdpX = $2
    CdpY = $3
    Time = $4
    Velo = $5
    Time0 = Time
    if ( Velo < MinVel) {
      Velo = MinVel
    }
    if ( Velo > MaxVel ) {
      Velo = MaxVel
    }
    printf ("%5d%10.1f%11.1f", VelNum, CdpX, CdpY)
    printf ("%12.2f%10.2f\n", Time, Velo)
    VelNum = $1
  }
}
END{}
