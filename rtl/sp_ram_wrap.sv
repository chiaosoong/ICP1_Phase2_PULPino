module sp_ram_wrap
  #(
    parameter RAM_SIZE   = 32768,              // in bytes
    parameter ADDR_WIDTH = $clog2(RAM_SIZE),   // 15-bit address width for 32768 bytes
    parameter DATA_WIDTH = 32
  )(
    // Clock and Reset
    input  logic                    clk,
    input  logic                    rstn_i,
    input  logic                    en_i,
    input  logic [ADDR_WIDTH-1:0]   addr_i,
    input  logic [DATA_WIDTH-1:0]   wdata_i,
    output logic [DATA_WIDTH-1:0]   rdata_o,
    input  logic                    we_i,
    input  logic [DATA_WIDTH/8-1:0] be_i,
    input  logic                    bypass_en_i
  );
  
  logic [DATA_WIDTH/8-1:0] csn; 

  logic [3:0] wen_0;
  logic [3:0] wen_1;
  logic [3:0] wen_2;
  logic [3:0] wen_3;

  logic [7:0] wdata_00, wdata_01, wdata_02, wdata_03;
  logic [7:0] wdata_10, wdata_11, wdata_12, wdata_13;
  logic [7:0] wdata_20, wdata_21, wdata_22, wdata_23;
  logic [7:0] wdata_30, wdata_31, wdata_32, wdata_33;
  logic [DATA_WIDTH-1:0] wdata_r;
		 
  logic [7:0] rdata_00, rdata_01, rdata_02, rdata_03;
  logic [7:0] rdata_10, rdata_11, rdata_12, rdata_13;
  logic [7:0] rdata_20, rdata_21, rdata_22, rdata_23;
  logic [7:0] rdata_30, rdata_31, rdata_32, rdata_33;

  logic [1:0] bank_sel;    
  assign bank_sel = addr_i [ADDR_WIDTH-1:ADDR_WIDTH-2]; // The upper two bits are used as the SRAM bank selection signal
  logic [1:0] bank_sel_read; 
	
  logic [ADDR_WIDTH-5:0] addr;
  assign addr = addr_i [ADDR_WIDTH-3:2];                // The middle 11 bits are used as the address signal for each SRAM, 
							// and the lower 2 bits are used as the byte selection signal for each bank

  
  // Instantiate SRAM chips for Bank 0:
    ST_SPHDL_2048x8m8_L bank0_byte0 (
        .Q(rdata_00), 
        .RY(),      
        .CK(clk),       
        .CSN(csn[0]),    
        .TBYPASS(1'b0),
        .WEN(wen_0[0]),  
        .A(addr), 
        .D(wdata_00) 
    );

    ST_SPHDL_2048x8m8_L bank0_byte1 (
        .Q(rdata_01), 
        .RY(),      
        .CK(clk),       
        .CSN(csn[0]),    
        .TBYPASS(1'b0),
        .WEN(wen_0[1]),  
        .A(addr), 
        .D(wdata_01) 
    );
	
	ST_SPHDL_2048x8m8_L bank0_byte2 (
        .Q(rdata_02), 
        .RY(),      
        .CK(clk),       
        .CSN(csn[0]),    
        .TBYPASS(1'b0),
        .WEN(wen_0[2]),  
        .A(addr), 
        .D(wdata_02) 
    );
	
	ST_SPHDL_2048x8m8_L bank0_byte3 (
        .Q(rdata_03), 
        .RY(),      
        .CK(clk),       
        .CSN(csn[0]),    
        .TBYPASS(1'b0),
        .WEN(wen_0[3]),  
        .A(addr), 
        .D(wdata_03) 
    );
	
	 // Instantiate SRAM chips for Bank 1:
    ST_SPHDL_2048x8m8_L bank1_byte0 (
        .Q(rdata_10), 
        .RY(),      
        .CK(clk),       
        .CSN(csn[1]),    
        .TBYPASS(1'b0),
        .WEN(wen_1[0]),  
        .A(addr), 
        .D(wdata_10) 
    );

    ST_SPHDL_2048x8m8_L bank1_byte1 (
        .Q(rdata_11), 
        .RY(),      
        .CK(clk),       
        .CSN(csn[1]),    
        .TBYPASS(1'b0),
        .WEN(wen_1[1]),  
        .A(addr), 
        .D(wdata_11) 
    );
	
	ST_SPHDL_2048x8m8_L bank1_byte2 (
        .Q(rdata_12), 
        .RY(),      
        .CK(clk),       
        .CSN(csn[1]),    
        .TBYPASS(1'b0),
        .WEN(wen_1[2]),  
        .A(addr), 
        .D(wdata_12) 
    );
	
	ST_SPHDL_2048x8m8_L bank1_byte3 (
        .Q(rdata_13), 
        .RY(),      
        .CK(clk),       
        .CSN(csn[1]),    
        .TBYPASS(1'b0),
        .WEN(wen_1[3]),  
        .A(addr), 
        .D(wdata_13) 
    );
	
	 // Instantiate SRAM chips for Bank 2:
    ST_SPHDL_2048x8m8_L bank2_byte0 (
        .Q(rdata_20), 
        .RY(),      
        .CK(clk),       
        .CSN(csn[2]),    
        .TBYPASS(1'b0),
        .WEN(wen_2[0]),  
        .A(addr), 
        .D(wdata_20) 
    );

    ST_SPHDL_2048x8m8_L bank2_byte1 (
        .Q(rdata_21), 
        .RY(),      
        .CK(clk),       
        .CSN(csn[2]),    
        .TBYPASS(1'b0),
        .WEN(wen_2[1]),  
        .A(addr), 
        .D(wdata_21) 
    );
	
	ST_SPHDL_2048x8m8_L bank2_byte2 (
        .Q(rdata_22), 
        .RY(),      
        .CK(clk),       
        .CSN(csn[2]),    
        .TBYPASS(1'b0),
        .WEN(wen_2[2]),  
        .A(addr), 
        .D(wdata_22) 
    );
	
	ST_SPHDL_2048x8m8_L bank2_byte3 (
        .Q(rdata_23), 
        .RY(),      
        .CK(clk),       
        .CSN(csn[2]),    
        .TBYPASS(1'b0),
        .WEN(wen_2[3]),  
        .A(addr), 
        .D(wdata_23) 
    );
	
	 // Instantiate SRAM chips for Bank 3:
    ST_SPHDL_2048x8m8_L bank3_byte0 (
        .Q(rdata_30), 
        .RY(),      
        .CK(clk),       
        .CSN(csn[3]),    
        .TBYPASS(1'b0),
        .WEN(wen_3[0]),  
        .A(addr), 
        .D(wdata_30) 
    );

    ST_SPHDL_2048x8m8_L bank3_byte1 (
        .Q(rdata_31), 
        .RY(),      
        .CK(clk),       
        .CSN(csn[3]),    
        .TBYPASS(1'b0),
        .WEN(wen_3[1]),  
        .A(addr), 
        .D(wdata_31) 
    );
	
	ST_SPHDL_2048x8m8_L bank3_byte2 (
        .Q(rdata_32), 
        .RY(),      
        .CK(clk),       
        .CSN(csn[3]),    
        .TBYPASS(1'b0),
        .WEN(wen_3[2]),  
        .A(addr), 
        .D(wdata_32) 
    );
	
	ST_SPHDL_2048x8m8_L bank3_byte3 (
        .Q(rdata_33), 
        .RY(),      
        .CK(clk),       
        .CSN(csn[3]),    
        .TBYPASS(1'b0),
        .WEN(wen_3[3]),  
        .A(addr), 
        .D(wdata_33) 
    );

	always @(posedge clk) begin
		if (!rstn_i) begin
        		bank_sel_read <= 0;
    		end 
		else begin
        		bank_sel_read <= bank_sel; // The upper two bits are used as the SRAM bank selection signal
    		end
	end

	 always @(*) begin
		wdata_00 = 0;  wdata_01 = 0;  wdata_02 = 0;  wdata_03 = 0;
		wdata_10 = 0;  wdata_11 = 0;  wdata_12 = 0;  wdata_13 = 0;
		wdata_20 = 0;  wdata_21 = 0;  wdata_22 = 0;  wdata_23 = 0;
		wdata_30 = 0;  wdata_31 = 0;  wdata_32 = 0;  wdata_33 = 0;
		rdata_o = 0;
		wen_0 = 4'b1111; wen_1 = 4'b1111; wen_2 = 4'b1111; wen_3 = 4'b1111;

        	if(!rstn_i) begin			
			wdata_00 = 8'd0;  wdata_01 = 8'd0;  wdata_02 = 8'd0;  wdata_03 = 8'd0;
			wdata_10 = 8'd0;  wdata_11 = 8'd0;  wdata_12 = 8'd0;  wdata_13 = 8'd0;
			wdata_20 = 8'd0;  wdata_21 = 8'd0;  wdata_22 = 8'd0;  wdata_23 = 8'd0;
			wdata_30 = 8'd0;  wdata_31 = 8'd0;  wdata_32 = 8'd0;  wdata_33 = 8'd0;
			rdata_o = 32'd0;
			wen_0 = 4'b1111; wen_1 = 4'b1111; wen_2 = 4'b1111; wen_3 = 4'b1111;
        	end 
		else if(we_i && en_i) begin
			case (bank_sel)
				2'b00: begin
					if (be_i[0]) begin
						wen_0[0] = 1'b0;
						wdata_00 = wdata_i[ 7: 0];
					end
					if (be_i[1]) begin
						wen_0[1] = 1'b0;	
						wdata_01 = wdata_i[15: 8];
					end
					if (be_i[2]) begin
						wen_0[2] = 1'b0;
						wdata_02 = wdata_i[23:16];
					end
					if (be_i[3]) begin
						wen_0[3] = 1'b0;
						wdata_03 = wdata_i[31:24];
					end
				end
				
				2'b01: begin
					if (be_i[0]) begin
						wen_1[0] = 1'b0;
						wdata_10 = wdata_i[ 7: 0];
					end
					if (be_i[1]) begin
						wen_1[1] = 1'b0;	
						wdata_11 = wdata_i[15: 8];
					end
					if (be_i[2]) begin
						wen_1[2] = 1'b0;
						wdata_12 = wdata_i[23:16];
					end
					if (be_i[3]) begin
						wen_1[3] = 1'b0;
						wdata_13 = wdata_i[31:24];
					end
				end
				
				2'b10: begin
					if (be_i[0]) begin
						wen_2[0] = 1'b0;
						wdata_20 = wdata_i[ 7: 0];
					end
					if (be_i[1]) begin
						wen_2[1] = 1'b0;	
						wdata_21 = wdata_i[15: 8];
					end
					if (be_i[2]) begin
						wen_2[2] = 1'b0;
						wdata_22 = wdata_i[23:16];
					end
					if (be_i[3]) begin
						wen_2[3] = 1'b0;
						wdata_23 = wdata_i[31:24];
					end
				end
				
				2'b11: begin
					if (be_i[0]) begin
						wen_3[0] = 1'b0;
						wdata_30 = wdata_i[ 7: 0];
					end
					if (be_i[1]) begin
						wen_3[1] = 1'b0;	
						wdata_31 = wdata_i[15: 8];
					end
					if (be_i[2]) begin
						wen_3[2] = 1'b0;
						wdata_32 = wdata_i[23:16];
					end
					if (be_i[3]) begin
						wen_3[3] = 1'b0;
						wdata_33 = wdata_i[31:24];
					end
				end
				
				default: begin
					wdata_00 = wdata_00;  wdata_01 = wdata_01;  wdata_02 = wdata_02;  wdata_03 = wdata_03;
					wdata_10 = wdata_10;  wdata_11 = wdata_11;  wdata_12 = wdata_12;  wdata_13 = wdata_13;
					wdata_20 = wdata_20;  wdata_21 = wdata_21;  wdata_22 = wdata_22;  wdata_23 = wdata_23;
					wdata_30 = wdata_30;  wdata_31 = wdata_31;  wdata_32 = wdata_32;  wdata_33 = wdata_33;
				end
			endcase
        	end
        	else begin
	    	wen_0 = 4'b1111; wen_1 = 4'b1111; wen_2 = 4'b1111; wen_3 = 4'b1111;
            	case (bank_sel_read)
			2'b00: rdata_o = {rdata_03, rdata_02, rdata_01, rdata_00};
			2'b01: rdata_o = {rdata_13, rdata_12, rdata_11, rdata_10};
			2'b10: rdata_o = {rdata_23, rdata_22, rdata_21, rdata_20};
			2'b11: rdata_o = {rdata_33, rdata_32, rdata_31, rdata_30};
			default: rdata_o = rdata_o;
	   	 endcase
        	end
    	end
	
	always @(*) begin
		csn = 4'b1111;
		wdata_r = wdata_i;
		if (!rstn_i) begin
			csn = 4'b1111;
			wdata_r = 0;
		end
		else begin
			if (we_i && en_i)
				wdata_r = wdata_i;
			else if (en_i)
				wdata_r = wdata_i;
			else
				wdata_r = wdata_r;
			
			if (we_i && en_i) begin
				case (bank_sel)
					2'b00: begin
						csn = 4'b1110;
					end
					2'b01: begin 
						csn = 4'b1101;
					end
					2'b10: begin
						csn = 4'b1011;
					end
					2'b11: begin
						csn = 4'b0111;
					end
					default: begin
						csn = 4'b1111;
					end
				endcase
			end
			else begin
				csn = 4'b0000;
			end
		end
	end
	
  endmodule
