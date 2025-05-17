//`define CONV_START_ADDR      32'h1A10_3000
//`define CONV_END_ADDR        32'h1A10_3FFF
`include "apb_bus.sv"

module apb_conv
#(
    parameter APB_ADDR_WIDTH = 12  // 4KB = 2^12
)
(
    input  logic                      HCLK,
    input  logic                      HRESETn,
    input  logic [APB_ADDR_WIDTH-1:0] PADDR,
    input  logic               [31:0] PWDATA,
    input  logic                      PWRITE,   // 1: write, 0: read
    input  logic                      PSEL,     // 1: slave selected
    input  logic                      PENABLE,
    output logic               [31:0] PRDATA,
    output logic                      PREADY,
    output logic                      PSLVERR
);

    localparam IDLE = 2'd0;
	localparam CONV = 2'd1;
	localparam READ = 2'd2;

    reg [1:0] state, next_state;

	// CONV control signals
    logic [15:0] ifm_wr_cnt; //cnt register for ifm
	logic        read_done;  //READ state finish
	
	// CONV I/O
	logic         start_conv;
	logic [  7:0] ifm;
	logic [503:0] ofm;
	logic         ofm_valid;
	
	// OFM save signals
	logic        save_done;
	logic [10:0] save_cnt;
	logic		 save_we;
	logic [ 4:0] ofm_ptr_r;
	logic [20:0] ofm_r;
	assign ofm_r = ofm[ofm_ptr_r*21+20 : ofm_ptr_r*21];
	
	// SRAM I/O
    logic [10:0] sram_addr;      // depth 2048
    logic [ 7:0] wdata0, wdata1, wdata2;
    logic [ 7:0] rdata0, rdata1, rdata2;
    logic [ 2:0] wen;
	assign wen = {save_we, save_we, save_we};
	
	// APB output
	logic [31:0] prdata_reg;
    assign PRDATA = prdata_reg;
    assign PREADY  = 1'b1;
    assign PSLVERR = 1'b0;

	//state init
    always @(posedge HCLK or negedge HRESETn) begin
        if (!HRESETn)
            state <= IDLE;
        else
            state <= next_state;
    end

	//state transition
    always @(*) begin
        next_state = state;
        case (state)
            IDLE: begin 
				if (PWRITE && PSEL && PENABLE && PADDR == 12'd0 && PWDATA == 32'd1)
                    next_state = CONV;
			end
            CONV: begin
				if (!PWRITE && save_done && PSEL && PENABLE)
					next_state = READ;
			end
        endcase
    end

    always @(posedge HCLK) begin
		if (!HRESETn) begin
			save_done  <= 1'b0;
			ifm_we	   <= 1'b0;
			save_cnt   <= 0;
			ifm_wr_cnt <= 0;
			start_conv <= 1'b0;
			prdata_reg <= 0;
			read_done  <= 1'b0;
			ofm_ptr_r  <= 0;
		end
		else begin
		    //************IDLE state************//
			if (state == IDLE) begin
				start_conv   <= 1'b1;
				read_done  <= 1'b0;
			end
			
			//************CONV state************//
			else if (state == CONV) begin
				// IFM input : 28 * 28
				start_conv <= 1'b0;
				if (PADDR >= 12'h100 && PADDR < 12'h400) begin
					if (PWRITE && ifm_wr_cnt < 784) begin
						case (PADDR[1:0])
							2'b00: ifm <= PWDATA[ 7: 0];
							2'b01: ifm <= PWDATA[15: 8];
							2'b10: ifm <= PWDATA[23:16];
							2'b11: ifm <= PWDATA[31:24];
						endcase
						ifm_wr_cnt <= ifm_wr_cnt + 1;
					end
				end
				/**********OFM SAVE**********/
				if (ofm_valid) begins
					ofm_ptr_r <= 0;
				end
				if (save_cnt < 576) begin
					save_we   <= 1'b1;
					if (ofm_ptr_r < 24)
						ofm_ptr_r <= ofm_ptr_r + 1;
					wdata0    <= ofm_r[7:0];
					wdata1    <= ofm_r[15:8];
					wdata2    <= {3'b000, ofm_r[20:16]};
					save_cnt  <= save_cnt + 1;
					save_done <= 1'b0;
				end 
				else
					save_done <= 1'b1;
			end 
			
			//************OFM READ state************//
			 else if (state == READ) begin
				save_we <= 1'b0;
				save_cnt <= 0;
				if (!PWRITE && PADDR >= 12'h000 && PADDR < 12'h004)
					prdata_reg <= 32'd1;   //data read start signal
			    //ofm size = 24*24*4 byte = 2304 = 12'h900
                else if (!PWRITE && PADDR >= 12'h004 && PADDR < 12'h904)
                    prdata_reg <= {8'd0, rdata2, rdata1, rdata0};
            end
		 end
		 
    end
	
	// SRAM read address update
	always @(*) begin
		if (state == IDLE)
			sram_addr = 0;
		else if (state == CONV) begin
			if (save_cnt < 576)
				sram_addr = save_cnt;
			else
				sram_addr = 0;
		end
		else if (state == READ && PSEL && PENABLE && !PWRITE) begin
			if (!PWRITE && PADDR >= 12'h004 && PADDR < 12'h904)
				sram_addr = PADDR[APB_ADDR_WIDTH-1:2] - 10'd1;
		end
	end

    ST_SPHDL_2048x8m8_L byte0 (
        .Q(rdata0), 
        .RY(),      
        .CK(HCLK),       
        .CSN(1'b0),    
        .TBYPASS(1'b0),
        .WEN(wen[0]),  
        .A(sram_addr), 
        .D(wdata0) 
    );

    ST_SPHDL_2048x8m8_L byte1 (
        .Q(rdata1), 
        .RY(),      
        .CK(HCLK),       
        .CSN(1'b0),    
        .TBYPASS(1'b0),
        .WEN(wen[1]),  
        .A(sram_addr), 
        .D(wdata1) 
    );
	
	ST_SPHDL_2048x8m8_L byte2 (
        .Q(rdata2), 
        .RY(),      
        .CK(HCLK),       
        .CSN(1'b0),    
        .TBYPASS(1'b0),
        .WEN(wen[2]),  
        .A(sram_addr), 
        .D(wdata2) 
    );
	
	convolution_accelerator conv_init (
        .i_clk    (HCLK),
        .i_rstn   (HRESETn), 
        .i_pixel  (ifm),
		.o_valid_ofm  (ofm_valid),
		.o_ofm    (ofm)
    );

endmodule
