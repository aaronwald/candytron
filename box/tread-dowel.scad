height = 5;
radius = 4.90;
difference () {
     union () {
	  cylinder (h=height, r=15, center=true);
	  rotate(0) cube([12*2,12*2,height], center=true);
	  rotate(30) cube([12*2,12*2,height], center=true);
	  rotate(60) cube([12*2,12*2,height], center=true);
     }
	  cylinder (h=height+1, r=radius, center=true);
}

//translate([-2.5,4.25,0]) rotate(45) cube([7,2,height], center=true);
