# 时间单位：ps

# 定义主时钟 clk（100MHz）
create_clock -name clk -period 10000 [get_ports clk]

# 定义 SPI 时钟 spi_clk（50MHz）
create_clock -name spi_clk -period 20000 [get_ports spi_clk_i]

# 定义 JTAG 时钟 tck_i（10MHz）
create_clock -name tck_i -period 100000 [get_ports tck_i]

# 声明异步时钟域
set_clock_groups -asynchronous -group {clk} -group {spi_clk} -group {tck_i}

# 跨时钟域路径约束
# clk <-> spi_clk
set_false_path -from [get_clocks clk] -to [get_clocks spi_clk]
set_false_path -from [get_clocks spi_clk] -to [get_clocks clk]
# clk <-> tck_i
set_false_path -from [get_clocks clk] -to [get_clocks tck_i]
set_false_path -from [get_clocks tck_i] -to [get_clocks clk]
# spi_clk <-> tck_i
set_false_path -from [get_clocks spi_clk] -to [get_clocks tck_i]
set_false_path -from [get_clocks tck_i] -to [get_clocks spi_clk]

set ClkName1 clk
set ClkName2 spi_clk
set ClkName3 tck_i

set ClkLatency 500
set ClkRise_uncertainty 200
set ClkFall_uncertainty 200
set ClkSlew 500
set InputDelay 500
set OutputDelay 500


set_attribute clock_network_late_latency $ClkLatency $ClkName1
set_attribute clock_source_late_latency  $ClkLatency $ClkName1

set_attribute clock_setup_uncertainty $ClkLatency $ClkName1
set_attribute clock_hold_uncertainty $ClkLatency $ClkName1 

set_attribute slew_rise $ClkRise_uncertainty $ClkName1 
set_attribute slew_fall $ClkFall_uncertainty $ClkName1

set_attribute clock_network_late_latency $ClkLatency $ClkName2
set_attribute clock_source_late_latency  $ClkLatency $ClkName2 

set_attribute clock_setup_uncertainty $ClkLatency $ClkName2
set_attribute clock_hold_uncertainty $ClkLatency $ClkName2 

set_attribute slew_rise $ClkRise_uncertainty $ClkName2 
set_attribute slew_fall $ClkFall_uncertainty $ClkName2

set_attribute clock_network_late_latency $ClkLatency $ClkName3
set_attribute clock_source_late_latency  $ClkLatency $ClkName3 

set_attribute clock_setup_uncertainty $ClkLatency $ClkName3
set_attribute clock_hold_uncertainty $ClkLatency $ClkName3 

set_attribute slew_rise $ClkRise_uncertainty $ClkName3 
set_attribute slew_fall $ClkFall_uncertainty $ClkName3
 
external_delay -input $InputDelay  -clock [find / -clock $ClkName1] -name in_con  [find /des* -port ports_in/*]
external_delay -output $OutputDelay -clock [find / -clock $ClkName1] -name out_con [find /des* -port ports_out/*]

external_delay -input $InputDelay  -clock [find / -clock $ClkName2] -name in_con  [find /des* -port ports_in/*]
external_delay -output $OutputDelay -clock [find / -clock $ClkName2] -name out_con [find /des* -port ports_out/*]

external_delay -input $InputDelay  -clock [find / -clock $ClkName3] -name in_con  [find /des* -port ports_in/*]
external_delay -output $OutputDelay -clock [find / -clock $ClkName3] -name out_con [find /des* -port ports_out/*]
