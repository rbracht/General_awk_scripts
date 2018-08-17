BEGIN{
# This program will convert a user sepcified column from miroseconds/foot
# to meters/second and append the result to a new column at the end of the original
# columns. User specified initial rows are passed without alteration.
# Rows with user specifed nulls will result in a null in the new column.

# Enter number of initial lines to pass
  SkipLines = 41

# Specify which column is to be used for computation
  ColumnToComputeFrom = 3

# Enter what is considered a null value
  NullValue = "-999.2500"

}
{
  if ( NR <= SkipLines ) print $0
  if ( NR > SkipLines ) {
    x = $ColumnToComputeFrom
      if ( x == NullValue ) {
	y = NullValue
	print $0," ",y
      }
      else {
	y = 304800/x
	print $0," ",y
      }
  }
}
