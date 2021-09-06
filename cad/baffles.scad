/*
    Stirred-Tank Simulation
    Copyright (c) 2021 FelixFebrian

    File baffles.scad
*/

// User Settings
tankDiameter = 400;
tankHeight = 600;

baffleWidth = 32;
baffleThickness = 6;
baffleDistance = 8;

module one_baffle() {
    xTranslation = tankDiameter/2 - baffleWidth - baffleDistance;
    yTranslation = -baffleThickness/2;
    translate([xTranslation, yTranslation, 0])
        cube(size=[baffleWidth, baffleThickness, tankHeight]);
}

module baffles() {
    for (i=[0:90:270]) {
        rotate([0, 0, i]) one_baffle();
    }
}

baffles();
