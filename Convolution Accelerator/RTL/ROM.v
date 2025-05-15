/*
Description: A ROM that stores kernel coefficients
Specification: 5*5 kernel; stored in 5 lines, each line 40 bit
*/
module ROM#(
    parameter PX_W = 8,   // kernel coefficient data width
    parameter KE_W = 5    // Kernel size: 5×5
)(
        input [$clog2(KE_W)-1:0]   i_addr,
        output reg [PX_W*KE_W-1:0] o_data
    );

    always@(*)
    begin
        o_data = {40{1'b0}};
        case (i_addr)
            // All coeffcient is 255
            3'b000: o_data = {40{1'b1}};
            3'b001: o_data = {40{1'b1}};
            3'b010: o_data = {40{1'b1}};
            3'b011: o_data = {40{1'b1}};
            3'b100: o_data = {40{1'b1}};
            default: o_data = {40{1'b0}};
        endcase
    end

        
endmodule
