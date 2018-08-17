BEGIN{
	NumDepths = 12
	Depth[1] = -6434
	Depth[2] = -10500
	Depth[3] = -12020
	Depth[4] = -13058
	Depth[5] = -17140
	Depth[6] = -17500
	Depth[7] = -18020
	Depth[8] = -18160
	Depth[9] = -18460
	Depth[10] = -18660
	Depth[11] = -18810
	Depth[12] = -19015
	FileDepthCol = 7
	FileXcol = 1
	FileYcol = 2
	FileAziCol = 9
	FileInclCol = 8
	SkipLines = 24
	StartDepth = 1
	RepCount = 1
	DoneLoop = 1
	printf ("   TVDSS    X-coord   Y-coord  Inclination   Azimuth\n")
}
{
	if ( NR > SkipLines ) {
		ReadDepth[RepCount] = $FileDepthCol
		ReadX[RepCount] = $FileXcol
		ReadY[RepCount] = $FileYcol
		ReadAzi[RepCount] = $FileAziCol
		ReadIncl[RepCount] = $FileInclCol
		if ( RepCount = 2 ) {
			RepCount = 1
			DoneLoop = 1
			for (i=StartDepth; i<=NumDepths; i++) {
				if ( Depth[i] < ReadDepth[1] && Depth[i] >= ReadDepth[2] ){
					alpha = (Depth[i]-ReadDepth[1]) / (ReadDepth[2]-ReadDepth[1])
					DelX = ReadX[2]-ReadX[1]
					DelY = ReadY[2]-ReadY[1]
					DelAzi = ReadAzi[2]-ReadAzi[1]
					DelIncl = ReadIncl[2]- ReadIncl[1]
					NewX = ReadX[1] + alpha*DelX
					NewY = ReadY[1] + alpha*DelY
					NewAzi = ReadAzi[1] + alpha*DelAzi
					NewIncl = ReadIncl[1] + alpha*DelIncl
					printf("%8d %10d %10d %10.4f %10.4f\n", Depth[i],NewX,NewY,NewIncl,NewAzi)
					StartDepth++
				}
			}
		}
		if ( DoneLoop == 1 && RepCount == 1) {
			RepCount = 2
			DoneLoop = 2
		}
	}
}
END{}

			
