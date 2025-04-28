deselectAll

#deleteAllPowerPreroutes

#Global net
clearGlobalNets
globalNetConnect VDD -type pgpin -pin vdd -inst *
globalNetConnect VDD -type pgpin -pin VDDC -inst *
globalNetConnect VDD -type tiehi -inst *
globalNetConnect GND -type pgpin -pin gnd -inst *
globalNetConnect GND -type pgpin -pin GNDC -inst *
globalNetConnect GND -type tielo -inst *

#Power ring
set sprCreateIeRingNets {}
set sprCreateIeRingLayers {}
set sprCreateIeRingWidth 1.0
set sprCreateIeRingSpacing 1.0
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
addRing -skip_via_on_wire_shape Noshape -skip_via_on_pin Standardcell -stacked_via_top_layer AP -type core_rings -jog_distance 2.5 -threshold 2.5 -nets {GND VDD} -follow core -stacked_via_bottom_layer M1 -layer {bottom M3 top M3 right M4 left M4} -width 2 -spacing 2 -offset 2

#West
selectInst $DMEMNORTH
addRing -skip_via_on_wire_shape Noshape -skip_via_on_pin Standardcell -stacked_via_top_layer AP -around selected -jog_distance 2.5 -threshold 2.5 -type block_rings -nets {GND VDD} -follow core -stacked_via_bottom_layer M1 -layer {bottom M3 top M3 right M4 left M4} -width 2 -spacing 2 -offset 2 -skip_side {left top}
#East
deselectAll
selectInst $DMEMEAST
addRing -skip_via_on_wire_shape Noshape -skip_via_on_pin Standardcell -stacked_via_top_layer AP -around selected -jog_distance 2.5 -threshold 2.5 -type block_rings -nets {GND VDD} -follow core -stacked_via_bottom_layer M1 -layer {bottom M3 top M3 right M4 left M4} -width 2 -spacing 2 -offset 2 -skip_side {right top}
#West
deselectAll
selectInst $IMEMWEST
addRing -skip_via_on_wire_shape Noshape -skip_via_on_pin Standardcell -stacked_via_top_layer AP -around selected -jog_distance 2.5 -threshold 2.5 -type block_rings -nets {GND VDD} -follow core -stacked_via_bottom_layer M1 -layer {bottom M3 top M3 right M4 left M4} -width 2 -spacing 2 -offset 2 -skip_side {left bottom}
#South
deselectAll
selectInst $IMEMSOUTH
addRing -skip_via_on_wire_shape Noshape -skip_via_on_pin Standardcell -stacked_via_top_layer AP -around selected -jog_distance 2.5 -threshold 2.5 -type block_rings -nets {GND VDD} -follow core -stacked_via_bottom_layer M1 -layer {bottom M3 top M3 right M4 left M4} -width 2 -spacing 2 -offset 2 -skip_side {right bottom}
