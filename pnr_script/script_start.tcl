earGlobalNets
globalNetConnect VDD -type pgpin -pin {} -inst *vdd
globalNetConnect VDD -type pgpin -pin {} -inst *VDDC
globalNetConnect GND -type pgpin -pin {} -inst *gnd
globalNetConnect GND -type pgpin -pin {} -inst *GNDC
globalNetConnect GND -type tielo
globalNetConnect VDD -type tiehi
setIoFlowFlag 0
floorPlan -site CORE -s 500.0 450.0 20.0 20.0 20.0 20.0
uiSetTool select
getIoFlowFlag
fit
addHaloToBlock {10 10 10 10} -allBlock
deselectAll
selectInst i_TOP_MM/ins3_ram/ram_behav
cutRow -selected
fit
deselectAll
set sprCreateIeRingNets {}
set sprCreateIeRingLayers {}
set sprCreateIeRingWidth 1.0
set sprCreateIeRingSpacing 1.0
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
addRing -skip_via_on_wire_shape Noshape -skip_via_on_pin Standardcell -stacked_via_top_layer AP -type core_rings -jog_distance 0.4 -threshold 0.4 -nets {VDD GND} -follow core -stacked_via_bottom_layer M1 -layer {bottom M3 top M3 right M4 left M4} -width 2 -spacing 2 -offset 2
addRing -skip_via_on_wire_shape Noshape -skip_via_on_pin Standardcell -stacked_via_top_layer AP -around each_block -jog_distance 0.4 -threshold 0.4 -type block_rings -nets {VDD GND} -follow core -stacked_via_bottom_layer M1 -layer {bottom M3 top M3 right M4 left M4} -width 2 -spacing 2 -offset 2 -skip_side {top right}
editPushUndo
addRing -skip_via_on_wire_shape Noshape -skip_via_on_pin Standardcell -stacked_via_top_layer AP -around each_block -jog_distance 0.4 -threshold 0.4 -type block_rings -nets {VDD GND} -follow core -stacked_via_bottom_layer M1 -layer {bottom M3 top M3 right M4 left M4} -width 2 -spacing 2 -offset 2 -skip_side {top right}
fit
deselectAll
deselectAll
set sprCreateIeStripeNets {}
set sprCreateIeStripeLayers {}
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeSpacing 2.0
set sprCreateIeStripeThreshold 1.0
addStripe -skip_via_on_wire_shape Noshape -block_ring_top_layer_limit M1 -max_same_layer_jog_length 6 -padcore_ring_bottom_layer_limit M1 -set_to_set_distance 100 -skip_via_on_pin Standardcell -stacked_via_top_layer AP -padcore_ring_top_layer_limit M1 -spacing 2 -merge_stripes_value 2.5 -layer M4 -block_ring_bottom_layer_limit M1 -stop_x 0 -stop_y 0 -width 2 -area {} -nets {VDD GND} -start_x 0 -stacked_via_bottom_layer M1 -start_y 0
editPushUndo
addStripe -skip_via_on_wire_shape Noshape -block_ring_top_layer_limit M1 -max_same_layer_jog_length 6 -padcore_ring_bottom_layer_limit M1 -set_to_set_distance 100 -skip_via_on_pin Standardcell -stacked_via_top_layer AP -padcore_ring_top_layer_limit M1 -spacing 2 -merge_stripes_value 2.5 -direction horizontal -layer M3 -block_ring_bottom_layer_limit M1 -stop_x 0 -stop_y 0 -width 2 -area {} -nets {VDD GND} -start_x 0 -stacked_via_bottom_layer M1 -start_y 0
editPushUndo
addStripe -skip_via_on_wire_shape Noshape -block_ring_top_layer_limit M1 -max_same_layer_jog_length 6 -padcore_ring_bottom_layer_limit M1 -set_to_set_distance 100 -skip_via_on_pin Standardcell -stacked_via_top_layer AP -padcore_ring_top_layer_limit M1 -spacing 2 -merge_stripes_value 2.5 -direction horizontal -layer M3 -block_ring_bottom_layer_limit M1 -stop_x 0 -stop_y 0 -width 2 -area {} -nets {VDD GND} -start_x 0 -stacked_via_bottom_layer M1 -start_y 0
