#Define Instr RAM Instance group
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


# Flip the instr RAM
set angle R180
# Bank0
deselectAll

selectInst $instr_bank0
flipOrRotateObject -rotate $angle
# Bank1
deselectAll

selectInst $instr_bank1
flipOrRotateObject -rotate $angle
# Bank2
deselectAll

selectInst $instr_bank2
flipOrRotateObject -rotate $angle
# Bank3
deselectAll

selectInst $instr_bank3
flipOrRotateObject -rotate $angle

deselectAll
