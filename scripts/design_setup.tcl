# Change this variable to top entity of your own design
set DESIGN my_awesome_design 

# Change this variable to the RTL path of your own design
set RTL "${ROOT}/hdl"

set_attribute script_search_path $SYNT_SCRIPT /

set_attribute init_hdl_search_path $RTL /

set_attribute init_lib_search_path { \
/usr/local-eit/cad2/cmpstm/stm065v536/CORE65LPLVT_5.1/libs \
/usr/local-eit/cad2/cmpstm/stm065v536/CLOCK65LPLVT_3.1/libs \
/usr/local-eit/cad2/cmpstm/oldmems/mem2011/SPHD110420-48158@1.0/libs \
/usr/local-eit/cad2/cmpstm/dicp18/lu_pads_65nm \
} /

set_attribute library { \
CLOCK65LPLVT_nom_1.20V_25C.lib \
CORE65LPLVT_nom_1.20V_25C.lib \
SPHD110420_nom_1.20V_25C.lib \
Pads_Oct2012.lib} /

# put all your design files here
set DESIGN_FILES "${RTL}/sram_wrapper.vhd ${RTL}/my_awesome_design.vhd"

set SYN_EFF medium 
set MAP_EFF medium 
set OPT_EFF medium 

set_attribute syn_generic_effort ${SYN_EFF}
set_attribute syn_map_effort ${MAP_EFF}
set_attribute syn_opt_effort ${OPT_EFF}
set_attribute information_level 5; # Up to maximum 9
