BEGIN{
	SkipLines = 4
	LineName = "ME-90B-03"
}
{
	if ( NR > SkipLines && $1 != "END" )
	Flag = 1
	{
		if ( substr( $1, 1, 2 ) == "ME" )
		{
			LineNum = $1
			ShotNum = $2
			ShotX = $3
			ShotY = $4
			Flag = 2
		}
		if ( LineNum == LineName && Flag == 1 )
		{
			for ( i = 1; i < NF; i = i+2 )
			{
				j = i+1
				printf ("  %10s  %5d %10d  %10d  %10d  %10d\n", LineNum, ShotNum, ShotX, ShotY, $i + 0, $j + 0)
			}
		}
	}
}
END{}
 