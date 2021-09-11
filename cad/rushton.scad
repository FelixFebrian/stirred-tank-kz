/*
    Stirred-Tank Simulation
    Copyright (c) 2021 FelixFebrian

    File rushton.scad
*/

// User settings
$fn = 500;

stirrerHeight = 25;
stirrerDiameter = 125;

baseCylDiameter = 30;

diskDiameter = 94;
diskThickness = 3;

bladeThickness = 2;
bladeLength = 31;

zTranslation = 320 - 400 + 125;

module single_blade() {
    translate([stirrerDiameter/2 - bladeLength, -bladeThickness/2, 0])
        cube([bladeLength, bladeThickness, stirrerHeight]);
}


module rushton_stirrer() {
    // Base cylinder
    cylinder(d=baseCylDiameter, h=stirrerHeight);

    // Disk
    translate([0, 0, -diskThickness/2 + stirrerHeight/2])
    cylinder(d=diskDiameter, h=diskThickness);

    // Blades
    for (i=[0:60:301]) {
        rotate([0, 0, i]) single_blade();
    }

}

translate([0, 0, zTranslation]) rushton_stirrer();
