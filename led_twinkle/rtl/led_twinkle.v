module led_twinkle(
    clk,
    rst_n,
    led
    );

    input clk;
    input rst_n;
    output reg led;

    reg [24:0] cnt;
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)
            cnt <= 0;
        else if(cnt == 25_000_000 - 1)
            cnt <= 0;
        else
            cnt <= cnt + 1'd1;
    end

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)
            led <= 0;
        else if(cnt == 25_000_000 - 1)
            led <= ~led;
    end




endmodule
