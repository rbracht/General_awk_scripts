BEGIN{
  SpStart = 10.0
  SpEnd = 3031.0
  SpInc = 5.0
}
{
  if (NR == 1){
    Line = $1
    Sp1 = $2
    x1 = $3
    y1 = $4
  }
  Sp2 = $2
  x2 = $3
  y2 = $4
}
END{
  DspRef = Sp1 - Sp2
  DxRef = x1 - x2
  DyRef = y1 - y2
  Sp = SpStart
  Dsp = Sp1 - Sp
  while ( (Sp-SpStart)*(Sp-SpEnd) <= 0.0 ){
    SpX = x1 - (DxRef * (Dsp / DspRef))
    SpY = y1 - (DyRef * (Dsp / DspRef))
    printf ("%20s %10.0f %15.2f %15.2f\n", Line, Sp, SpX, SpY)
    Sp = Sp + SpInc
    Dsp = Sp1 - Sp
  }
}


