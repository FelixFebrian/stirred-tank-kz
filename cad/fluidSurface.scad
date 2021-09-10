/*
    Stirred-Tank Simulation
    Copyright (c) 2021 FelixFebrian

    File fluidSurface.scad
*/

// User Settings
$fa = 1;

tankDiameter = 400;
fluidHeight = 320;


module fluid_surface() {
    translate([0, 0, fluidHeight])
        cylinder(d=tankDiameter, h=1);  // output has to be 3D object!
}

fluid_surface();
