`timescale 1ns / 1ns

module led_ctrl_tb(
    );

    reg clk;
    reg rst_n;
    reg [7:0] SW;
    wire led;
    led_ctrl u_led_ctrl(
        .clk(clk),
        .rst_n(rst_n),
        .led(led),
        .SW(SW)
    );
    defparam u_led_ctrl.MCNT1 = 12_500;
    defparam u_led_ctrl.MCNT3 = 50_000;

    initial clk = 1;
    always #10 clk = ~clk;

    initial begin
        rst_n = 0;#201;
        rst_n = 1;
        SW = 8'b1000_1101;
        #10_000_000;
        SW = 8'b1010_0011;
        #10_000_000;
        $stop;
    end

endmodule
