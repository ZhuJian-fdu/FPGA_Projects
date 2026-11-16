`timescale 1ns / 1ns

module led_run_tb(
    );

    reg clk;
    reg rst_n;
    wire [7:0]led_1;
    wire [7:0]led_2;

    led_run_v1 u_led_run_v1(
        .clk(clk),
        .rst_n(rst_n),
        .led(led_1)
    );

    led_run_v2 u_led_run_v2(
        .clk(clk),
        .rst_n(rst_n),
        .led(led_2)
    );

    initial clk = 1;
    always #10 clk = ~clk;

    initial begin
        rst_n = 0;#201;
        rst_n = 1;#40000000;
        $stop;
    end
endmodule
