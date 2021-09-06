/*
    Stirred-Tank Simulation
    Copyright (c) 2021 FelixFebrian

    File tank.scad
*/

// User Settings
$fa = 1;

tankDiameter = 400;
tankHeight = 600;

dishChoice = 1;  // 0 for kloepper dish, 1 for elliptical dish

// Settings for kloepper dish
knuckleDiameter = 40;
wieldThickness = 80 - 73.5898;  // resulting depth of 80 mm


module kloepper_dish() {
    startPoly = tankDiameter * sqrt(3/4) - knuckleDiameter/2 - wieldThickness;

    points = concat(
        [[tankDiameter/2, startPoly]],
        [for(a = [0: 0.5: 60]) [
            tankDiameter/2 + knuckleDiameter * (cos(a) - 1),
            sin(60) * tankDiameter + knuckleDiameter * (sin(a) - 0.5)
        ]],
        [
            [tankDiameter/2, 2*tankDiameter],
            [-tankDiameter/2, 2*tankDiameter],
        ],
        [for(a = [120: 0.5: 180]) [
            -tankDiameter/2 + knuckleDiameter * (cos(a) + 1),
            sin(60) * tankDiameter + knuckleDiameter * (sin(a) - 0.5)
        ]],
        [[-tankDiameter/2, startPoly]]
    );

    translate([0, 0, -startPoly]) rotate_extrude() intersection() {
        circle(r=tankDiameter);
        polygon(points=points);

        // Only use the surface in first quadrant (x and y positive)
        polygon(points=[
            [0, 0], [tankDiameter, 0],
            [tankDiameter, tankDiameter], [0, tankDiameter]
        ]);
    }
}


module elliptical_dish() {
    rotate_extrude() intersection() {
        scale([1, 0.4, 1]) circle(d=tankDiameter);
        polygon(points=[
            [0, 0], [tankDiameter, 0],
            [tankDiameter, tankDiameter], [0, tankDiameter]
        ]);
    }
}

module tank() {
    union() {
        cylinder(d=tankDiameter, h=tankHeight);

        if (dishChoice) {mirror([0, 0, 1]) elliptical_dish();}
        else {mirror([0, 0, 1]) kloepper_dish();}
    }
}

tank();
