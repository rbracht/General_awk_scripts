BEGIN{
  DeciLn = 4
  DeciTr = 4
}
{
  if ( ($1 / DeciLn) == int( $1 / DeciLn) ){
    if ( ($2 / DeciTr) == int( $2 / DeciTr) ){
      print $0
    }
  }
}
END{}
    
