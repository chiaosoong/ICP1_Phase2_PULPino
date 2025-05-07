# 1. Resize floorplan & Set margins between Core to IO: -width -height -margin
floorPlan -site CORE -s 1500 1500 20.0 20.0 20.0 20.0

# 2. Place memories -llx -lly -urx -ury 
# 矩形左下角（lower‐left）的 x 和 y 坐标
# 矩形右上角（upper‐right）的 x 和 y 坐标
#set core_box [dbGet top.fPlan.core_area]
set core_llx 76
set core_lly 76
set core_urx 1576
set core_ury 1576
set width 103.2
set heigth 170.2
# Data - Bank0
setObjFPlanBox Instance pulpino_top_i/core_region_i/data_mem/bank0_byte0 [expr {$core_llx + 5}]             [expr {$core_ury - 5 - $heigth}] [expr {$core_llx +  5 +   $width}] [expr {$core_ury - 5}]
setObjFPlanBox Instance pulpino_top_i/core_region_i/data_mem/bank0_byte1 [expr {$core_llx + 10 +   $width}] [expr {$core_ury - 5 - $heigth}] [expr {$core_llx + 10 + 2*$width}] [expr {$core_ury - 5}]
setObjFPlanBox Instance pulpino_top_i/core_region_i/data_mem/bank0_byte2 [expr {$core_llx + 15 + 2*$width}] [expr {$core_ury - 5 - $heigth}] [expr {$core_llx + 15 + 3*$width}] [expr {$core_ury - 5}]
setObjFPlanBox Instance pulpino_top_i/core_region_i/data_mem/bank0_byte3 [expr {$core_llx + 20 + 3*$width}] [expr {$core_ury - 5 - $heigth}] [expr {$core_llx + 20 + 4*$width}] [expr {$core_ury - 5}]

# Data - Bank1
setObjFPlanBox Instance pulpino_top_i/core_region_i/data_mem/bank1_byte0 [expr {$core_llx + 25 + 4*$width}] [expr {$core_ury - 5 - $heigth}] [expr {$core_llx + 25 + 5*$width}] [expr {$core_ury - 5}]
setObjFPlanBox Instance pulpino_top_i/core_region_i/data_mem/bank1_byte1 [expr {$core_llx + 30 + 5*$width}] [expr {$core_ury - 5 - $heigth}] [expr {$core_llx + 30 + 6*$width}] [expr {$core_ury - 5}]
setObjFPlanBox Instance pulpino_top_i/core_region_i/data_mem/bank1_byte2 [expr {$core_llx + 35 + 6*$width}] [expr {$core_ury - 5 - $heigth}] [expr {$core_llx + 35 + 7*$width}] [expr {$core_ury - 5}]
setObjFPlanBox Instance pulpino_top_i/core_region_i/data_mem/bank1_byte3 [expr {$core_llx + 40 + 7*$width}] [expr {$core_ury - 5 - $heigth}] [expr {$core_llx + 40 + 8*$width}] [expr {$core_ury - 5}]

# Data - Bank2
setObjFPlanBox Instance pulpino_top_i/core_region_i/data_mem/bank2_byte0 [expr {$core_llx + 45 + 8*$width}]  [expr {$core_ury - 5 - $heigth}] [expr {$core_llx + 45 + 9*$width}]  [expr {$core_ury - 5}]
setObjFPlanBox Instance pulpino_top_i/core_region_i/data_mem/bank2_byte1 [expr {$core_llx + 50 + 9*$width}]  [expr {$core_ury - 5 - $heigth}] [expr {$core_llx + 50 + 10*$width}] [expr {$core_ury - 5}]
setObjFPlanBox Instance pulpino_top_i/core_region_i/data_mem/bank2_byte2 [expr {$core_llx + 55 + 10*$width}] [expr {$core_ury - 5 - $heigth}] [expr {$core_llx + 55 + 11*$width}] [expr {$core_ury - 5}]
setObjFPlanBox Instance pulpino_top_i/core_region_i/data_mem/bank2_byte3 [expr {$core_llx + 60 + 11*$width}] [expr {$core_ury - 5 - $heigth}] [expr {$core_llx + 60 + 12*$width}] [expr {$core_ury - 5}]

# Data - Bank3
setObjFPlanBox Instance pulpino_top_i/core_region_i/data_mem/bank3_byte0 [expr {$core_llx + 65 + 12*$width}] [expr {$core_ury - 5 - $heigth}] [expr {$core_llx + 65 + 13*$width}] [expr {$core_ury - 5}]
setObjFPlanBox Instance pulpino_top_i/core_region_i/data_mem/bank3_byte1 [expr {$core_llx + 70 + 13*$width}] [expr {$core_ury - 5 - $heigth}] [expr {$core_llx + 70 + 14*$width}] [expr {$core_ury - 5}]
setObjFPlanBox Instance pulpino_top_i/core_region_i/data_mem/bank3_byte2 [expr {$core_llx + 75 + 14*$width}] [expr {$core_ury - 5 - $heigth}] [expr {$core_llx + 75 + 15*$width}] [expr {$core_ury - 5}]
setObjFPlanBox Instance pulpino_top_i/core_region_i/data_mem/bank3_byte3 [expr {$core_llx + 80 + 15*$width}] [expr {$core_ury - 5 - $heigth}] [expr {$core_llx + 80 + 16*$width}] [expr {$core_ury - 5}]





# Instr - Bank0
setObjFPlanBox Instance pulpino_top_i/core_region_i/instr_mem/sp_ram_wrap_i/bank0_byte0 [expr {$core_llx + 5}]	           [expr {$core_lly + 5}] [expr {$core_llx +  5 +   $width}] [expr {$core_lly + 5 + $heigth}]
setObjFPlanBox Instance pulpino_top_i/core_region_i/instr_mem/sp_ram_wrap_i/bank0_byte1 [expr {$core_llx + 10 +   $width}] [expr {$core_lly + 5}] [expr {$core_llx + 10 + 2*$width}] [expr {$core_lly + 5 + $heigth}]
setObjFPlanBox Instance pulpino_top_i/core_region_i/instr_mem/sp_ram_wrap_i/bank0_byte2 [expr {$core_llx + 15 + 2*$width}] [expr {$core_lly + 5}] [expr {$core_llx + 15 + 3*$width}] [expr {$core_lly + 5 + $heigth}]
setObjFPlanBox Instance pulpino_top_i/core_region_i/instr_mem/sp_ram_wrap_i/bank0_byte3 [expr {$core_llx + 20 + 3*$width}] [expr {$core_lly + 5}] [expr {$core_llx + 20 + 4*$width}] [expr {$core_lly + 5 + $heigth}]

# Instr - Bank1
setObjFPlanBox Instance pulpino_top_i/core_region_i/instr_mem/sp_ram_wrap_i/bank1_byte0 [expr {$core_llx + 25 + 4*$width}] [expr {$core_lly + 5}] [expr {$core_llx + 25 + 5*$width}] [expr {$core_lly + 5 + $heigth}]
setObjFPlanBox Instance pulpino_top_i/core_region_i/instr_mem/sp_ram_wrap_i/bank1_byte1 [expr {$core_llx + 30 + 5*$width}] [expr {$core_lly + 5}] [expr {$core_llx + 30 + 6*$width}] [expr {$core_lly + 5 + $heigth}]
setObjFPlanBox Instance pulpino_top_i/core_region_i/instr_mem/sp_ram_wrap_i/bank1_byte2 [expr {$core_llx + 35 + 6*$width}] [expr {$core_lly + 5}] [expr {$core_llx + 35 + 7*$width}] [expr {$core_lly + 5 + $heigth}]
setObjFPlanBox Instance pulpino_top_i/core_region_i/instr_mem/sp_ram_wrap_i/bank1_byte3 [expr {$core_llx + 40 + 7*$width}] [expr {$core_lly + 5}] [expr {$core_llx + 40 + 8*$width}] [expr {$core_lly + 5 + $heigth}]

# Instr - Bank2
setObjFPlanBox Instance pulpino_top_i/core_region_i/instr_mem/sp_ram_wrap_i/bank2_byte0 [expr {$core_llx + 45 + 8*$width}] [expr {$core_lly + 5}] [expr {$core_llx + 45 + 9*$width}] [expr {$core_lly + 5 + $heigth}]
setObjFPlanBox Instance pulpino_top_i/core_region_i/instr_mem/sp_ram_wrap_i/bank2_byte1 [expr {$core_llx + 50 + 9*$width}] [expr {$core_lly + 5}] [expr {$core_llx + 50 + 10*$width}] [expr {$core_lly + 5 + $heigth}]
setObjFPlanBox Instance pulpino_top_i/core_region_i/instr_mem/sp_ram_wrap_i/bank2_byte2 [expr {$core_llx + 55 + 10*$width}] [expr {$core_lly + 5}] [expr {$core_llx + 55 + 11*$width}] [expr {$core_lly + 5 + $heigth}]
setObjFPlanBox Instance pulpino_top_i/core_region_i/instr_mem/sp_ram_wrap_i/bank2_byte3 [expr {$core_llx + 60 + 11*$width}] [expr {$core_lly + 5}] [expr {$core_llx + 60 + 12*$width}] [expr {$core_lly + 5 + $heigth}]

# Instr - Bank3
setObjFPlanBox Instance pulpino_top_i/core_region_i/instr_mem/sp_ram_wrap_i/bank3_byte0 [expr {$core_llx + 65 + 12*$width}] [expr {$core_lly + 5}] [expr {$core_llx + 65 + 13*$width}] [expr {$core_lly + 5 + $heigth}]
setObjFPlanBox Instance pulpino_top_i/core_region_i/instr_mem/sp_ram_wrap_i/bank3_byte1 [expr {$core_llx + 70 + 13*$width}] [expr {$core_lly + 5}] [expr {$core_llx + 70 + 14*$width}] [expr {$core_lly + 5 + $heigth}]
setObjFPlanBox Instance pulpino_top_i/core_region_i/instr_mem/sp_ram_wrap_i/bank3_byte2 [expr {$core_llx + 75 + 14*$width}] [expr {$core_lly + 5}] [expr {$core_llx + 75 + 15*$width}] [expr {$core_lly + 5 + $heigth}]
setObjFPlanBox Instance pulpino_top_i/core_region_i/instr_mem/sp_ram_wrap_i/bank3_byte3 [expr {$core_llx + 80 + 15*$width}] [expr {$core_lly + 5}] [expr {$core_llx + 80 + 16*$width}] [expr {$core_lly + 5 + $heigth}]









