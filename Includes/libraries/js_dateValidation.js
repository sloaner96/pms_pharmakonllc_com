/*
-----------------------------------------
|     Logic By Mattias Sjöberg 28/11-96 |
-----------------------------------------
*/

function isThisWrong(a)
{
	var err=0;
	var psj=0;

	if (a.length != 8) err=1
	b = a.substring(0, 2)// month
	c = a.substring(2, 3)// '/'
	d = a.substring(3, 5)// day
	e = a.substring(5, 6)// '/'
	f = a.substring(6, 8)// year

	//basic error checking
	if (b<1 || b>12) err = 1
	if (c != '/') err = 1
	if (d<1 || d>31) err = 1
	if (e != '/') err = 1
	if (f<0 || f>99) err = 1

	//advanced error checking

	// months with 30 days
	if (b==4 || b==6 || b==9 || b==11){
		if (d==31) err=1
	}

	// february, leap year
	if (b==2){
		// feb
		var g=parseInt(f/4)
		if (isNaN(g)) {
			err=1
		}

		if (d>29) err=1
		if (d==29 && ((f/4)!=parseInt(f/4))) err=1
	}

	if (err==1){
		return err;
	}
	else{
		return err;
	}
}