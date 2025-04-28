deselectAll
addHaloToBlock {10 10 10 10} -allBlock

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

set all_ram_banks [concat $instr_bank0 $instr_bank1 $instr_bank2 $instr_bank3 $data_banks]

selectInst $all_ram_banks

cutRow -selected
deselectAll


