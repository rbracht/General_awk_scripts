BEGIN{
	#********************************************************************
	#********************************************************************
	#*****                                                          *****
        #***** This program expects the first records of the input      *****
	#***** file to be a single column of data that contains the     *****
	#***** the line and traces one wishes to keep from an exported  *****
	#***** horizon using utility "Hie" with format:                 *****
 	#*****                                                          *****
 	#*****              Default:SingleFormat.                       *****
 	#*****                                                          *****
 	#***** An example of such an input file will look like this:    *****
 	#*****                                                          *****
 	#***** Lines                                                    *****
        #***** 12832                                                    *****
        #***** 12576                                                    *****
        #***** 12352                                                    *****
        #***** Traces                                                   *****
        #***** 14270                                                    *****
        #***** 13984                                                    *****
        #***** 13696                                                    *****
        #***** 13504                                                    *****
        #***** 10616.00  13248.00   477825.00   971775.00   2106.0000 F *****
        #***** 10616.00  12640.00   493025.00   971775.00   1780.0048 F *****
        #***** 10616.00  12160.00   505025.00   971775.00   2315.7488   *****
        #***** 10617.00  13248.00   477825.00   971800.00   2104.0000 F *****
        #***** 10617.00  12640.00   493025.00   971800.00   1783.1622 F *****
        #***** 10617.00  12160.00   505025.00   971800.00   2315.5542 F *****
        #***** 10618.00  13248.00   477825.00   971825.00   2104.0000   *****
        #***** 10618.00  12640.00   493025.00   971825.00   1795.6116   *****
 	#*****                                                          *****
 	#***** Note the words "Lines" and "Traces" separate the line    *****
 	#***** and trace numbers and must be included. This is placed   *****
 	#***** in the file after the horizon is output from "Hie" and   *****
 	#***** can be done with an editor or appended some other way.   *****
 	#*****                                                          *****
 	#***** The portion that comes from Hie will have 6 columns      *****
 	#***** with:                                                    *****
 	#*****                                                          *****
 	#*****              Line Number                                 *****
 	#*****              Trace Number                                *****
 	#*****              Easting (X coordinate)                      *****
 	#*****              Northing (Y coordinate)                     *****
 	#*****              Depth (Z coordinate)                        *****
 	#*****              and an F (for some seisworks magic).        *****
 	#*****                                                          *****
 	#*****  Of course any file with two columns containing          *****
 	#*****  line and trace numbers will do. The only requirment is  *****
 	#*****  the file must have the line and trace numbers as the    *****
 	#*****  first two columns proceeded with the ones you want      *****
 	#*****  in a single column as described.                        *****
 	#*****                                                          *****
	#********************************************************************
	#********************************************************************


	##################################################
	##################################################
	##################################################
	####                                          ####
	####  Should be able to leave the rest alone  ####
	####                                          ####
	##################################################
	##################################################
	##################################################


  iline = 0
  xline = 0
  switch = 0
  good = 0
}
{
  if ( NF == 1 && $1 != "Lines" && $1 != "Traces" && NR > 1 && switch == 0 ) {
    ++iline
    Lines[iline] = $1
  }
  if (NF == 1 && $1 == "Traces") switch = 1
  if ( NF == 1 && $1 != "Traces" && NR > 1 && switch == 1 ) {
    ++xline
    Traces[xline] = $1
  }
  if (NF >= 5){
    for (i = 1; i <= iline; i++){
      for (j = 1; j <= xline; j++){
              if ( int($1) == Lines[i] || int($2) == Traces[j] ) good = 1
      }
    }
  }
  if ( good == 1 ) {
    print $0
    good = 0
  }
}
END{}

    
