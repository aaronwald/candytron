height = 10;
radius = 4.88;
difference () {
     cylinder (h=height, r=radius+1.5, center=true);
     cylinder (h=height+1, r=radius, center=true);
     }

//translate([-2.5,4.25,0]) rotate(45) cube([7,2,height], center=true);
