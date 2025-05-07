# Modified by: Fuad Mammadzada
# Date: 27.01.2025
# 
# Modifications:
# 	* It includes building the libraries (CORE, CLOCK, MEMORY, PADS)
# 	* On top of launching the post-synthesis simulation, it can also launch 
# 	RTL simulation
# 	* More comments to explain the Makefile code for students to understand
# 	and modify it to their own needs.
#
#
# =========================================================================================================
# This Makefile is designed as a template to make QuestaSim compilation and simulation process automated
# run "make" command to run comp+sim for post-synth
# run "make rtl" to run comp+sim for RTL simulation
# edit paths and commands according to your needs, this is meant to be just a template

THISDIR = $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

# Post-synthesis netlist file
PPR_NETLIST_RTL = ../PR/outputs/pulpino_padstop.v

# Source files for RTL simulation 
ROOT := /h/d5/u/fa7855yu-s/etin35_project/pulpino
RTL := $(ROOT)/rtl
TB := $(ROOT)/tb

DESIGN_RTL = \ ${RTL}/pulpino_padstop.v

# Testbench source files
SOURCES_TB =  \
	${TB}/if_spi_master.sv \
	${TB}/if_spi_slave.sv \
	${TB}/jtag_dpi.sv \
	${TB}/pkg_spi.sv \
	${TB}/tb_jtag_pkg.sv \
	${TB}/uart.sv \
	${TB}/config.sv \
	${TB}/spi_pkg.sv \
	${TB}/testbench.sv \
	${TB}/tb_spi_pkg.sv \
	${TB}/spi_debug_test.svh \
	${TB}/mem_dpi.svh



# Post-synthesis SDF file
SDF_FILE = ../PR/outputs/pulpino_padstop.sdf
ANNOTATE_WITH_SDF = -sdfmax :testbench:pulpino_padstop_inst=$(SDF_FILE) +sdf_verbose -sdfmin :testbench:pulpino_padstop_inst=$(SDF_FILE) +sdf_verbose

# OPTIMIZATION = -vopt
OPTIMIZATION = -novopt


## TARGETS
default: ps

echo_this_dir:
	echo $(THISDIR)

# Compilation S
compile_libs:
	./build_libs.sh

compile_rtl:
	vlog -work work $(DESIGN_RTL) # QuestaSim compiler for VHDL is "vcom"

compile_ps:
	vlog -work work $(PPR_NETLIST_RTL) # QuestaSim compiler for Verilog is "vlog"


compile_tb:
	vlog -sv -work work $(SOURCES_TB)

# Simulation 
# vsim is the command to launch the QuestaSim window and set-up the simulation (it doesn't start running the simulation) 
ps: compile_libs compile_ps compile_tb
	export MODELSIM=$(THISDIR)/modelsim.ini && vsim -L CLOCK65LPLVT -L CORE65LPLVT -L MEMORY -L PADS -L work -L work work.testbench $(ANNOTATE_WITH_SDF) $(OPTIMIZATION) -sdfnoerror

# rtl is dependent on compile_libs, compile_rtl and compiles_tb, so running "make rtl" will actually run those targets as well 
rtl: compile_libs compile_rtl compile_tb
	export MODELSIM=$(THISDIR)/modelsim.ini && vsim -L CLOCK65LPLVT -L CORE65LPLVT -L MEMORY -L PADS -L work work.testbench

clean:
	@cd $(THISDIR) && rm -rf $(THISDIR)/work
	@cd $(THISDIR) && rm -rf vsim.wlf
	@cd $(THISDIR) && rm -rf transcript
