
//Sign body maker V3 - bigclivedotcom
letter = "A"; //Sign character to make
style = "Noto Mono"; //See "Help" and "Font List"
size = 70; //Size of character (height)
depth = 12; //Depth of sign character
$fn=100; //Curve facets - higher is smoother
walls = 4; //Side wall thickness
base=2; //Base thickness (-1 for open back)
face = 1; //Face thickness
//Don't change variables below here
sized=size-(2*walls);
difference(){
linear_extrude(height=depth)
minkowski(){
text(letter,sized,style);
circle(walls);
}
//Lip for front face (half wall thickness)
translate([0,0,depth-face])
linear_extrude(height=2*face)
minkowski(){
text(letter,sized,style);
circle(walls/2);
}
//hollow core of letter
translate([0,0,base])
linear_extrude(height=depth+2)
text(letter,sized,style);
}
