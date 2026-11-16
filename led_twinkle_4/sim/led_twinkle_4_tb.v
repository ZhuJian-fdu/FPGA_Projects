`timescale 1ns / 1ns

module led_twinkle_4_tb(
    );

    reg clk;
    reg rst_n;
    wire [3:0] led;

    led_twinkle_4 
    #(
        .MCNT0(25_000 - 1),
        .MCNT1(12_500 - 1),
        .MCNT2(6_250 - 1),
        .MCNT3(2_500 - 1)
    )
    u_led_twinkle_4(
        .clk(clk),
        .rst_n(rst_n),
        .led(led)
    );

    initial clk = 1;
    always #10 clk = ~clk;

    initial begin
        rst_n = 0;#201;
        rst_n = 1;#2000000;
        $stop;
    end
endmodule
