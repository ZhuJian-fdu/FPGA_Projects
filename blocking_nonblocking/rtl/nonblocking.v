module nonblocking (
    input  wire clk,
    input  wire rst,
    input  wire din,
    output reg  q1,
    output reg  q2,
    output reg  q3
);

    always @(posedge clk) begin
        if (rst) begin
            q1 <= 1'b0;
            q2 <= 1'b0;
            q3 <= 1'b0;
        end
        else begin
            q1 <= din;
            q2 <= q1;
            q3 <= q2;
        end
    end

endmodule
