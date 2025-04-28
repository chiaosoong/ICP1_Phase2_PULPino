# 1. Resize floorplan & Set margins between Core to IO: -width -height -margin
floorPlan -site CORE -s 1800 1800 20.0 20.0 20.0 20.0

# 2. Place memories
# data_mem bank 0&1
set DMEMNORTH [dbGet top.insts.name *data_mem/bank0*]
append DMEMNORTH " [dbGet top.insts.name *data_mem/bank1*]"
create_relative_floorplan -place [lindex $DMEMNORTH 0] -orient R0 -ref_type core_boundary -bbox both -horizontal_edge_separate {1 0 1} -vertical_edge_separate {0 0 0}
for {set i 1} {$i < [llength $DMEMNORTH]} {incr i} {
 set prev [expr $i-1]
 puts "Placing Data memory bank 0 and 1, macro $i"
 create_relative_floorplan -place [lindex $DMEMNORTH $i]  -orient R0 -ref_type object -ref [lindex $DMEMNORTH $prev] -bbox both -horizontal_edge_separate {1 0 1} -vertical_edge_separate {2 0 0}
}




# data_mem bank 2&3
set DMEMEAST [dbGet top.insts.name *data_mem/bank2*]
append DMEMEAST " [dbGet top.insts.name *data_mem/bank3*]"
create_relative_floorplan -place [lindex $DMEMEAST 0] -orient R270 -ref_type core_boundary -bbox both -horizontal_edge_separate {1 0 1} -vertical_edge_separate {2 0 2}
for {set i 1} {$i < [llength $DMEMEAST]} {incr i} {
 set prev [expr $i-1]
 puts "Placing Data memory bank 2 and 3, macro $i"
 create_relative_floorplan -place [lindex $DMEMEAST $i]  -orient R270 -ref_type object -ref [lindex $DMEMEAST $prev] -bbox both -horizontal_edge_separate {3 0 1} -vertical_edge_separate {0 0 0}
}



# instr_mem bank 0&1
set IMEMWEST [dbGet top.insts.name *instr_mem/sp_ram_wrap_i/bank0*]
append IMEMWEST " [dbGet top.insts.name *instr_mem/sp_ram_wrap_i/bank1*]"
create_relative_floorplan -place [lindex $IMEMWEST 0] -orient R90 -ref_type core_boundary -bbox both -horizontal_edge_separate {3 0 3} -vertical_edge_separate {0 0 0}
for {set i 1} {$i < [llength $IMEMWEST]} {incr i} {
 set prev [expr $i-1]
 puts "Placing Instr memory bank 0 and 1, macro $i"
 create_relative_floorplan -place [lindex $IMEMWEST $i]  -orient R90 -ref_type object -ref [lindex $IMEMWEST $prev] -bbox both -horizontal_edge_separate {1 0 3} -vertical_edge_separate {0 0 0}
}



# instr_mem bank 2&3
set IMEMSOUTH [dbGet top.insts.name *instr_mem/sp_ram_wrap_i/bank2*]
append IMEMSOUTH " [dbGet top.insts.name *instr_mem/sp_ram_wrap_i/bank3*]"
create_relative_floorplan -place [lindex $IMEMSOUTH 0] -orient R180 -ref_type core_boundary -bbox both -horizontal_edge_separate {3 0 3} -vertical_edge_separate {2 0 2}
for {set i 1} {$i < [llength $IMEMSOUTH]} {incr i} {
 set prev [expr $i-1]
 puts "Placing Instr memory bank 2 and 3, macro $i"
 create_relative_floorplan -place [lindex $IMEMSOUTH $i]  -orient R180 -ref_type object -ref [lindex $IMEMSOUTH $prev] -bbox both -horizontal_edge_separate {3 0 3} -vertical_edge_separate {0 0 2}
}

