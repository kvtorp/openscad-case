A parametric case defined in openSCAD

The case is a "suitcase" style box with hinged lid and clasp(s), which can be imported in a slicer and printed.
Notice that a multimaterial printer is required (preferably at least 4 materials), multicolor will not be enough (AMS and MMU will not work)

Everything but cutouts in the "foam" are controlled in the file dimensions.scad

If you want cutouts in the "foam", and want to define them in openSCAD, add them in the file Parts/box-inset.scad
You can also wait and add (subtract) them in the slicer later.

Slicing

Use the provided box.3mf and lid.3mf files, and substitute the parts with your own parts.
Or set up the prints all on your own, see below

Setting up filaments

Use 2 color-coordinated PETG filaments on extruders 1 and 2. In the following, it is assumed that the case will be printed from extruder 1, and buckles and text from extruder 2.
Use PLA on extruder 3, for supports. DO NOT ENABLE SUPPORTS - they are part of the model (the autogenerated supports become very high and thin and do not print well).
Use a very soft TPU/E on extruder 5. TPE88 from Filament PM works well for me, even though it is a PITA to load.

For both the PLA and TPU/E, set the bed temperature to 85 C to match the PETG bed temperature.

Print settings

In Layers and perimeters:
Set the number of perimeters so that the shell of the case will print solid, 4 works well for me with 2 mm thickness and 0.4 mm nozzle.
Set the bottom layers so that the bottom will print solid, even when adding connectors for the inset, 6 is the magic number for me.

In Multiple extruders:
Set the wipe tower extruder to 1 (it is important that this is the same as is used for the case body)
Enable Interface shells
As I am writing this, I just saw Jo Prusa's video on using segmented regions for interlocking heterogeneous materials. I might make an update if I can make it work locally

Importing objects

Place box.stl, and then add all the other box- STLs as parts.
box.stl should be printed using extruder 1 (main color PETG)
box-inset.stl and box-inset-patches.stl should be printed using extruder 5 (TPU/E)
box-supports should be printed using extruder 3 (PLA forsupports)

If the box is not too big, the lid can be placed on the same plate, or you can print it separately.

Place lid.stl, and then add all the other lid- STLs as parts.
lid.stl should be printed using extruder 1 (main color PETG)
lid-buckles and lid-text should be printed using extruder 2 (accent color PETG)
lid-inset.stl and lid-inset-patches.stl should be printed using extruder 5 (TPU/E)

For box-inset.stl and lid-inset.stl, add special infill and Layers and Perimeters settings:
Fill density: 15%
Fill pattern: Gyroid
Bottom solid layers: 0
Perimeters: 0
Top solid layers: 0
This makes the inset print as a sponge. The inset patches are meant to be solid, do not change print settings for these

For box-supports.stl, add special Layers and Perimeters settings:
Bottom solid layers: 2
Perimeters: 1
Top solid layers: 4
To avoid spending too much filament on the supports.



Slice and print!
