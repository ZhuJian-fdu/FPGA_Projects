`timescale 1ns / 1ps

module tb_assignment;

    reg clk;
    reg rst;
    reg din;

    wire b1, b2, b3;
    wire n1, n2, n3;
    wire m1, m2, m3;

    blocking u_blocking (
        .clk(clk),
        .rst(rst),
        .din(din),
        .q1(b1), .q2(b2), .q3(b3)
    );

    nonblocking u_nonblocking (
        .clk(clk),
        .rst(rst),
        .din(din),
        .q1(n1), .q2(n2), .q3(n3)
    );

    mixed u_mixed (
        .clk(clk),
        .rst(rst),
        .din(din),
        .q1(m1), .q2(m2), .q3(m3)
    );

    initial clk = 1'b0;
    always #5 clk = ~clk;

    initial begin
        rst = 1'b1;
        din = 1'b0;

        @(negedge clk);
        rst = 1'b0;
        din = 1'b1;

        @(negedge clk);
        din = 1'b0;

        @(negedge clk);
        din = 1'b1;

        @(negedge clk);
        din = 1'b1;

        @(negedge clk);
        din = 1'b0;
    end

    initial begin
        #100;
        $finish;
    end
endmodule
