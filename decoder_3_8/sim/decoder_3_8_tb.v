`timescale 1ns/1ns

module decoder_3_8_tb();

    reg A0, A1, A2;
    wire Y0, Y1, Y2, Y3, Y4, Y5, Y6, Y7;

    decoder_3_8 decoder_3_8_inst0(
        .A0(A0),
        .A1(A1),
        .A2(A2),
        .Y0(Y0),
        .Y1(Y1),
        .Y2(Y2),
        .Y3(Y3),
        .Y4(Y4),
        .Y5(Y5),
        .Y6(Y6),
        .Y7(Y7)
    );

    initial begin
        {A2, A1, A0} = 3'b000; #20;
        {A2, A1, A0} = 3'b001; #20;
        {A2, A1, A0} = 3'b010; #20;
        {A2, A1, A0} = 3'b011; #20;
        {A2, A1, A0} = 3'b100; #20;
        {A2, A1, A0} = 3'b101; #20;
        {A2, A1, A0} = 3'b110; #20;
        {A2, A1, A0} = 3'b111; #20;
        $stop;
    end


endmodule