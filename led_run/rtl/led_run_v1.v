module led_run_v1(
    clk,
    rst_n,
    led
    );
    input clk;
    input rst_n;
    output reg [7:0]led;

    reg [24:0] cnt;
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)
            cnt <= 0;
        else if(cnt == 25_000 - 1)
            cnt <= 0;
        else
            cnt <= cnt + 1'd1;
    end

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)
            led <= 8'b0000_0001;
        else if(cnt == 25_000 - 1) begin
            if(led == 8'b1000_0000 | led == 8'b0000_0000)
                led <= 8'b0000_0001;
            else
                led <= led << 1;
        end
    end
endmodule
