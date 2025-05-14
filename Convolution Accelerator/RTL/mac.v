/*
Description: Maultiply-accumulator
Specification: input 5 rows IFM and 5 rows kernel, ouput one element OFM
*/
module mac #(
    parameter integer PX_W = 8,
    parameter integer KE_W = 5
)(
    input  wire                         i_clk,
    input  wire                         i_rstn,
    input  wire                         i_start_mac,
    input  wire [KE_W*PX_W-1:0]         i_row0, i_row1, i_row2, i_row3, i_row4, //  [39:0]
    input  wire [KE_W*PX_W-1:0]         i_ker0, i_ker1, i_ker2, i_ker3, i_ker4,

    output reg                                   o_valid_ofm,   // 1 cycle “data valid”
    output wire  [2*PX_W+$clog2(KE_W*KE_W)-1:0]  o_ofm          // [20:0]
);


    // Register 25 pixels & 25 weights when i_start_mac is asserted
    reg [PX_W-1:0] row_r [0:25-1];   // 25 regs
    reg [PX_W-1:0] ker_r [0:25-1];

    integer m, b;

    always @(posedge i_clk) begin
        if (!i_rstn) begin
            for (m = 0; m < 25; m = m + 1) begin
                row_r[m] <= {PX_W{1'b0}};
                ker_r[m] <= {PX_W{1'b0}};
            end
        end
        else if (i_start_mac) begin
            for (m = 0; m < KE_W; m = m + 1) begin
                b = m*PX_W; // b: indicates bit location of the unpacked data
                // unpack 5 IFM rows
                row_r[0*KE_W + m] <= i_row0[b +: PX_W];
                row_r[1*KE_W + m] <= i_row1[b +: PX_W];
                row_r[2*KE_W + m] <= i_row2[b +: PX_W];
                row_r[3*KE_W + m] <= i_row3[b +: PX_W];
                row_r[4*KE_W + m] <= i_row4[b +: PX_W];
                // unpack 5 kernel rows
                ker_r[0*KE_W + m] <= i_ker0[b +: PX_W];
                ker_r[1*KE_W + m] <= i_ker1[b +: PX_W];
                ker_r[2*KE_W + m] <= i_ker2[b +: PX_W];
                ker_r[3*KE_W + m] <= i_ker3[b +: PX_W];
                ker_r[4*KE_W + m] <= i_ker4[b +: PX_W];
            end
        end
    end

    // Product of two "pixels" multiplied, 25 in total, each one is 15-bit
    wire [2*PX_W-1:0] prod [0:24]; 
    // Combinational result, 21-bit
    reg  [21-1:0]  sum_c;    

    // Multiply accumulate
    genvar g;
    generate
        for (g = 0; g < 25; g = g + 1) begin : GEN_MUL
            assign prod[g] = row_r[g] * ker_r[g];
        end
    endgenerate

    integer i;
    always @(*) begin
        sum_c = {21{1'b0}};
        for (i = 0; i < 25; i = i + 1)
            sum_c = sum_c + prod[i];
    end
    
    // Register result & raise valid flag (single-cycle latency)
    always @(posedge i_clk) begin
        if (!i_rstn) begin
            o_valid_ofm <= 1'b0;
        end
        else begin
            o_valid_ofm <= i_start_mac;   // one cycle pulse
        end
    end
    
    assign o_ofm = sum_c;

endmodule
