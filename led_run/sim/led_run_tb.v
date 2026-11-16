`timescale 1ns / 1ns

module led_run_tb(
    );

    reg clk;
    reg rst_n;
    wire [7:0]led;

    led_run_v1 u_led_run_v1(
        .clk(clk),
        .rst_n(rst_n),
        .led(led)
    );

    initial clk = 1;
    always #10 clk = ~clk;

    initial begin
        rst_n = 0;#201;
        rst_n = 1;#40000000;
        $stop;
    end
endmodule
