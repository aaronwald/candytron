include <gears.scad>;
bevel_gear(modul=2, tooth_number=20, partial_cone_angle=45, tooth_width=10, bore=8.8, pressure_angle=20, helix_angle=0);
translate([-5,0,0]) rotate(45) cube([10,1,6], center=false);

//bevel_gear_pair(modul=1, gear_teeth=30, pinion_teeth=11, axis_angle=100, tooth_width=10, bore=8.6, pressure_angle = 20, helix_angle=20, together_built=true);

//translate([30,30,00]) bevel_herringbone_gear(modul=1, tooth_number=30, partial_cone_angle=45, tooth_width=10, bore=4, pressure_angle=20, helix_angle=30);

//translate([40,40,00]) bevel_gear(modul=2, tooth_number=20, partial_cone_angle=45, tooth_width=10, bore=8.8, pressure_angle=20, helix_angle=0);

