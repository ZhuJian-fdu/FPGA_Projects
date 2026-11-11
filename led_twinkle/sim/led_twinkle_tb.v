`timescale 1ns / 1ns

module led_twinkle_tb(
    );

    reg clk;
    reg rst_n;
    wire led;

    led_twinkle u_led_twinkle(
        .clk(clk),
        .rst_n(rst_n),
        .led(led)
    );

    initial clk = 1;
    always #10 clk = ~clk;

    initial begin
        rst_n = 0;#201;
        rst_n = 1;#2000000000;
        $stop;
    end
endmodule
