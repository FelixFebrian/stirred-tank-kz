/*
    Stirred-Tank Simulation
    Copyright (c) 2021 FelixFebrian

    File pbt.scad
*/

// User settings
$fn = 500;

stirrerHeight = 25;
stirrerDiameter = 125;

baseCylDiameter = 30;

bladeThickness = 2;
bladeLength = stirrerDiameter/2;
bladeAngle = 45;  // deg

zTranslation = 320 - 400 + 125;

module single_blade() {
    zTranslation = -(sin(bladeAngle)*stirrerHeight/2) + (stirrerHeight/2);
    yTranslation = cos(bladeAngle) * stirrerHeight / 2;

    translate([0, yTranslation, zTranslation])
        rotate([bladeAngle, 0, 0])
        cube([bladeLength, bladeThickness, stirrerHeight]);
}


module pbt_stirrer() {
    // Base cylinder
    cylinder(d=baseCylDiameter, h=stirrerHeight);

    // Blades
    for (i=[0:60:301]) {
        rotate([0, 0, i]) single_blade();
    }

}

translate([0, 0, zTranslation]) pbt_stirrer();
