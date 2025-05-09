#!/bin/bash
# Source the setup file
source ../../../setup2022.efd
# Clean
make clean
# The name of your C project to be compiled. Change this to the the project that you want to compile & run!
PROJECT_NAME=MM
# Execute the make commands using the project name variable
make "${PROJECT_NAME}.read"
make vcompile
make "${PROJECT_NAME}.vsim.spi"
