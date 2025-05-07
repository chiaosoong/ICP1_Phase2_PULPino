`timescale 1ns/1ps

module pulpino_padstop (
    // Top-level external pins
    input         clk,          
    input         rst_n,        
       
    //input         testmode_i,
    input         fetch_enable_i,
	
    // SPI Slave Signals
    input         spi_clk_i,
    input         spi_cs_i,
    output [1:0]  spi_mode_o,
    output        spi_sdo0_o,
    output        spi_sdo1_o,
    output        spi_sdo2_o,
    output        spi_sdo3_o,
    input         spi_sdi0_i,
    input         spi_sdi1_i,
    input         spi_sdi2_i,
    input         spi_sdi3_i,
	
    // UART signals
    output        uart_tx,
    input         uart_rx,
    output        uart_rts,
    output        uart_dtr,
    //input         uart_cts,
    //input         uart_dsr,

    // GPIO signals
    output        gpio_out,
	
    // JTAG signals
    input         tck_i,
    input         trstn_i,
    input         tms_i,
    input         tdi_i,
    output        tdo_o

);

  // Internal signals from pads to the core
  wire clk_internal;
  wire rst_n_internal;
  //wire testmode_internal;
  wire fetch_enable_internal;

  wire spi_clk_internal;
  wire spi_cs_internal;
  wire [1:0] spi_mode_internal;
  wire spi_sdo0_internal;
  wire spi_sdo1_internal;
  wire spi_sdo2_internal;
  wire spi_sdo3_internal;
  wire spi_sdi0_internal;
  wire spi_sdi1_internal;
  wire spi_sdi2_internal;
  wire spi_sdi3_internal;
  
  wire uart_tx_internal;
  wire uart_rx_internal;
  wire uart_rts_internal;
  wire uart_dtr_internal;
  wire uart_cts_internal;
  wire uart_dsr_internal;
  
  wire gpio_out_internal;
  
  wire tck_internal;
  wire trstn_internal;
  wire tms_internal;
  wire tdi_internal;
  wire tdo_internal;
  


  //**********Input PADs Instantiate**********//

  
  CPAD_S_74x50u_IN clk_pad (
      .COREIO(clk_internal),
      .PADIO(clk)
  );
  
  CPAD_S_74x50u_IN rst_pad (
      .COREIO(rst_n_internal),
      .PADIO(rst_n)
  );
  
/*
  CPAD_S_74x50u_IN testmode_pad (
      .COREIO(testmode_internal),
      .PADIO(testmode_i)
  );*/
  
  CPAD_S_74x50u_IN fetch_en_pad (
      .COREIO(fetch_enable_internal),
      .PADIO(fetch_enable_i)
  );
  
  
  CPAD_S_74x50u_IN spi_clk_pad (
      .COREIO(spi_clk_internal),
      .PADIO(spi_clk_i)
  );
  
  CPAD_S_74x50u_IN spi_cs_pad (
      .COREIO(spi_cs_internal),
      .PADIO(spi_cs_i)
  );
  
  CPAD_S_74x50u_IN spi_sdi0_pad (
      .COREIO(spi_sdi0_internal),
      .PADIO(spi_sdi0_i)
  );
  
  CPAD_S_74x50u_IN spi_sdi1_pad (
      .COREIO(spi_sdi1_internal),
      .PADIO(spi_sdi1_i)
  );
  
  CPAD_S_74x50u_IN spi_sdi2_pad (
      .COREIO(spi_sdi2_internal),
      .PADIO(spi_sdi2_i)
  );
  
  CPAD_S_74x50u_IN spi_sdi3_pad (
      .COREIO(spi_sdi3_internal),
      .PADIO(spi_sdi3_i)
  );
  
  CPAD_S_74x50u_IN uart_rx_pad (
      .COREIO(uart_rx_internal),
      .PADIO(uart_rx)
  );
  
/*
  CPAD_S_74x50u_IN uart_cts_pad (
      .COREIO(uart_cts_internal),
      .PADIO(uart_cts)
  );
  
  CPAD_S_74x50u_IN uart_dsr_pad (
      .COREIO(uart_dsr_internal),
      .PADIO(uart_dsr)
  );
*/
  CPAD_S_74x50u_IN tck_pad (
      .COREIO(tck_internal),
      .PADIO(tck_i)
  );
  
  CPAD_S_74x50u_IN trstn_pad (
      .COREIO(trstn_internal),
      .PADIO(trstn_i)
  );
  
  CPAD_S_74x50u_IN tms_pad (
      .COREIO(tms_internal),
      .PADIO(tms_i)
  );
  
  CPAD_S_74x50u_IN tdi_pad (
      .COREIO(tdi_internal),
      .PADIO(tdi_i)
  );
  
  //**********Output PADs Instantiate**********//
  
  CPAD_S_74x50u_OUT spi_mode_pad0 (
      .COREIO(spi_mode_internal[0]),
      .PADIO(spi_mode_o[0])
  );
  
  CPAD_S_74x50u_OUT spi_mode_pad1 (
      .COREIO(spi_mode_internal[1]),
      .PADIO(spi_mode_o[1])
  );
  
  CPAD_S_74x50u_OUT spi_sdo0_pad (
      .COREIO(spi_sdo0_internal),
      .PADIO(spi_sdo0_o)
  );
  
  CPAD_S_74x50u_OUT spi_sdo1_pad (
      .COREIO(spi_sdo1_internal),
      .PADIO(spi_sdo1_o)
  );
  
  CPAD_S_74x50u_OUT spi_sdo2_pad (
      .COREIO(spi_sdo2_internal),
      .PADIO(spi_sdo2_o)
  );
  
  CPAD_S_74x50u_OUT spi_sdo3_pad (
      .COREIO(spi_sdo3_internal),
      .PADIO(spi_sdo3_o)
  );
  
  CPAD_S_74x50u_OUT uart_tx_pad (
      .COREIO(uart_tx_internal),
      .PADIO(uart_tx)
  );
  
  CPAD_S_74x50u_OUT uart_rts_pad (
      .COREIO(uart_rts_internal),
      .PADIO(uart_rts)
  );
  
  CPAD_S_74x50u_OUT uart_dtr_pad (
      .COREIO(uart_dtr_internal),
      .PADIO(uart_dtr)
  );
  
  CPAD_S_74x50u_OUT tdo_pad (
      .COREIO(tdo_internal),
      .PADIO(tdo_o)
  );
  
   CPAD_S_74x50u_OUT gpio_out_pad (
     .COREIO(gpio_out_internal),
     .PADIO(gpio_out)
  );

  //*********pulpino_top Instantiate*********//

  
  pulpino_top pulpino_top_i (
    // Clock and Reset
    .clk             ( clk_internal ),
    .rst_n           ( rst_n_internal ),

    //.testmode_i      ( testmode_internal ),
    .fetch_enable_i  ( fetch_enable_internal ),

    // SPI Slave Signals
    .spi_clk_i       ( spi_clk_internal ),
    .spi_cs_i        ( spi_cs_internal ),
    .spi_mode_o      ( spi_mode_internal ),
    .spi_sdo0_o      ( spi_sdo0_internal ),
    .spi_sdo1_o      ( spi_sdo1_internal ),
    .spi_sdo2_o      ( spi_sdo2_internal ),
    .spi_sdo3_o      ( spi_sdo3_internal ),
    .spi_sdi0_i      ( spi_sdi0_internal ),
    .spi_sdi1_i      ( spi_sdi1_internal ),
    .spi_sdi2_i      ( spi_sdi2_internal ),
    .spi_sdi3_i      ( spi_sdi3_internal ),

    // UART Signals
    .uart_tx         ( uart_tx_internal ),
    .uart_rx         ( uart_rx_internal ),
    .uart_rts        ( uart_rts_internal ),
    .uart_dtr        ( uart_dtr_internal ),
    //.uart_cts        ( uart_cts_internal ),
    //.uart_dsr        ( uart_dsr_internal ),

    // GPIO Signals
    .gpio_out        ( gpio_out_internal ),
	
    // JTAG Signals
    .tck_i           ( tck_internal ),
    .trstn_i         ( trstn_internal ),
    .tms_i           ( tms_internal ),
    .tdi_i           ( tdi_internal ),
    .tdo_o           ( tdo_internal )
  );
  
endmodule
