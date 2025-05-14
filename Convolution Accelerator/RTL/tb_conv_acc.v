`timescale 1ns / 1ps
module tb_conv_acc #(
    parameter PX_W = 8,   // Input pixel data width
    parameter IFM_W = 28, // IFM size
    parameter KE_W = 5    // Kernel coefficient size: 5×5
)();

reg i_clk;
reg i_rstn;
reg [PX_W-1:0] i_pixel;
wire o_valid_ofm;
wire [(2*PX_W+$clog2(KE_W*KE_W))*(IFM_W-KE_W+1)-1:0] o_ofm;

reg 		[7:0] memory [0:IFM_W*IFM_W-1];
integer n;
convolution_accelerator i_conv_acc(
                        .i_clk(i_clk),
                        .i_rstn(i_rstn),
                        .i_pixel(i_pixel),
              
                        .o_ofm(o_ofm),
                        .o_valid_ofm(o_valid_ofm));

//Clock period = 10 ns 
localparam CLK_PERIOD_HALF     = 5; 
//-----------------------------------------------------
//forever #CLK_PERIOD_HALF clk <= ~clk;
initial begin
   i_clk = 1;
   //#1;
   forever begin
      #CLK_PERIOD_HALF;
      i_clk = ~i_clk;
   end
end
///////////////////////////////
initial begin
#50;
i_rstn = 1'b0;
#150; 
i_rstn = 1'b1;
//INPUT FILE
	$readmemb("IFM.txt", memory);	
	for(n=0;n<IFM_W*IFM_W;n=n+1)	begin
		@(posedge	i_clk);
		i_pixel  =	memory[n];
	end
end
endmodule