include <gears.scad>;
bevel_gear(modul=1, tooth_number=30, partial_cone_angle=45, tooth_width=5, bore=8.8, pressure_angle=20, helix_angle=20);

height = 20;
translate([-5,0,0]) rotate(45) cube([10,1,3], center=false);
