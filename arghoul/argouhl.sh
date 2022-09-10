
mkdir -p output

for letter in A R G H O U L D 
do
    echo $letter
    openscad  -Dletter=\"$letter\" -o output/road-$letter-thin-face.stl thin-face.scad
    slic3r --load thin-face.ini -o output/road-$letter-thin-face.gcode output/road-$letter-thin-face.stl

    openscad  -Dletter=\"$letter\" -o output/road-$letter-thin.stl thin.scad
    slic3r --load thin.ini -o output/road-$letter-thin.gcode output/road-$letter-thin.stl
done



