BEGIN{
	#********************************************************************
	#********************************************************************
	#*****                                                          *****
	#***** This program will output only lines and traces           *****
	#***** within the criteria set up by the user below. The user   *****
	#***** specicies the max min and increment of the lines and     *****
	#***** traces desired to be output. The input file must have    *****
	#***** line numbers specified by the "LineColumnNum" variable   *****
        #***** and trace number specified by the "TraceColumnNum"       *****
        #***** variables. The rest will be output but not used          *****
	#***** in any way by the program.                               *****
	#*****                                                          *****
	#***** Only traces which exactly matches the criteria will      *****
	#***** ouput If you want all traces that matches one or the     *****
	#***** other criteria use AllTracesInlineXlineFilter.awk        *****
	#*****                                                          *****
	#********************************************************************
	#********************************************************************

	#####################################
	#                                   #
	#  You might want to change the     #
	#  following parameters for a       #
	#  particular run.                  #
	#                                   #
	#####################################
#
# Selection parameters in the inline direction.    
#
  StartLine = 10624
  EndLine = 13056
  LineIncrement = 32
#
# Selection parameters in trace direction.
#
  StartTrace = 10240
  EndTrace = 14400
  TraceIncrement = 32
#
# Columns in which to look for
# the line and trace numbers in the input file.
#
  LineColumnNum = 1
  TraceColumnNum = 2

	##################################################
	##################################################
	##################################################
	####                                          ####
	####  Should be able to leave the rest alone  ####
	####                                          ####
	##################################################
	##################################################
	##################################################

}
{

# Referencing input line and trace numbers
# to start line and start trace numbers.
  AdjLineNum = $LineColumnNum - StartLine
  AdjTraceNum = $TraceColumnNum - StartTrace

# Calculations used to identify which lines and traces to keep.
# This basically simulates modulo math.  
  LineIndInt = int(AdjLineNum  / LineIncrement )
  LineInd = AdjLineNum / LineIncrement
  TraceIndInt = int( AdjTraceNum / TraceIncrement)
  TraceInd = AdjTraceNum / TraceIncrement

# First if detemines if line number is within user specified range
  if ( $LineColumnNum >= StartLine && $LineColumnNum <= EndLine){

#   Second if determines if trace number is within user specified range
    if ( $TraceColumnNum >= StartTrace && $TraceColumnNum <= EndTrace){

#     Third if determines if lines and traces are part of user specified
#     increments.
      if ( LineIndInt == LineInd && TraceIndInt == TraceInd ){

       print $0

      }
    }
  }
}
END{}
