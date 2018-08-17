BEGIN{
	#********************************************************************
	#********************************************************************
	#*****                                                          *****
        #***** This program will output all line and traces that        *****
	#***** matchs  user input criteria. The criteria are:           *****
	#*****                                                          *****
	#*****              Starting Line Number    (StartLine)         *****
	#*****              Ending Line Number      (EndLine)           *****
	#*****                                                          *****
	#*****              Starting Trace Number   (StartTrace)        *****
	#*****              Ending Trace Number     (EndTrace)          *****
	#*****                                                          *****
	#*****              Line Increment Number    (Line_Inc)         *****
	#*****              Trace Increment Number   (Trace_Inc)        *****
	#*****                                                          *****
	#***** Therefore, only lines and traces conforming to the       *****
	#***** the following conditions will be retained:               *****
	#*****                                                          *****
	#*****              Trace = StartTrace + (n * Trace_Inc)        *****
	#*****              Line  = StartLine  + (m * Line_Inc ),       *****
	#*****                                                          *****
	#***** where m and n are arbitrary integers that                *****
 	#***** is within user specified bounds.                         *****
 	#*****                                                          *****
 	#***** The horizon files should be of a form similiar to ones   *****
 	#***** exported by utility "Hie" with format                    *****
 	#*****                                                          *****
 	#*****              Default:SingleFormat.                       *****
 	#*****                                                          *****
 	#*****  These files contain 6 columns with:                     *****
 	#*****                                                          *****
 	#*****              Line Number                                 *****
 	#*****              Trace Number                                *****
 	#*****              Easting (X coordinate)                      *****
 	#*****              Northing (Y coordinate)                     *****
 	#*****              Depth (Z coordinate)                        *****
 	#*****              and an F (for some seisworks magic).        *****
 	#*****                                                          *****
 	#*****  Of course any file with two columns containing          *****
 	#*****  line and trace numbers will do. These column numbers    *****
 	#*****  are specified by the variables "LineColumnNum"          *****
 	#*****  and "TraceColumnNum".                                   *****
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
  StartLine = 10200
  EndLine = 13800
  LineIncrement = 100

#
# Trace parameters to specify which traces to output.
#
  StartTrace = 960
  EndTrace = 1984
  TraceIncrement = 32

#
# Parameters to indicate which columns, in the input file,
# the line and trace numbers actually reside.
#
  LineColumnNum  = 1
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
      if ( LineIndInt == LineInd && TraceIndInt == TraceInd ){

#       If all the tests above comes up true print the line unchanged.
        print $0

      }
    }
  }
}
END{}




