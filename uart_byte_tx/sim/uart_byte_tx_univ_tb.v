`timescale 1ns / 1ps
module uart_byte_tx_univ_tb(
    );
    reg clk;
    reg rst_n;
    reg [7:0] data;
    reg send_go;
    wire uart_tx;
    wire tx_done;

    uart_byte_tx_univ u_uart_byte_tx_univ(
        .clk(clk),
        .rst_n(rst_n),
        .data(data),
        .send_go(send_go),
        .uart_tx(uart_tx),
        .tx_done(tx_done)
    );

    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    initial begin
        rst_n = 0;
        send_go = 1;#201;
        rst_n = 1;
        data = 8'b0101_0101;#100;
        send_go = 0;
        #20 send_go = 1;
        #2000_000;

        data = 8'b1010_1010;#100;
        send_go = 0;
        #20 send_go = 1;
        #2000_000;
        $finish;
    end

endmodule
