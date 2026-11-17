module led_ctrl_top(
    input clk,
    input rst_n,
    input [7:0] SW,
    output [7:0] led_count
);

    reg [7:0] round_cnt;

    wire led;
    wire round_done;

    led_ctrl u_led_ctrl(
        .clk(clk),
        .rst_n(rst_n),
        .SW(SW),
        .led(led),
        .round_done(round_done)
    );

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)
            round_cnt <= 0;
        else if(round_done)
            round_cnt <= round_cnt + 1'b1;
    end

    assign led_count = round_cnt;

endmodule
