`timescale 1ns / 1ps
module uart_byte_tx_tb(
    );
    reg clk;
    reg rst_n;
    reg [7:0] data;
    wire uart_tx;
    wire led;

    uart_byte_tx uart_byte_tx(
        .clk(clk),
        .rst_n(rst_n),
        .data(data),
        .uart_tx(uart_tx),
        .led(led)
    );
    defparam uart_byte_tx.MCNT_DELAY = 50_000_0 - 1;


    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    initial begin
        rst_n = 0;#201;
        rst_n = 1;
        data = 8'b0101_0101;#30_000_000;
        data = 8'b1010_1010;#30_000_000;
        $finish;
    end
endmodule
