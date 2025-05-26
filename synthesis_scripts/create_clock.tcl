# 时间单位：ps
set ClkTop $DESIGN

##-----------CLK-----------##
set ClkName1 clk
set Clk_period 5000
set ClkLatency 250
set ClkRise_uncertainty 100
set ClkFall_uncertainty 100
set ClkSlew 250
set InputDelay 250
set OutputDelay 250

# clk（200MHz）
define_clock -name $ClkName1 -period $Clk_period -design $ClkTop [find / -port clk*]

set_attribute clock_network_late_latency $ClkLatency $ClkName1
set_attribute clock_source_late_latency  $ClkLatency $ClkName1

set_attribute clock_setup_uncertainty $ClkLatency $ClkName1
set_attribute clock_hold_uncertainty $ClkLatency $ClkName1 

set_attribute slew_rise $ClkRise_uncertainty $ClkName1 
set_attribute slew_fall $ClkFall_uncertainty $ClkName1

external_delay -input $InputDelay  -clock [find / -clock $ClkName1] -name in_con_clk  [find /des* -port ports_in/*]
external_delay -output $OutputDelay -clock [find / -clock $ClkName1] -name out_con_clk [find /des* -port ports_out/*]

##-----------SPI_CLK-----------##
set ClkName2 spi_clk
set SPI_Clk_period 50000
set SPI_ClkLatency 2500
set SPI_ClkRise_uncertainty 1000
set SPI_ClkFall_uncertainty 1000
set SPI_ClkSlew 2500
set SPI_InputDelay 2500
set SPI_OutputDelay 2500

# spi_clk（20MHz）
define_clock -name $ClkName2 -period $SPI_Clk_period -design $ClkTop [find / -port spi_clk_i*]

set_attribute clock_network_late_latency $SPI_ClkLatency $ClkName2
set_attribute clock_source_late_latency  $SPI_ClkLatency $ClkName2 

set_attribute clock_setup_uncertainty $SPI_ClkLatency $ClkName2
set_attribute clock_hold_uncertainty $SPI_ClkLatency $ClkName2 

set_attribute slew_rise $SPI_ClkRise_uncertainty $ClkName2 
set_attribute slew_fall $SPI_ClkFall_uncertainty $ClkName2

external_delay -input $SPI_InputDelay  -clock [find / -clock $ClkName2] -name in_con_spi  [find /des* -port ports_in/*]
external_delay -output $SPI_OutputDelay -clock [find / -clock $ClkName2] -name out_con_spi [find /des* -port ports_out/*]

##-----------TCK_i-----------##
set ClkName3 tck_i
set TCK_Clk_period 50000
set TCK_ClkLatency 2500
set TCK_ClkRise_uncertainty 1000
set TCK_ClkFall_uncertainty 1000
set TCK_ClkSlew 2500
set TCK_InputDelay 2500
set TCK_OutputDelay 2500

# tck_i（20MHz）
define_clock -name $ClkName3 -period $TCK_Clk_period -design $ClkTop [find / -port tck_i*]

set_attribute clock_network_late_latency $TCK_ClkLatency $ClkName3
set_attribute clock_source_late_latency  $TCK_ClkLatency $ClkName3 

set_attribute clock_setup_uncertainty $TCK_ClkLatency $ClkName3
set_attribute clock_hold_uncertainty $TCK_ClkLatency $ClkName3 

set_attribute slew_rise $TCK_ClkRise_uncertainty $ClkName3 
set_attribute slew_fall $TCK_ClkFall_uncertainty $ClkName3
 
external_delay -input $TCK_InputDelay  -clock [find / -clock $ClkName3] -name in_con_tck [find /des* -port ports_in/*]
external_delay -output $TCK_OutputDelay -clock [find / -clock $ClkName3] -name out_con_tck [find /des* -port ports_out/*]


##-----------Asynchrounous Define-----------##
# 声明异步时钟域
set_clock_groups -asynchronous -group {clk} -group {spi_clk} -group {tck_i}

# 跨时钟域路径约束
# clk <-> spi_clk
#set_false_path -from [get_clocks clk] -to [get_clocks spi_clk]
#set_false_path -from [get_clocks spi_clk] -to [get_clocks clk]
# clk <-> tck_i
#set_false_path -from [get_clocks clk] -to [get_clocks tck_i]
#set_false_path -from [get_clocks tck_i] -to [get_clocks clk]
# spi_clk <-> tck_i
#set_false_path -from [get_clocks spi_clk] -to [get_clocks tck_i]
#set_false_path -from [get_clocks tck_i] -to [get_clocks spi_clk]





