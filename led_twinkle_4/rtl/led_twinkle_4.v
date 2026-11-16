module led_twinkle_4(
    clk,
    rst_n,
    led
    );


    input clk;
    input rst_n;
    output wire [3:0]led;

    parameter MCNT0 = 25_000_000 - 1;
    parameter MCNT1 = 12_500_000 - 1;
    parameter MCNT2 = 6_250_000 - 1;
    parameter MCNT3 = 2_500_000 - 1;

    led_twinkle 
    #(
        .CNT_MAX(MCNT0)
    )
    led_twinkle_inst0(
        .clk(clk),
        .rst_n(rst_n),
        .led(led[0])
    );

    led_twinkle led_twinkle_inst1(
        .clk(clk),
        .rst_n(rst_n),
        .led(led[1])
    );
    defparam led_twinkle_inst1.CNT_MAX = MCNT1;

    led_twinkle led_twinkle_inst2(
        .clk(clk),
        .rst_n(rst_n),
        .led(led[2])
    );
    defparam led_twinkle_inst2.CNT_MAX = MCNT2;

    led_twinkle led_twinkle_inst3(
        .clk(clk),
        .rst_n(rst_n),
        .led(led[3])
    );
    defparam led_twinkle_inst3.CNT_MAX = MCNT3;
endmodule
