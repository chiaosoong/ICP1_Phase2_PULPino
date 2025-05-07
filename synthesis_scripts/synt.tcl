set ROOT "/h/d5/u/fa7855yu-s/etin35_project/pulpino"

set SYNT_SCRIPT    "${ROOT}/WORK/Synthesis/scripts"
set SYNT_OUT       "${ROOT}/WORK/Synthesis/outputs"
set SYNT_REPORT    "${ROOT}/WORK/Synthesis/reports"

if {![file exists ${SYNT_SCRIPT}]}     { file mkdir ${SYNT_SCRIPT}}
if {![file exists ${SYNT_OUT}]}        { file mkdir ${SYNT_OUT}}
if {![file exists ${SYNT_REPORT}]}     { file mkdir ${SYNT_REPORT}}

puts "\n\n\n DESIGN FILES \n\n\n"
source $SYNT_SCRIPT/design_setup.tcl

puts "\n\n\n ANALYZE HDL DESIGN \n\n\n"

read_hdl -v2001 ${DESIGN_FILES_v1}
read_hdl -sv    ${DESIGN_FILES_sv1}
read_hdl -sv    ${DESIGN_FILES_sv2}
read_hdl -v2001 ${DESIGN_FILES_v2}
read_hdl -sv    ${DESIGN_FILES_sv3}
read_hdl -sv    ${DESIGN_FILES_sv4}
read_hdl -sv    ${DESIGN_FILES_sv5}
read_hdl -sv    ${DESIGN_FILES_sv6}
read_hdl -sv    ${DESIGN_FILES_sv7}
read_hdl -vhdl  ${DESIGN_FILES_vhd}
read_hdl -v2001 ${DESIGN_FILES_v3}

set_attribute hdl_error_on_blackbox true
#set_attribute hdl_error_on_latch true

puts "\n\n\n ELABORATE \n\n\n"
elaborate ${DESIGN}

check_design
report timing -lint

puts "\n\n\n TIMING CONSTRAINTS \n\n\n"
source $SYNT_SCRIPT/create_clock.tcl

puts "\n\n\n SYN_GENERIC \n\n\n"
syn_generic

puts "\n\n\n SYN_MAP \n\n\n"
syn_map

puts "\n\n\n SYN_OPT \n\n\n"
syn_opt

puts "\n\n\n EXPORT DESIGN \n\n\n"
write_hdl    > ${SYNT_OUT}/${DESIGN}.v
write_sdc    > ${SYNT_OUT}/${DESIGN}.sdc
write_sdf   -version 3.0  > ${SYNT_OUT}/${DESIGN}.sdf

puts "\n\n\n REPORTING \n\n\n"
report qor      > $SYNT_REPORT/qor_${DESIGN}.rpt
report area     > $SYNT_REPORT/area_${DESIGN}.rpt
report datapath > $SYNT_REPORT/datapath_${DESIGN}.rpt
report messages > $SYNT_REPORT/messages_${DESIGN}.rpt
report gates    > $SYNT_REPORT/gates_${DESIGN}.rpt
report timing   > $SYNT_REPORT/timing_${DESIGN}.rpt
report timing -lint > $SYNT_REPORT/timing_lint_${DESIGN}.rpt
