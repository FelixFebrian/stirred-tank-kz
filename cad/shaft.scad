/*
    Stirred-Tank Simulation
    Copyright (c) 2021 FelixFebrian

    File shaft.scad
*/

// User Settings
$fn = 500;

shaftDiameter = 20;
shaftHeight = 400;

zTranslation = 320 - 400 + 125;

module shaft() {
    translate([0, 0, zTranslation])
        cylinder(d=shaftDiameter, h=shaftHeight);
}

shaft();
