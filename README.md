# RTL
## SRAM
1. instruction ram和data ram共用sp_ram 
2. 添加SRAM编译：
   - `pulpino/vsim/vcompile/rtl/vcompile_pulpino.sh`：
   - `vlog -quiet     -work ${LIB_PATH} ${RTL_PATH}/components/SPHDL100909.v              || goto error`
3. my_first_script：
   - 通过SPI调试SRAM
   - `make "${PROJECT_NAME}.vsim"` --->  `make "${PROJECT_NAME}.vsim.spi"`
4. tb.sv：
   `include "tb_mem_pkg.sv` ---> `//include "tb_mem_pkg.sv"`
6. 查看SRAM输入数据：
   - `pulpino/sw/build/apps/helloworld/slm_files/spi_stim.txt`
7. SPI测试文件:
   - `/pulpino/tb/tb_spi_pkg.sv `
   - 查看出错地址：
     `$display("%t: [SPI] Readback has failed, expected %X, got %X", $time, spi_data, spi_data_recv);`
     --->  `$display("%t: [SPI] Readback has failed, expected %X, got %X, at address %X", $time, spi_data, spi_data_recv, spi_addr);`

## PADS
1. 去除I2C，GPIO，SPI Master
2. GPIO保留gpio_out[8]，防止tb.sv滞留
   ```System Verilog
   // end of computation
    if (~gpio_out[8])
      wait(gpio_out[8]);
   ```
