
for letter in A R G H O U L D 
do
    echo $letter
    openscad  -Dletter=\"$letter\" -o road-$letter-thin-face.stl thin-face.scad
    slic3r --load thin-face.ini -o road-$letter-thin-face.gcode road-$letter-thin-face.stl

    openscad  -Dletter=\"$letter\" -o road-$letter-thin.stl thin.scad
    slic3r --load thin.ini -o road-$letter-thin.gcode road-$letter-thin.stl
done



