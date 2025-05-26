/*
Description: 2-D 5*5 convolutuion accelerator, no padding, stride = 1
Specification: 1) 28*28 IFM and each pixel is 8-bit unsigned decimal; Input one pixel per clock cycle
               2) 5*5 kernel; read 5 lines of kernel from SRAM
               3) ouput: one line of OFM [24*21-1:0] = [503:0], i.e. 24 OFM pixels
*/
module convolution_accelerator #(
    parameter PX_W = 8,   // Input pixel data width
    parameter IFM_W = 28, // IFM size
    parameter KE_W = 5    // Kernel coefficient size: 5×5
)
(
    input  [PX_W-1:0]      i_pixel,
    input                  i_clk,
    input                  i_rstn,


    output [(2*PX_W+$clog2(KE_W*KE_W))*(IFM_W-KE_W+1)-1:0] o_ofm,        // [503:0]
    output reg                                             o_valid_ofm
);

///////////////////////////////READ KERNEL COEFFICIENTS///////////////////////////////
    reg  [KE_W*PX_W-1:0]      ker0, ker1, ker2, ker3, ker4; // five rows of kernel 5*5
    reg  [KE_W*PX_W-1:0]      reg_ker0,reg_ker1,reg_ker2,reg_ker3,reg_ker4;
    wire [KE_W*PX_W-1:0]      ker_row;
    reg  [$clog2(KE_W)-1:0]   addr;
    reg  [$clog2(KE_W)-1:0]   addr_next;
    // Read kernel coefficients from ROM
    always@(posedge i_clk) begin
        if (!i_rstn) begin
            addr <= 3'b000;
            ker0 <= 0;
            ker1 <= 0;
            ker2 <= 0;
            ker3 <= 0;
            ker4 <= 0;
        end
        else begin
            addr <= addr_next;
            ker0 <= reg_ker0;
            ker1 <= reg_ker1;
            ker2 <= reg_ker2;
            ker3 <= reg_ker3;
            ker4 <= reg_ker4;
        end
    end

    always@(*) begin
        if (addr == 3'b100)
            addr_next = 3'b000;
        else
            addr_next = addr + 3'b001;
    end

    ROM inst_rom(
        .i_addr(addr),
        .o_data(ker_row)
    );

    always@(posedge i_clk) begin
        if (!i_rstn) 
            {reg_ker0, reg_ker1, reg_ker2, reg_ker3, reg_ker4} = 0;
        else begin
            case (addr)
            3'b000: reg_ker0 = ker_row;
            3'b001: reg_ker1 = ker_row;
            3'b010: reg_ker2 = ker_row;
            3'b011: reg_ker3 = ker_row;
            3'b100: reg_ker4 = ker_row;
            default: {reg_ker0, reg_ker1, reg_ker2, reg_ker3, reg_ker4} = 
                     {ker0, ker1, ker2, ker3, ker4};
        endcase
        end
    end
///////////////////////////////FINISH READ KERNEL COEFFICIENTS///////////////////////////////



////////////////////////////////////////PARSE IFM DATA///////////////////////////////
    wire [PX_W*IFM_W-1:0] row_pixel; // [223:0]
    wire valid_row;
    parse_input_row #( 
        .PX_W(PX_W),
        .IFM_W(IFM_W)
        ) 
    inst_parse_input_row(
        .i_clk(i_clk),
        .i_rstn(i_rstn),
        .i_pixel(i_pixel),

        .o_row(row_pixel),
        .o_valid_row(valid_row)
    );

    reg [$clog2(IFM_W)-1:0] valid_row_cnt;
    reg [$clog2(IFM_W)-1:0] valid_row_cnt_next;
    reg [$clog2(IFM_W)-1:0] valid_row_cnt_buff;

    reg reg_valid_row;
    reg parsed_a_row; // Finished parsing a row of IFM
    reg [PX_W*IFM_W-1:0] reg_row_pixel;

    // Signal indicates a valid row. Lasts for 1 clock cyckle
    always@(posedge i_clk) begin
    valid_row_cnt_buff <= valid_row_cnt;
        if (!i_rstn) begin
            valid_row_cnt_buff <= 0;
            parsed_a_row <= 1'b0;
        end
        else if (valid_row_cnt_buff >= 28)
            parsed_a_row <= 1'b0;
        else
            parsed_a_row <= reg_valid_row;
    end
    
    // Complete one row parsing
    always@(posedge i_clk) begin
        if (!i_rstn) begin
            valid_row_cnt <= 0;
            reg_valid_row <= 0;
            reg_row_pixel <= 0;
        end
            
        else begin
            valid_row_cnt <= valid_row_cnt_next;
            reg_valid_row <= valid_row;
            reg_row_pixel <= row_pixel;
        end
    end

    always@(*) begin
        if (valid_row_cnt == 28)
            valid_row_cnt_next = valid_row_cnt;
        else if (valid_row)
            valid_row_cnt_next = valid_row_cnt + 1;
        else
            valid_row_cnt_next = valid_row_cnt;
    end

    reg [PX_W*IFM_W-1:0] ifm_r0, ifm_r1, ifm_r2, ifm_r3, ifm_r4;
    reg [PX_W*IFM_W-1:0] ifm_r5, ifm_r6, ifm_r7, ifm_r8, ifm_r9;
    reg [PX_W*IFM_W-1:0] ifm_r10, ifm_r11, ifm_r12, ifm_r13, ifm_r14;
    reg [PX_W*IFM_W-1:0] ifm_r15, ifm_r16, ifm_r17, ifm_r18, ifm_r19;
    reg [PX_W*IFM_W-1:0] ifm_r20, ifm_r21, ifm_r22, ifm_r23, ifm_r24;
    reg [PX_W*IFM_W-1:0] ifm_r25, ifm_r26, ifm_r27;

    // Finish parsing IFM
    always @(posedge i_clk) begin
        if (!i_rstn) 
            {ifm_r0, ifm_r1, ifm_r2, ifm_r3, ifm_r4,
            ifm_r5, ifm_r6, ifm_r7, ifm_r8, ifm_r9,
            ifm_r10, ifm_r11, ifm_r12, ifm_r13, ifm_r14,
            ifm_r20, ifm_r21, ifm_r22, ifm_r23, ifm_r24,
            ifm_r25, ifm_r26, ifm_r27} = 0;
        else if (reg_valid_row) begin
            case (valid_row_cnt)
                1:  ifm_r0 = reg_row_pixel;
                2:  ifm_r1 = reg_row_pixel;
                3:  ifm_r2 = reg_row_pixel;
                4:  ifm_r3 = reg_row_pixel;
                5:  ifm_r4 = reg_row_pixel;
                6:  ifm_r5 = reg_row_pixel;
                7:  ifm_r6 = reg_row_pixel;
                8:  ifm_r7 = reg_row_pixel;
                9:  ifm_r8 = reg_row_pixel;
                10:  ifm_r9 = reg_row_pixel;
                11:  ifm_r10 = reg_row_pixel;
                12:  ifm_r11 = reg_row_pixel;
                13:  ifm_r12 = reg_row_pixel;
                14:  ifm_r13 = reg_row_pixel;
                15:  ifm_r14 = reg_row_pixel;
                16:  ifm_r15 = reg_row_pixel;
                17:  ifm_r16 = reg_row_pixel;
                18:  ifm_r17 = reg_row_pixel;
                19:  ifm_r18 = reg_row_pixel;
                20:  ifm_r19 = reg_row_pixel;
                21:  ifm_r20 = reg_row_pixel;
                22:  ifm_r21 = reg_row_pixel;
                23:  ifm_r22 = reg_row_pixel;
                24:  ifm_r23 = reg_row_pixel;
                25:  ifm_r24 = reg_row_pixel;
                26:  ifm_r25 = reg_row_pixel;
                27:  ifm_r26 = reg_row_pixel;
                28:  ifm_r27 = reg_row_pixel;
                default: ;
            endcase
        end
    end
////////////////////////////////////FINISH PARSE IFM DATA///////////////////////////////



/////////////////////////// /START MULTIPLY AND ACCUMULATE///////////////////////////////
    reg [PX_W*IFM_W-1:0] row0, row1, row2, row3, row4;  // 8*28-1 = 223

    always@(*) begin
        case (valid_row_cnt_buff)
        5'h5:   {row0, row1, row2, row3, row4} = 
                {ifm_r0, ifm_r1, ifm_r2, ifm_r3, ifm_r4};
        5'h6:   {row0, row1, row2, row3, row4} = 
                {ifm_r1, ifm_r2, ifm_r3, ifm_r4, ifm_r5};
        5'h7:   {row0, row1, row2, row3, row4} = 
                {ifm_r2, ifm_r3, ifm_r4, ifm_r5, ifm_r6};
        5'h8:   {row0, row1, row2, row3, row4} = 
                {ifm_r3, ifm_r4, ifm_r5, ifm_r6, ifm_r7};
        5'h9:   {row0, row1, row2, row3, row4} = 
                {ifm_r4, ifm_r5, ifm_r6, ifm_r7, ifm_r8};
        5'hA:   {row0, row1, row2, row3, row4} = 
                {ifm_r5, ifm_r6, ifm_r7, ifm_r8, ifm_r9};
        5'hB:   {row0, row1, row2, row3, row4} = 
                {ifm_r6, ifm_r7, ifm_r8, ifm_r9, ifm_r10};
        5'hC:   {row0, row1, row2, row3, row4} = 
                {ifm_r7, ifm_r8, ifm_r9, ifm_r10, ifm_r11};
        5'hD:   {row0, row1, row2, row3, row4} = 
                {ifm_r8, ifm_r9, ifm_r10, ifm_r11, ifm_r12};
        5'hE:   {row0, row1, row2, row3, row4} = 
                {ifm_r9, ifm_r10, ifm_r11, ifm_r12, ifm_r13};
        5'hF:   {row0, row1, row2, row3, row4} = 
                {ifm_r10, ifm_r11, ifm_r12, ifm_r13, ifm_r14};
        5'h10:  {row0, row1, row2, row3, row4} = 
                {ifm_r11, ifm_r12, ifm_r13, ifm_r14, ifm_r15};
        5'h11:  {row0, row1, row2, row3, row4} = 
                {ifm_r12, ifm_r13, ifm_r14, ifm_r15, ifm_r16};
        5'h12:  {row0, row1, row2, row3, row4} = 
                {ifm_r13, ifm_r14, ifm_r15, ifm_r16, ifm_r17};
        5'h13:  {row0, row1, row2, row3, row4} = 
                {ifm_r14, ifm_r15, ifm_r16, ifm_r17, ifm_r18};
        5'h14:  {row0, row1, row2, row3, row4} = 
                {ifm_r15, ifm_r16, ifm_r17, ifm_r18, ifm_r19};
        5'h15:  {row0, row1, row2, row3, row4} = 
                {ifm_r16, ifm_r17, ifm_r18, ifm_r19, ifm_r20};
        5'h16:  {row0, row1, row2, row3, row4} = 
                {ifm_r17, ifm_r18, ifm_r19, ifm_r20, ifm_r21};
        5'h17:  {row0, row1, row2, row3, row4} = 
                {ifm_r18, ifm_r19, ifm_r20, ifm_r21, ifm_r22};
        5'h18:  {row0, row1, row2, row3, row4} = 
                {ifm_r19, ifm_r20, ifm_r21, ifm_r22, ifm_r23};
        5'h19:  {row0, row1, row2, row3, row4} = 
                {ifm_r20, ifm_r21, ifm_r22, ifm_r23, ifm_r24};
        5'h1A:  {row0, row1, row2, row3, row4} = 
                {ifm_r21, ifm_r22, ifm_r23, ifm_r24, ifm_r25};
        5'h1B:  {row0, row1, row2, row3, row4} = 
                {ifm_r22, ifm_r23, ifm_r24, ifm_r25, ifm_r26};
        5'h1C:  {row0, row1, row2, row3, row4} = 
                {ifm_r23, ifm_r24, ifm_r25, ifm_r26, ifm_r27};
        default: {row0, row1, row2, row3, row4} = 0;
        endcase
    end

    reg start_mac;
    reg [24*21-1:0] reg_ofm;
    wire [24*21-1:0] net_ofm;
    always@(*)begin
        if (parsed_a_row && (valid_row_cnt_buff >= 5))
            start_mac = 1'b1;
        else
            start_mac = 1'b0;
    end
    
    wire [23:0] valid_ofm;
    // Generate block to create24 multiply accumulators
    genvar i;
    generate
        for (i = 0; i < 24; i = i + 1) begin : inst_mac
            mac inst_mac_i (
                .i_clk(i_clk),
                .i_rstn(i_rstn),
                .i_start_mac(start_mac),
                .i_row0(row0[8*i+39:8*i]), 
                .i_row1(row1[8*i+39:8*i]),
                .i_row2(row2[8*i+39:8*i]),
                .i_row3(row3[8*i+39:8*i]),
                .i_row4(row4[8*i+39:8*i]),
                .i_ker0(ker0),
                .i_ker1(ker1),
                .i_ker2(ker2),
                .i_ker3(ker3),
                .i_ker4(ker4),

                .o_ofm(o_ofm[21*i+20:21*i]),
                .o_valid_ofm(valid_ofm[i])
            );
        end
    endgenerate
    
    always@(*) begin
        if (&valid_ofm)
            o_valid_ofm = 1'b1;
        else
            o_valid_ofm = 1'b0;
    end
////////////////////////////FINISH MULTIPLY AND ACCUMULATE///////////////////////////////

endmodule