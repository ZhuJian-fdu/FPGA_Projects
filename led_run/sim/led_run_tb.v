`timescale 1ns / 1ns

module led_run_tb(
    );

    reg clk;
    reg rst_n;
    wire [7:0]led_1;
    wire [7:0]led_2;
    wire [7:0]led_3;

    // led_run_v1 u_led_run_v1(
    //     .clk(clk),
    //     .rst_n(rst_n),
    //     .led(led_1)
    // );
    // defparam u_led_run_v1.CNT_MAX = 25_000 - 1;

    led_run_v1 
    #(
        .CNT_MAX(25_000 - 1)
    )
    u_led_run_v1(
        .clk(clk),
        .rst_n(rst_n),
        .led(led_1)
    );

    led_run_v2 u_led_run_v2(
        .clk(clk),
        .rst_n(rst_n),
        .led(led_2)
    );
    defparam u_led_run_v2.CNT_MAX = 25_000 - 1;

    led_run_v3 u_led_run_v3(
        .clk(clk),
        .rst_n(rst_n),
        .led(led_3)
    );
    defparam u_led_run_v3.CNT_MAX = 25_000 - 1;

    initial clk = 1;
    always #10 clk = ~clk;

    initial begin
        rst_n = 0;#201;
        rst_n = 1;#40000000;
        $stop;
    end
endmodule
