BEGIN{
	#********************************************************************
	#********************************************************************
	#*****                                                          *****
	#***** This program will produce and average velocity from      *****
	#***** interval velocity and depth data. At present the         *****
	#***** program expects the standard 15 column MBS data and will *****
	#***** average the velocities in columns 11 and 13 with depths  *****
	#***** from columns 8, 10 and 12.                               *****
	#*****                                                          *****
	#********************************************************************
	#********************************************************************

  SkipLines = 2

	##################################################
	##################################################
	##################################################
	####                                          ####
	####  Should be able to leave the rest alone  ####
	####                                          ####
	##################################################
	##################################################
	##################################################

printf("      Trace      Line   AveVel_T50Down\n")

}
{
  if (NR > SkipLines){

    Trace = $1
    Line = $2

    IntVelT50_30 = $11
    IntVelT30_00 = $13
    DepthT50 = $8
    DepthT30 = $10
    DepthT00 = $12

    IntDepthT50_30 = DepthT30 - DepthT50
    IntDepthT30_00 = DepthT00 - DepthT30

    IntTimeT50_30 = IntDepthT50_30 / IntVelT50_30
    IntTimeT30_00 = IntDepthT30_00 / IntVelT30_00

    TotalDepth = IntDepthT50_30 + IntDepthT30_00
    TotalTime  = IntTimeT50_30  + IntTimeT30_00

    AveVel = TotalDepth / TotalTime

    printf ("%10d %10d %10.1f\n", Trace, Line, AveVel)
  }
}
END{}
