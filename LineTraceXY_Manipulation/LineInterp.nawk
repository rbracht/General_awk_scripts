BEGIN{
	LineName = "DonLine1"
	x1 = 794115.88
	y1 = 690673.13
	x2 = 812458.75
	y2 = 704673.25
	N = 200
	

	DeltaX = x2 - x1
	DeltaY = y2 - y1

	dx = DeltaX / (N-1)
	dy = DeltaY / (N-1)

	for ( i = 0; i <= N-1; i++ ){
		newx = x1 + i*dx
		newy = y1 + i*dy
		printf ("%10s %5d %10.2f %10.2f\n", LineName, i+1, newx,newy)
	} 
}
END{}