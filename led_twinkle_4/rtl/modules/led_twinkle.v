module led_twinkle(
    clk,
    rst_n,
    led
    );

    input clk;
    input rst_n;
    output reg led;

    reg [24:0] cnt;
    parameter CNT_MAX = 25_000_000 - 1;

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)
            cnt <= 0;
        else if(cnt == CNT_MAX)
            cnt <= 0;
        else
            cnt <= cnt + 1'd1;
    end

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)
            led <= 0;
        else if(cnt == CNT_MAX)
            led <= ~led;
    end




endmodule
