openscad  -Dletter=\"A\" -o road-a-thin-face.stl thin-face.scad
openscad  -Dletter=\"R\" -o road-r-thin-face.stl thin-face.scad
openscad  -Dletter=\"G\" -o road-g-thin-face.stl thin-face.scad
openscad  -Dletter=\"H\" -o road-h-thin-face.stl thin-face.scad
openscad  -Dletter=\"O\" -o road-o-thin-face.stl thin-face.scad
openscad  -Dletter=\"U\" -o road-u-thin-face.stl thin-face.scad
openscad  -Dletter=\"L\" -o road-l-thin-face.stl thin-face.scad
openscad  -Dletter=\"D\" -o road-d-thin-face.stl thin-face.scad

openscad  -Dletter=\"A\" -o road-a-thin.stl thin.scad
openscad  -Dletter=\"R\" -o road-r-thin.stl thin.scad
openscad  -Dletter=\"G\" -o road-g-thin.stl thin.scad
openscad  -Dletter=\"H\" -o road-h-thin.stl thin.scad
openscad  -Dletter=\"O\" -o road-o-thin.stl thin.scad
openscad  -Dletter=\"U\" -o road-u-thin.stl thin.scad
openscad  -Dletter=\"L\" -o road-l-thin.stl thin.scad
openscad  -Dletter=\"D\" -o road-d-thin.stl thin.scad

slic3r --load thin-face.ini -o road-a-thin-face.gcode road-a-thin-face.stl
slic3r --load thin-face.ini -o road-r-thin-face.gcode road-r-thin-face.stl
slic3r --load thin-face.ini -o road-g-thin-face.gcode road-g-thin-face.stl
slic3r --load thin-face.ini -o road-h-thin-face.gcode road-h-thin-face.stl
slic3r --load thin-face.ini -o road-o-thin-face.gcode road-o-thin-face.stl
slic3r --load thin-face.ini -o road-u-thin-face.gcode road-u-thin-face.stl
slic3r --load thin-face.ini -o road-l-thin-face.gcode road-l-thin-face.stl
slic3r --load thin-face.ini -o road-d-thin-face.gcode road-d-thin-face.stl

slic3r --load thin.ini -o road-a-thin.gcode road-a-thin.stl
slic3r --load thin.ini -o road-r-thin.gcode road-r-thin.stl
slic3r --load thin.ini -o road-g-thin.gcode road-g-thin.stl
slic3r --load thin.ini -o road-h-thin.gcode road-h-thin.stl
slic3r --load thin.ini -o road-o-thin.gcode road-o-thin.stl
slic3r --load thin.ini -o road-u-thin.gcode road-u-thin.stl
slic3r --load thin.ini -o road-l-thin.gcode road-l-thin.stl
slic3r --load thin.ini -o road-d-thin.gcode road-d-thin.stl

