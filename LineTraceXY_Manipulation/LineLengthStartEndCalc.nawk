BEGIN{
	Length = 0
	RunSum = 0.0
	SkipLines = 20
	OldLineName = "HelloDolly"
	FirstTime = "Zero"
	PreviousPoint = 0
	PrevoiusSP = 0
	RunSum = 0
	OnceOnly = 0
	OldX = 0
	OldY = 0
}
{
	if ( NR > SkipLines ) {

		NewX = $1
		NewY = $2

		if ( FirstTime == "Zero" ) {
			OldLineName = $7
			FirstPoint = PresentPoint
			FirstSP = PresentSP
			FirstX = OldX
			FirstY = OldY
			if (OnceOnly == 0) {
				FirstPoint = $3
				FirstSP = $4
				FirstX = $1
				FirstY = $2
				OldX = $1
				OldY = $2
			}
			OnceOnly = 1
			PreviousPoint = $3
			PrevousSP = $4
			FirstTime = "One"
			Length = 0
		}

		PresentPoint = $3
		PresentSP = $4

		if ( $7 != OldLineName && FirstTime != "Zero" ) {

			RunSum += Length
			print "------------------------------------------------------"
			print " "
			print "Line Name      :",OldLineName
			print "Length         :",Length
			print "First CDP      :",FirstPoint,"   Last CDP   :",PreviousPoint
			print "First SP       :",FirstSP,"   Last SP    :",PreviousSP   
			print "First (x,y)    : (",FirstX,",",FirstY,")"
			print "Last  (x,y)    : (",OldX,",",OldY,")"
			StraightLength = sqrt((OldX-FirstX)*(OldX-FirstX)+(OldY-FirstY)*(OldY-FirstY))
			print "Straight Length:",StraightLength
			print " "
			FirstTime = "Zero"
			Length = 0
		}

		Length += sqrt((NewX-OldX)*(NewX-OldX)+(NewY-OldY)*(NewY-OldY))

		PreviousPoint = PresentPoint
		PreviousSP = PresentSP

		OldX = NewX
		OldY = NewY
	}
}
END {
	print "------------------------------------------------------"
	print " "
	print "Line Name      :",OldLineName
	print "Length         :",Length
	print "First CDP      :",FirstPoint,"   Last CDP   :",PreviousPoint
	print "First SP       :",FirstSP,"   Last SP    :",PreviousSP   
	print "First (x,y)    : (",FirstX,",",FirstY,")"
	print "Last  (x,y)    : (",OldX,",",OldY,")"
	StraightLength = sqrt((OldX-FirstX)*(OldX-FirstX)+(OldY-FirstY)*(OldY-FirstY))
	print "Straight Length:",StraightLength
	print " "
	RunSum += Length

	print " "
	print "**********************************************************"
	print " "
	print "Total length for all lines is :",RunSum
	print " "
	print "**********************************************************"
	print " "
}

