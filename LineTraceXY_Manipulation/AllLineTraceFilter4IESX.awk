BEGIN{
	#********************************************************************
	#********************************************************************
	#*****                                                          *****
	#***** This program will will take an input file with line and  *****
	#***** trace numbers in specifialbe colums and allow all rows   *****
	#***** that conform to user specified parameters to pass. In    *****
	#***** other words if either the line or trace number in a row  *****
	#***** matches user specifications will be passes and all       *****
	#***** others will be rejected.                                 *****
	#*****                                                          *****
	#********************************************************************
	#********************************************************************




	##################################################
	##################################################
	##################################################
	####                                          ####
	####  You may want to change the following    ####
	####  parameters for a particular run.        ####
	####                                          ####
	##################################################
	##################################################
	##################################################


# Specify the column numbers where the trace and line numbers
# reside in the input file

LineColNum = 10
TraceColNum = 7

# Sepcify a reference line number and the increment for ouput
# (rows in input file that satisfy: 
#            LineNumber = RefLineNum + n * LineIncrement
# ,where "n" is an integer, will be passed.)

RefLineNum = 2000
LineIncrement = 8

# Sepcify a reference trace number and the increment for ouput
# (rows in input file that satisfy: 
#            TraceNumber = RefTraceNum + n * TraceIncrement
# ,where "n" is an integer, will be passed.)

RefTraceNum = 100
TraceIncrement = 8

#Number of initial lines to pass unaltered

NumSkipLine = 2


	##################################################
	##################################################
	##################################################
	####                                          ####
	####  Should be able to leave the rest alone  ####
	####                                          ####
	##################################################
	##################################################
	##################################################

count = 0
}
{

  count = count + 1

  if (count <= NumSkipLine ) {
    print $0
  }

  if ( count > NumSkipLine && $1 != "EOD" ) {

    LineInt = int(($LineColNum - RefLineNum)/LineIncrement)
    LineFrac =(($LineColNum - RefLineNum)/LineIncrement) - LineInt
    TraceInt = int(($TraceColNum - RefTraceNum)/TraceIncrement)
    TraceFrac = (($TraceColNum - RefTraceNum)/TraceIncrement) - TraceInt
    
    if (LineFrac == 0 || TraceFrac == 0 ) {
      print $0
    }
  }

  if ( $1 == "EOD" ) {
    print "EOD"
    exit
  }
}
END{}

