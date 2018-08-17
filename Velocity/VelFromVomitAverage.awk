BEGIN {
  MaxFields = 30
  for ( i = 1; i <= MaxFields; i++ ){
    NumSum[i] = 0
  }
}
{
  for ( i = 3; i <= NF; i++ ) {
    if ( $i != 0.0 ) {
      Sum[i-2] += $i
      NumSum[i-2]++
    }
  }
  NumFields = NF - 2
}
END{
  for ( i = 1; i <= NumFields; i++ ) {
    Sum[i] = Sum[i] / NumSum[i]
    printf ("Ave[%2d] = %10.1f\n" ,i ,Sum[i])
  }
  printf ("\n")
}
