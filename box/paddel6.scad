height = 50;
radius = 4.88;
fin_len = 100;

difference () {
     union() {
	  cylinder (h=height, r=radius+3, center=true);
	  rotate(0) cube([fin_len,3,height], center=true);
	  rotate(60) cube([fin_len,3,height], center=true);
	  rotate(120) cube([fin_len,3,height], center=true);
     }
     cylinder (h=height+1, r=radius, center=true);
}
     
/*
difference () {
     cylinder (h=height, r=radius+3, center=true);
     cylinder (h=height+1, r=radius, center=true);
     }

translate([(fin_len/2)+radius,(fin_len/2)-radius,0]) rotate(30) cube([fin_len,3,height], center=true);
translate([-(fin_len/2)-radius,(fin_len/2)-radius,0]) rotate(-30) cube([fin_len,3,height], center=true);

translate([0,-(fin_len/2)-radius,0]) rotate(90) cube([fin_len,3,height], center=true);
*/
