height = 20;
difference () {
     cylinder (h=height, r=7, center=true);
     cylinder (h=height+1, r=4.4, center=true);
     }

translate([-2.5,4.25,0]) rotate(45) cube([7,2,height], center=true);
