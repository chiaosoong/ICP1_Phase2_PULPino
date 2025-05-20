`include "apb_bus.sv"

module apb_conv #(
    parameter APB_ADDR_WIDTH = 12  // 4 KB = 2^12
)(
    input  logic                      HCLK,
    input  logic                      HRESETn,
    // APB bus interface signals
    input  logic [APB_ADDR_WIDTH-1:0] PADDR,
    input  logic               [31:0] PWDATA,
    input  logic                      PWRITE,   // 1: write operation, 0: read operation
    input  logic                      PSEL,     // 1: slave selected
    input  logic                      PENABLE,  // APB enable signal
    output logic               [31:0] PRDATA,
    output logic                      PREADY,
    output logic                      PSLVERR
);

    // ----------------------------------------------------------------
    // State machine definition
    // ----------------------------------------------------------------
    typedef enum logic [1:0] {
        IDLE = 2'd0,
        LOAD = 2'd1,
        CONV = 2'd2,
        READ = 2'd3
    } state_e;

    state_e state, next_state;

    // ----------------------------------------------------------------
    // IFM (Input Feature Map) storage
    // ----------------------------------------------------------------
    localparam IFM_PIXELS = 28 * 28;
    logic [10:0] ifm_ptr;                 // Index 0..783 into ifm_r
    logic [7:0]  ifm_r [0:IFM_PIXELS-1];  // 784-byte buffer for IFM
    logic        load_done;               // Flag: all IFM data has been loaded
    logic        ifm_input_done;          // Flag: all IFM pixels have been sent to convolution core
    logic [7:0]  ifm;                     // Single pixel delivered to convolution core

    // ----------------------------------------------------------------
    // OFM (Output Feature Map) storage
    // ----------------------------------------------------------------
    // The convolution core outputs 24×24 lines, each 21 bits
    logic [503:0] ofm_buffer;     
    logic         ofm_valid;      // Flag from conv core: output is valid
    logic [503:0] ofm;            // One output from conv core: 24×21 = 504 bits
    logic [4:0]   ofm_ptr_r;      // Index 0..23 into ofm_buffer’s rows (each 21 bits)
    logic [20:0]  ofm_r;          // Single 21 bit slice from ofm_buffer for writing to SRAM
    logic         save_start;     // When high, start writing ofm_buffer to SRAM
    logic [10:0]  save_cnt;       // Count of OFM pixels written so far (0..576)
    logic         save_done;      // True when all 576 OFM pixels have been stored
    logic         save_we;        // Write-enable to SRAM (applied equally to all 3 bytes)

    // ----------------------------------------------------------------
    // SRAM read/write interface
    // ----------------------------------------------------------------
    // SRAM depth = 2048, 3 bytes wide
    logic [10:0] sram_addr;
    logic [7:0]  wdata0, wdata1, wdata2; 
    logic [7:0]  rdata0, rdata1, rdata2;
    logic [2:0]  wen;
    assign wen = {save_we, save_we, save_we};

    // ----------------------------------------------------------------
    // APB read control signals
    // ----------------------------------------------------------------
    logic         ofm_read;    // When high, indicates an OFM read request via APB

    logic         PREADY_rst;
    logic         conv_rstn;   // Active‐low reset to convolution core
    assign PSLVERR = 1'b0;

    always_ff @(posedge HCLK or negedge HRESETn) begin
        if (!HRESETn) begin
            state            <= IDLE;
            ifm_ptr          <= 11'd0;
            load_done        <= 1'b0;
            ifm_input_done   <= 1'b0;
            save_start       <= 1'b0;
            save_cnt         <= 11'd0;
            ofm_ptr_r        <= 5'd0;
            save_done        <= 1'b0;
            ofm_buffer       <= {504{1'b0}};
            ofm_read         <= 1'b0;
            PREADY_rst       <= 1'b0;
        end
        else begin
            state <= next_state;

            // --- LOAD state: write incoming APB data into ifm_r buffer ---
            if (state == LOAD) begin
                if (PSEL && PENABLE && PWRITE && (PADDR >= 12'h100) && (PADDR <= 12'h40F)) 
                begin
                    case (PADDR[1:0])
                        2'b00: ifm_r[ifm_ptr] <= PWDATA[ 7: 0];
                        2'b01: ifm_r[ifm_ptr] <= PWDATA[15: 8];
                        2'b10: ifm_r[ifm_ptr] <= PWDATA[23:16];
                        2'b11: ifm_r[ifm_ptr] <= PWDATA[31:24];
                    endcase
                    if (ifm_ptr < IFM_PIXELS-1) begin
                        ifm_ptr <= ifm_ptr + 11'd1;
                    end
                    else begin
                        ifm_ptr   <= 11'd0;
                        load_done <= 1'b1;
                    end
                end
            end

            // --- CONV state: send IFM pixels into convolution core, store OFM in SRAM ---
            else if (state == CONV) begin
                if (!ifm_input_done) begin
                    if (ifm_ptr < IFM_PIXELS) begin
                        ifm       <= ifm_r[ifm_ptr];
                        ifm_ptr   <= ifm_ptr + 11'd1;
                    end else begin
                        // After sending the last pixel, mark IFM input done
                        ifm_ptr        <= 11'd0;
                        ifm_input_done <= 1'b1;
                    end
                end
                // When convolution core asserts ofm_valid, latch the entire 504 bit output
                if (ofm_valid) begin
                    ofm_buffer <= ofm;
                    ofm_ptr_r  <= 5'd0;
                    save_start <= 1'b1;
                end
                // If 576 pixels have been saved, assert save_done
                if (save_cnt == 11'd576) begin
                    save_done <= 1'b1;
                end
                else if (save_start) begin
                    // While saving, iterate through 24 rows in ofm_buffer
                    if (ofm_ptr_r < 5'd23) begin
                        ofm_ptr_r <= ofm_ptr_r + 5'd1;
                    end else begin
                        ofm_ptr_r <= 5'd0;
                        save_start <= 1'b0;
                    end

                    if (save_cnt < 11'd576) begin
                        save_cnt <= save_cnt + 11'd1;
                    end
                end
            end

            // --- READ state: handle APB read requests for OFM data ---
            else if (state == READ) begin
                if (PSEL && PENABLE && (PADDR >= 12'h008) && (PADDR < 12'h908)) begin
                    ofm_read <= 1'b1;
                end else begin
                    ofm_read <= 1'b0;
                end

                if (PSEL && PENABLE) begin
                    PREADY_rst <= 1'b1;
                end else begin
                    PREADY_rst <= 1'b0;
                end
            end

        end
    end

    // ----------------------------------------------------------------
    // Compute next_state based on current state and inputs
    // ----------------------------------------------------------------
    always_comb begin
        next_state = state;
        case (state)
            IDLE: begin
                // On APB write to address 0 with data=1, move from IDLE → LOAD
                if (PSEL && PENABLE && PWRITE && (PADDR == 12'd0) && (PWDATA == 32'd1)) 
                begin
                    next_state = LOAD;
                end
            end

            LOAD: begin
                // When IFM buffer is fully loaded, transition from LOAD → CONV
                if (load_done) begin
                    next_state = CONV;
                end
            end

            CONV: begin
                // After convolution completes (save_done=1) move from CONV → READ
                if (!PWRITE && save_done && PSEL && PENABLE) begin
                    next_state = READ;
                end
            end

        endcase
    end


    always_comb begin
        PREADY     = 1'b1;
        sram_addr  = 11'd0;
        save_we    = 1'b0;
        wdata0     = 8'd0;
        wdata1     = 8'd0;
        wdata2     = 8'd0;
        ofm_r      = 21'd0;
        PRDATA     = 32'd0;
	conv_rstn  = 1'b0;

        case (state)
            CONV: begin
                // While saving OFM into SRAM, enable writes
                save_we = !save_start;

		// --- Always update conv_rstn: only high (released) in CONV state ---
		conv_rstn = 1'b1;

                if (save_start && (save_cnt < 11'd576)) begin
                    // Extract the current 21 bits from ofm_buffer
                    ofm_r     = ofm_buffer[ ofm_ptr_r * 21 +: 21 ];
                    sram_addr = save_cnt;
                    // Split 21 bits into three bytes
                    wdata0    = ofm_r[ 7: 0];
                    wdata1    = ofm_r[15: 8];
                    wdata2    = {3'b000, ofm_r[20:16]};
                end else begin
                    sram_addr = 11'd0;
                end
                // In CONV state, always report PREADY=1
                PREADY = 1'b1;
            end

            READ: begin
                //Hold PREADY low for one cycle (read data from sram has 1 cycle delay) 
                if (PREADY_rst == 1'b0) begin
                    PREADY = !(PSEL && PENABLE);
                end else begin
                    PREADY = 1'b1;
                end

                save_we = 1'b1;

                // Compute address in SRAM based on PADDR
                if (PSEL && PENABLE) begin
                    sram_addr = PADDR[APB_ADDR_WIDTH-1:2] - 10'd2;
                end

                // Return a “data ready” flag to C program
                if ((PADDR >= 12'h004) && (PADDR < 12'h008)) begin
                    PRDATA = 32'd1;
                end

                if (ofm_read) begin
                    PRDATA = {8'd0, rdata2, rdata1, rdata0};
                end
            end

	    default: begin
		save_we = 1'b1;
	    end
        endcase
    end

    ST_SPHDL_2048x8m8_L byte0 (
        .Q   (rdata0),
        .RY  (),
        .CK  (HCLK),
        .CSN (1'b0),
        .TBYPASS (1'b0),
        .WEN (wen[0]),
        .A   (sram_addr),
        .D   (wdata0)
    );

    ST_SPHDL_2048x8m8_L byte1 (
        .Q   (rdata1),
        .RY  (),
        .CK  (HCLK),
        .CSN (1'b0),
        .TBYPASS (1'b0),
        .WEN (wen[1]),
        .A   (sram_addr),
        .D   (wdata1)
    );

    ST_SPHDL_2048x8m8_L byte2 (
        .Q   (rdata2),
        .RY  (),
        .CK  (HCLK),
        .CSN (1'b0),
        .TBYPASS (1'b0),
        .WEN (wen[2]),
        .A   (sram_addr),
        .D   (wdata2)
    );

    convolution_accelerator conv_init (
        .i_clk       (HCLK),
        .i_rstn      (conv_rstn),
        .i_pixel     (ifm),
        .o_valid_ofm (ofm_valid),
        .o_ofm       (ofm)
    );

endmodule

