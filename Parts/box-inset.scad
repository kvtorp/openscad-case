include <../dimensions.scad>

use <../Case/case.scad>

difference() {
    BoxInsert(length, width, height, cornerRadius, thickness);
    
    // Add your own cutouts below

    // Example: Cutout for DJI Osmo Action 4
    * union() {
        // Battery charger
        translate([(length - 117)/2, width - 10 - 59, height - 24])
        cube([117, 59, 24 + 10]);

        // Camera body
        translate([(length - 117)/2, 10, height - 31]) 
        cube([80, 52, 31 + 10]);

        // Space for the button
        translate([(length - 117)/2, 10, height - 31]) 
        cube([33, 56, 31 + 10]);

        // Lens
        translate([(length - 117)/2 + 19, 10 + 34, height - 31 - 8]) 
        cylinder(20, r = 19);

        // Cable, flash storage
        translate([ length - (length - 117)/2 - 30, 10, height - 31]) 
        cube([30, 52, 31 + 10]);
        
        // Pick-up holes
        translate([length / 2.7, -10, height])
        rotate([-90, 0, 0])
        cylinder(2*width, r = 10);
    }
}
