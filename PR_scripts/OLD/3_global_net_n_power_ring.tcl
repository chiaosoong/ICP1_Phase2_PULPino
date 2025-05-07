deselectAll
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

#Define Data RAM Instance group
set data_banks [get_cells {pulpino_top_i/core_region_i/data_mem/bank0_byte0 \
                           pulpino_top_i/core_region_i/data_mem/bank0_byte1 \
                           pulpino_top_i/core_region_i/data_mem/bank0_byte2 \
                           pulpino_top_i/core_region_i/data_mem/bank0_byte3 \
                           pulpino_top_i/core_region_i/data_mem/bank1_byte0 \
                           pulpino_top_i/core_region_i/data_mem/bank1_byte1 \
                           pulpino_top_i/core_region_i/data_mem/bank1_byte2 \
                           pulpino_top_i/core_region_i/data_mem/bank1_byte3 \
                           pulpino_top_i/core_region_i/data_mem/bank2_byte0 \
                           pulpino_top_i/core_region_i/data_mem/bank2_byte1 \
                           pulpino_top_i/core_region_i/data_mem/bank2_byte2 \
                           pulpino_top_i/core_region_i/data_mem/bank2_byte3 \
                           pulpino_top_i/core_region_i/data_mem/bank3_byte0 \
                           pulpino_top_i/core_region_i/data_mem/bank3_byte1 \
                           pulpino_top_i/core_region_i/data_mem/bank3_byte2 \
                           pulpino_top_i/core_region_i/data_mem/bank3_byte3}]


#Add ring to data ram
selectInst $data_banks

addRing -skip_via_on_wire_shape Noshape -skip_via_on_pin Standardcell -stacked_via_top_layer AP -around selected -jog_distance 0.4 -threshold 0.4 -type block_rings -nets {GND VDD} -follow core -stacked_via_bottom_layer M1 -layer {bottom M3 top M3 right M4 left M4} -width 2 -spacing 2 -offset 2 -skip_side {left top right}

deselectAll


#Add ring to instr ram
set instr_bank0 [get_cells {pulpino_top_i/core_region_i/instr_mem/sp_ram_wrap_i/bank0_byte0 \
                            pulpino_top_i/core_region_i/instr_mem/sp_ram_wrap_i/bank0_byte1 \
                            pulpino_top_i/core_region_i/instr_mem/sp_ram_wrap_i/bank0_byte2 \
                            pulpino_top_i/core_region_i/instr_mem/sp_ram_wrap_i/bank0_byte3}]

set instr_bank1 [get_cells {pulpino_top_i/core_region_i/instr_mem/sp_ram_wrap_i/bank1_byte0 \
                            pulpino_top_i/core_region_i/instr_mem/sp_ram_wrap_i/bank1_byte1 \
                            pulpino_top_i/core_region_i/instr_mem/sp_ram_wrap_i/bank1_byte2 \
                            pulpino_top_i/core_region_i/instr_mem/sp_ram_wrap_i/bank1_byte3}]

set instr_bank2 [get_cells {pulpino_top_i/core_region_i/instr_mem/sp_ram_wrap_i/bank2_byte0 \
                            pulpino_top_i/core_region_i/instr_mem/sp_ram_wrap_i/bank2_byte1 \
                            pulpino_top_i/core_region_i/instr_mem/sp_ram_wrap_i/bank2_byte2 \
                            pulpino_top_i/core_region_i/instr_mem/sp_ram_wrap_i/bank2_byte3}]

set instr_bank3 [get_cells {pulpino_top_i/core_region_i/instr_mem/sp_ram_wrap_i/bank3_byte0 \
                            pulpino_top_i/core_region_i/instr_mem/sp_ram_wrap_i/bank3_byte1 \
                            pulpino_top_i/core_region_i/instr_mem/sp_ram_wrap_i/bank3_byte2 \
                            pulpino_top_i/core_region_i/instr_mem/sp_ram_wrap_i/bank3_byte3}]

set all_instr_banks [concat $instr_bank0 $instr_bank1 $instr_bank2 $instr_bank3]

selectInst $all_instr_banks

addRing -skip_via_on_wire_shape Noshape -skip_via_on_pin Standardcell -stacked_via_top_layer AP -around selected -jog_distance 0.4 -threshold 0.4 -type block_rings -nets {GND VDD} -follow core -stacked_via_bottom_layer M1 -layer {bottom M3 top M3 right M4 left M4} -width 2 -spacing 2 -offset 2 -skip_side {left bottom right}


