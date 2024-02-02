
include <../dimensions.scad>

Box(length, width, height, 10, thickness, withInset);
%AnslagSupport(length, height, 10);

#BoxInsert(length, width, height, 10, thickness);
InsertPatches(length, width, 10, thickness);

translate([0, width + 45, 0])
Lid(length, width, 10, thickness, textOnLid, 20, withInset);
translate([0, width + 45, 0])
color("blue")
LidText(length, width, textOnLid, 20);

#translate([0, width + 45, 0])
LidInsert(length, width, 10, thickness);

translate([0, width + 45, 0])
InsertPatches(length, width, 10, thickness);


translate([0, width + 45, 0])
Buckles(length, 10);



module BoxInsert(length, width, height, cornerRadius, thickness) {
    color("red")
    difference() {
        intersection() {
            InsideCutout(length, width, height, cornerRadius, thickness);
            cube([length, width, height]);
        }

        for ( x = [2*cornerRadius, length - 2*cornerRadius - 16], y = [2*cornerRadius, width - 2*cornerRadius - 5] )
            translate([x, y])
            InsertBridge(thickness);
        
        translate([length/2 - 8, width/2 - 2.5])
        InsertBridge(thickness);
        
        translate([(length - 117)/2, width - 10 - 59, height - 24])
        cube([117, 59, 24 + 10]);
        
        translate([(length - 117)/2, 10, height - 31]) 
        cube([80, 52, 31 + 10]);

        translate([(length - 117)/2, 10, height - 31]) 
        cube([33, 56, 31 + 10]);

        translate([(length - 117)/2 + 19, 10 + 34, height - 31 - 8]) 
        cylinder(20, r = 19);

        translate([ length - (length - 117)/2 - 30, 10, height - 31]) 
        cube([30, 52, 31 + 10]);
        
        
        translate([length / 2.7, -10, height])
        rotate([-90, 0, 0])
        cylinder(2*width, r = 10);

        for ( x = [2*cornerRadius, length - 2*cornerRadius - 16], y = [2*cornerRadius, width - 2*cornerRadius - 5] )
        translate([x, y])
        InsertBridgeCutout(thickness);
        
        translate([length/2 - 8, width/2 - 2.5])
        InsertBridgeCutout(thickness);
    }

}

module InsertPatches(length, width, cornerRadius, thickness) {
    for ( x = [2*cornerRadius, length - 2*cornerRadius - 16], y = [2*cornerRadius, width - 2*cornerRadius - 5] )
        translate([x, y])
        InsertPatch(thickness);
        
    translate([length/2 - 8, width/2 - 2.5])
    InsertPatch(thickness);
}

module InsertBridgeCutout(thickness) {
    translate([0, 0, thickness - 1])
    cube([16, 5, 3]);
    translate([-10, -10, thickness - 1])
    cube([36, 25, 2]);
}


module LidInsert(length, width, cornerRadius, thickness) {
    color("red")
    difference() {
        intersection() {
            InsideCutout(length, width, 10, cornerRadius, thickness);
            cube([length, width, 10]);
        }

        for ( x = [2*cornerRadius, length - 2*cornerRadius - 16], y = [2*cornerRadius, width - 2*cornerRadius - 5] )
        translate([x, y])
        InsertBridgeCutout(thickness);
        
        translate([length/2 - 8, width/2 - 2.5])
        InsertBridgeCutout(thickness);
    }
}

module AnslagSupport(length, height, cornerRadius) {
    difference() {
        if ( length < 140 ) {
            translate([(length - 35) / 2, 0, 0])
            AnslagsSupportCube(height);
        } else {
            translate([2 * cornerRadius, 0, 0])
            AnslagsSupportCube(height);
            translate([length - 2 * cornerRadius - 35, 0, 0])
            AnslagsSupportCube(height);
        }
        if ( length < 140 ) {
            translate([(length - 35) / 2, 0, height])
                translate([4.55, 0, 0])
                mirror([0, 1, 0])
                rotate([0, 90, 0]) {
                    linear_extrude(26, convexity = 10)
                    AnslagProfile();
                    translate([0, 0, 13.5])
                    linear_extrude(10.5, convexity = 10)
                    AnslagProfile();
                }

        } else {
            translate([2 * cornerRadius, 0, height])
                translate([4.55, 0, 0])
                mirror([0, 1, 0])
                rotate([0, 90, 0]) {
                    linear_extrude(26, convexity = 10)
                    AnslagProfile();
                    translate([0, 0, 13.5])
                    linear_extrude(10.5, convexity = 10)
                    AnslagProfile();
                }
            translate([length - 2 * cornerRadius - 35, 0, height])
                translate([4.55, 0, 0])
                mirror([0, 1, 0])
                rotate([0, 90, 0]) {
                    linear_extrude(26, convexity = 10)
                    AnslagProfile();
                    translate([0, 0, 13.5])
                    linear_extrude(10.5, convexity = 10)
                    AnslagProfile();
                }
        }
    }
}

module AnslagsSupportCube(height) {
    hull() {
        translate([0, -10 - height/5, 0])
        cube([35, 10 + height/5, 2]);

        translate([3, -7.5, 0])
        cube([29, 5, height-20]);
    }
}

module Buckles(length, cornerRadius) {

    if ( length < 140 ) {
        translate([(length - 35) / 2, 0, 0])
        Buckle();
    } else {
        translate([2*cornerRadius, 0, 0])
        Buckle();
        translate([length - 2*cornerRadius - 35, 0, 0])
        Buckle();
    }
}

module BuckleAttachment() {

    translate([5.5, -5.1, 5]) 
    rotate([-90, 0, -90]) {
        translate([0, 0, -1.5])
        cylinder(27, r = 2);
        
        translate([0, 0, -5.5])
        linear_extrude(5, convexity = 10)
        BuckleAttachmentProfile();

        translate([0, 0, 10])
        linear_extrude(4, convexity = 10)
        BuckleAttachmentProfile();

        translate([0, 0, 24.5])
        linear_extrude(5, convexity = 10)
        BuckleAttachmentProfile();
    }   
}

module Anslag() {
    translate([5.5, 0, 0])
    mirror([0, 1, 0])
    rotate([0, 90, 0]) {
        linear_extrude(10.5, convexity = 10)
        AnslagProfile();
        translate([0, 0, 13.5])
        linear_extrude(10.5, convexity = 10)
        AnslagProfile();
    }
}

module Buckle() {
    translate([5.5, -5.1, 5]) 
    rotate([-90, 0, -90]) {
        difference() {
            union() {
                linear_extrude(11, convexity = 10)
                BuckleProfile();
                translate([0, 0, 11])
                linear_extrude(2, convexity = 10)
                BuckleGuideProfile();
                translate([0, 0, 13])
                linear_extrude(11, convexity = 10)
                BuckleProfile();
            }
            translate([0, 0, 12])
            cube([11, 11, 5], center = true);
        }
    }
}

module BuckleProfile() {
    offset( r = 1 )
    offset( r = -1 )
    difference() {
        union() {
            circle(5);
            translate([0, 1])
            square([35, 4]);
            translate([25, 0])
            square([10, 3]);
            hull() {
            translate([26, -3.9])
            circle(1);
            translate([26, -4.9])
            square([9, 4.9]);
            }
        }
        
        circle(2.4);

        translate([25, 0])
        circle(1);
        
        translate([22, -10])
        rotate([0, 0, -45])
        square(30);
    
    }
}

module BuckleGuideProfile() {
    offset( r = 1 )
    offset( r = -1 )
    difference() {
        union() {
            circle(5);
            translate([0, 1])
            square([35, 4]);
            translate([25, 0])
            square([10, 3]);
            hull() {
            translate([26, -3.9])
            circle(1);
            translate([26, -4.9])
            square([9, 4.9]);
            translate([20, 2])
            square(1);
            }
        }
        
        circle(2.4);

        translate([22, -10])
        rotate([0, 0, -45])
        square(30);
    
    }
}

module AnslagProfile() {
    hull() {
        translate([5, 0])
        square([12, 0.1]);
        translate([20, 5])
        circle(1);
    }

    translate([5, -5])
    square([12, 5.1]);
}

module BuckleAttachmentProfile() {

    circle(5);
    translate([-30, -5])
    square([30, 10]);
}

module Lid(length, width, cornerRadius, thickness, text, textSize, withInsetLice) {
    height = 10; 
    difference() {
        union() {
            Shell(length, width, height, cornerRadius, thickness);
            LidHinge(length, width, height, cornerRadius);

            if ( length < 140 ) {
                translate([(length - 35) / 2, 0, 0])
                BuckleAttachment();
            } else {
                translate([2*cornerRadius, 0, 0])
                BuckleAttachment();
                translate([length - 2*cornerRadius - 35, 0, 0])
                BuckleAttachment();
            }
        }
        
        InsideCutout(length, width, height, cornerRadius, thickness);
        LidText(length, width, text, textSize);
        translate([0, 0, -0.2])
        LidText(length, width, text, textSize);
    }

    if (withInsetLice) {
        InsetLice(length, width, height, cornerRadius, thickness);
    }
}

module InsertBridge(thickness) {
    translate([0, 0, thickness - 1])
    cube([3, 5, 3]);
    translate([13, 0, thickness - 1])
    cube([3, 5, 3]);
    translate([0, 0, thickness + 1])
    cube([16, 5, 1]);
}

module InsertPatch(thickness) {
    difference() {
        translate([-10, -10, thickness])
        cube([36, 25, 1]);

        translate([0, 0, thickness - 1])
        cube([3, 5, 3]);
        translate([13, 0, thickness - 1])
        cube([3, 5, 3]);
    }
}

module LidText(length, width, text, textSize) {
    translate([length / 2, width / 2, 0.6])
    rotate([0, 180, 0])
    linear_extrude(0.6, convexity = 10)
    text(text = text, size = textSize, font = "Arial:style=Bold", halign = "center", valign = "center");
}

module LidHinge(length, width, height, cornerRadius) {
    if ( length < 140 ) {
        translate([length/2 - 7.5, width, 0])
        HingeFlangeM3(15, height);
    } else {
        translate([2*cornerRadius+9.5, width])
        HingeFlangeM3(15, height);
        translate([length - 2*cornerRadius - 24.5, width])
        HingeFlangeM3(15, height);
    }
}

module BoxHinge(length, width, height, cornerRadius) {
    if ( length < 140 ) {
        translate([length/2 + 8 + 3, width])
        HingeFlangeM3Insert(6, height);
        translate([length/2 + 8, width])
        HingeFlangeM3(3, height);

        translate([length/2 - 8 - 5, width])
        HingeFlangeM3(5, height);
    } else {
        translate([2*cornerRadius, width])
        HingeFlangeM3Insert(6, height);
        translate([2*cornerRadius + 6, width])
        HingeFlangeM3(3, height);

        translate([2*cornerRadius + 9 + 16, width])
        HingeFlangeM3(5, height);

        translate([length - 2*cornerRadius -6, width])
        HingeFlangeM3Insert(6, height);
        translate([length - 2*cornerRadius - 9, width])
        HingeFlangeM3(3, height);

        translate([length - 2*cornerRadius - 30, width])
        HingeFlangeM3(5, height);
    }
}

module Box(length, width, height, cornerRadius, thickness, withInsetLice) {
    difference() {
        union() {
            Shell(length, width, height, cornerRadius, thickness);
            BoxHinge(length, width, height, cornerRadius);
            if ( length < 140 ) {
                translate([(length - 35) / 2, 0, height])
                Anslag();
            } else {
                translate([2 * cornerRadius, 0, height])
                Anslag();
                translate([length - 2 * cornerRadius - 35, 0, height])
                Anslag();
            }
        }
        
        InsideCutout(length, width, height, cornerRadius, thickness);
    }

    if (withInsetLice) {
        InsetLice(length, width, height, cornerRadius, thickness);
    }

}

module InsetLice(length, width, height, cornerRadius, thickness) {
    for ( x = [2*cornerRadius, length - 2*cornerRadius - 16], y = [2*cornerRadius, width - 2*cornerRadius - 5] )
        translate([x, y])
        InsertBridge(thickness);
    translate([length/2 - 8, width/2 - 2.5])
    InsertBridge(thickness);
}


module Shell(length, width, height, cornerRadius, thickness) {

    hull()
    for ( x = [cornerRadius, length - cornerRadius], y = [cornerRadius, width - cornerRadius])
        translate([x, y, 0])
        Pencil(height, cornerRadius);
}

module InsideCutout(length, width, height, cornerRadius, thickness) {

    hull()
    for ( x = [cornerRadius, length - cornerRadius], y = [cornerRadius, width - cornerRadius])
        translate([x, y, thickness])
        Pencil(height, cornerRadius - thickness);
}

module Pencil(height, cornerRadius) {
    rotate_extrude(angle = 360, convexity = 10) {
        offset(r = 2)
        offset(r = -2)
        polygon([
            [0, 0], [0, height], [cornerRadius, height],
            [cornerRadius, cornerRadius/2], [3*cornerRadius/4, 0]
        ]);
        polygon([
            [0, height - 4], [0, height], [cornerRadius, height],
            [cornerRadius, height - 4] ]);
        polygon([
            [0, 0], [0, cornerRadius/4], [7*cornerRadius/8 , cornerRadius/4],
            [3*cornerRadius/4, 0] ]);

    }
}

module HingeFlangeM3(width, height) {
    translate([0, 6, height])
    rotate([90, 0, 90])
    linear_extrude(width, convexity = 10)
    HingeFlangeM3Profile(height);
}

module HingeFlangeM3Insert(width, height) {
    translate([0, 6, height])
    rotate([90, 0, 90])
    linear_extrude(width, convexity = 10)
    HingeFlangeM3InsertProfile(height);
}

module HingeFlangeM3Profile(height) {
    difference() {
        HingeProfile();
        translate([0, 0.1])
        circle(1.6);
        translate([-75, -100 - height])
        square(100);
    }
}
module HingeFlangeM3InsertProfile(height) {
    difference() {
        HingeProfile();
        translate([0, 0.1])
        circle(4.1 / 2);
        translate([-75, -100 - height])
        square(100);
    }
}

module HingeProfile() {
    hull() {
    translate([0, 0.1])
    circle(4.5);
    polygon([ [-6, 0], [-6, -20], [0, 0]]);
    }
    translate([-26, -20])
    square(20);
}