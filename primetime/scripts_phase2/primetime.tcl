####----------------------------------------------------------####
# Title        : primeTime Sample Script
# Project      : IC Project 1
####----------------------------------------------------------####
# File         : ptime.tcl
# Module Name  : 
# Project Root : 
# Author       : Masoud Nouripayam (ma1570no@eit.lth.se)
# Company      : Digital ASIC Group, EIT, LTH, Lund University
# Created      : 2020-03-02
# Last Edit    : 
# version      : 1
####----------------------------------------------------------####
# Description  : 
####----------------------------------------------------------####

##################  remove any previous designs 
remove_design -all

################### set up power analysis mode #####################
# step 0: Define Top Module name 
set TOP pulpino_padstop

################### set up power analysis mode #####################
# step 1: enalbe analysis mode 
set power_enable_analysis  true
set power_analysis_mode time_based

####################### set up libaries ############################
# step 2: link to your design libary 

### Make sure you choose the same files and paths as you have used in
### synthesis and pnr stage

set search_path "\
/usr/local-eit/cad2/cmpstm/stm065v536/CORE65LPLVT_5.1/libs \
/usr/local-eit/cad2/cmpstm/stm065v536/CLOCK65LPLVT_3.1/libs \
/usr/local-eit/cad2/cmpstm/oldmems/mem2010/SPHDL100909-40446@1.0/libs \
/usr/local-eit/cad2/cmpstm/dicp18/lu_pads_65nm"

set link_path   "* \
CORE65LPLVT_bc_1.30V_m40C.db \
CLOCK65LPLVT_bc_1.30V_m40C.db \
SPHDL100909_bc_1.30V_m40C.db \
Pads_Oct2012.db"

#get_app_var link_path

#CORE65LPLVT_wc_1.10V_125C_10y.db \
#CLOCK65LPLVT_wc_1.10V_125C_10y.db \
#SPHDL100909_wc_1.10V_125C_10y.db \

####################### design input    ############################
# step 3: read your design (netlist) & link design
read_verilog ../PR/outputs/pulpino_padstop.v
current_design $TOP
link_design -force

####################### timing constraint ##########################
# step 4: setup timing constraint (or read sdc file)
source ../Synthesis/outputs/pulpino_padstop.sdc

####################### Back annotate     ##########################
# step 5: back annotate delay information (read sdf file)
read_parasitics ../PR/outputs/pulpino_padstop_ff.spef
read_sdf -type sdf_max ../PR/outputs/pulpino_padstop.sdf

################# read switching activity file #####################
# step 6: read vcd file obtained from post-layout (syn) simulation
read_vcd -strip_path testbench/pulpino_padstop_inst /export/space/nobackup/fa7855yu-s/VCD_MM.vcd

####################### analysis and report #################
# step 7: Analysis the power
check_power
update_power

####################### report  #################
# step 8: output report
report_power -verbose > /h/d2/a/me0186ta-s/ICP1/Primetime/reports/power.rpt
report_timing -delay_type min -max_paths 10 > ./reports/timing_hold.rpt
report_timing -delay_type max -max_paths 10 > .reports/timing_setup.rpt
# report_timing -from [all_registers -clock_pins] [all_inputs] -to [all_registers -data_pins] [all_outputs] > /h/d2/a/me0186ta-s/ICP1/Primetime/reports/timing.rpt
report_constraints -all_violators > ./reports/timing_violation.rpt
report_clock_timing -type skew -verbose > ./reports/timing_skew.rpt


