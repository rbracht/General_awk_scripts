BEGIN{
  TotalLen = 0.0
  LineLen = 0.0
  NumLine = 0
  LineName = "NoLine"
  Xold = 0.0
  Y0ld = 0.0
  printf("Line Name      Length (km)       RunningTotal (km)\n")
}
{

  if ( LineName != $1 ) {
    if ( LineName != "NoLine" ) printf ("%-10s   %10.0f         %10.0f\n", LineName, LineLen/1000.0, TotalLen/1000.0)
    LineName = $1
    Xold = $3*1.0
    Yold = $4*1.0
    TotalLen += LineLen
    LineLen = 0.0
  }

  Xnew = $3*1.0
  Ynew = $4*1.0
  if (LineName == $1 ){
    LineLen += sqrt( (Xold - Xnew)*(Xold - Xnew) +  (Yold - Ynew)*(Yold - Ynew) )
    Xold = Xnew
    Yold = Ynew
  }
}
END{
  print " "
  print " "
  print "************************************************"
  print "************************************************"
  print "**"
  printf ("** Grand Total Length (km): %12.0f\n",TotalLen/1000.0)
  print "**"
  print "************************************************"
  print "************************************************"
}



