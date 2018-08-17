BEGIN{
	#********************************************************************
	#********************************************************************
	#*****                                                          *****
	#***** This program will extract only the lines determined by   *****
	#***** the variables "LineBegin" and "LineEnd" of a user        *****
	#***** input file. You can also decimate the input file         *****
	#***** using the variable "Every"                               *****
	#*****                                                          *****
	#***** example: LineBegin = 101                                 *****
	#*****          LineEnd = 322                                   *****
	#*****          Every = 3                                       *****
	#*****                                                          *****
	#*****    This will output every third line starting from       *****
	#*****    line 101 up to 322. In other words, the lines output  *****
	#*****    will be: 101, 104, 107, 110, ..., 317, 320            *****
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

# Variable to specify the first line to output
  LineBegin = 3

# Variable to specify the last line to output
  LineEnd = 16

# Variable to specify every ouput line increment
  Every = 1

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
  if ( NR >= LineBegin && NR <= LineEnd && (NR - LineBegin)%Every == 0 ){
    print $0
  }
}
END{}
