BEGIN{
	#********************************************************************
	#********************************************************************
	#*****                                                          *****
	#***** This program will output all traces within user          *****
	#***** specified lines and traces (in-line and cross-lines).    *****
	#***** This means if a trace has either line or trace number    *****
	#***** within user specified guide-lines it will be output it   *****
	#***** does not have to have both criteria matching which is    *****
	#***** the purpose of program :                                 *****
	#*****                                                          *****
        #*****       "SpecificTracesInlineXlineFilter.awk               *****
	#*****                                                          *****
	#***** The format is not altered, in any way, by the program.   *****
	#*****                                                          *****
	#***** The user must specify the following:                     *****
	#***** max min and increment of the lines and traces desired    *****
	#***** to be output.                                            *****
	#*****                                                          *****
	#***** The input file must have Line numbers in the column as   *****
	#***** specified by variable "LineColumnNum" and Trace numbers  *****
	#***** in the column specified by variable "TraceColumnNum"     *****
	#*****                                                          *****
	#***** The rest of the columns are output but not used.         *****
	#*****                                                          *****
	#***** If you want only the specific traces that match both     *****
	#***** sets of criteria use: LineTraceFilter.awk                *****
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
# Line parameters to specify which lines to output.
#
  StartLine = 2898
  EndLine = 9999
  LineIncrement = 8

#
# Trace parameters to specify which traces to output.
#
  StartTrace = 3404
  EndTrace = 9999
  TraceIncrement = 8

#
# Parameters to indicate which columns, in the input file,
# the line and trace numbers actually reside.
#
  LineColumnNum  = 1
  TraceColumnNum = 2

#
# Number of initial lines to skip
#
  SkipLines = 0


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

# Determine if we have skipped the required number of input lines
# that will be output unchanged and unprocessed
  if ( NR <= SkipLines ) print $0
    if (NR > SkipLines ) {

# Referencing input line and trace numbers
# to start line and start trace numbers.
        AdjLineNum = $LineColumnNum - StartLine
	AdjTraceNum = $TraceColumnNum - StartTrace

# Calculations used to identify which lines and traces to keep.
# This is basically modulo math to find the correct lines and traces.
# In other words when the adjusted line and trace numbers are
# evenly divisible by the line and trace increments then it is a keeper.
# In even other words if the remainder after division is zero.
	LineIndInt = int( AdjLineNum / LineIncrement )
	LineInd = AdjLineNum / LineIncrement
	TraceIndInt = int( AdjTraceNum / TraceIncrement)
	TraceInd = AdjTraceNum / TraceIncrement

# First "if" statement detemines if line number 
# is within user specified range
	if ( $LineColumnNum >= StartLine && $LineColumnNum <= EndLine ){

#   Second "if" statement  determines if trace number
#   is within user specified range
	  if ( $TraceColumnNum >= StartTrace && $TraceColumnNum <= EndTrace ){

#     Third "if" statement determines if lines and traces
#     are part of user specified increments.
	    if ( LineIndInt == LineInd || TraceIndInt == TraceInd ){

#       If all the tests above comes up true print the line unchanged.
	      print $0

	    }
	  }
	}
    }
}
END{}
