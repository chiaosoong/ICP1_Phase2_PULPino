# 时间单位：ns

# 定义主时钟 clk（100MHz）
create_clock -name clk -period 10 [get_ports clk]

# 定义 SPI 时钟 spi_clk（50MHz）
create_clock -name spi_clk -period 20 [get_ports spi_clk_i]

# 声明异步时钟域
set_clock_groups -asynchronous -group {clk} -group {spi_clk}

# 跨时钟域路径约束
set_false_path -from [get_clocks clk] -to [get_clocks spi_clk]
set_false_path -from [get_clocks spi_clk] -to [get_clocks clk]

# 设置时钟不确定性
set_clock_uncertainty -setup 0.2 -hold 0.2 [get_clocks clk]
set_clock_uncertainty -setup 0.2 -hold 0.2 [get_clocks spi_clk]

# 设置时钟网络延迟
set_clock_latency 0.5 [get_clocks clk]
set_clock_latency 0.5 [get_clocks spi_clk]

# 设置时钟压摆率
set_clock_transition 0.5 [get_clocks clk]
set_clock_transition 0.5 [get_clocks spi_clk]

# 输入/输出延迟
set_input_delay 0.5 -clock clk [get_ports ports_in/*]
set_output_delay 0.5 -clock clk [get_ports ports_out/*]

