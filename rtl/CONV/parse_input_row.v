// Parse a row of pixel input, one input per clock cycle
module parse_input_row
#(
    parameter PX_W  = 8,     // Input pixel data width
    parameter IFM_W = 28     // IFM size
)
(
    input       [PX_W-1:0]      i_pixel,
    input                       i_clk,
    input                       i_rstn,
    
    output reg                  o_valid_row,
    output     [PX_W*IFM_W-1:0] o_row
);
    reg valid_next;
    reg [$clog2(IFM_W)-1:0] cnt;    //28 pixels every row
    reg [$clog2(IFM_W)-1:0] cnt_next;

    reg [PX_W*IFM_W-1:0] row;
    reg [PX_W*IFM_W-1:0] row_next;
    
    always@(posedge i_clk) begin
        if (!i_rstn) begin
            cnt         <= 0;
            o_valid_row <= 1'b0;
            row         <= 0;
        end
        else begin
            cnt         <= cnt_next;
            row         <= row_next;
            o_valid_row <= valid_next;
        end
    end

    always@(*) begin
        cnt_next   = cnt;
        valid_next = 1'b0;
        row_next   = {row[PX_W*IFM_W-5:0], i_pixel};   // left shift to parse one pixel in
        if (cnt == 5'h1C) begin // 28 pixels per row
            cnt_next = 5'h1;
            valid_next = 1'b1;
        end
        else
            cnt_next = cnt + 1;
    end

    assign o_row = row;

endmodule