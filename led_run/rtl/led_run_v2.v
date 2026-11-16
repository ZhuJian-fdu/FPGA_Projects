module led_run_v2(
    clk,
    rst_n,
    led
    );
    input clk;
    input rst_n;
    output reg [7:0]led;

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
            led <= 8'b0000_0001;
        else if(cnt == CNT_MAX) begin
                led <= {led[6:0],led[7]};
        end
    end
endmodule
