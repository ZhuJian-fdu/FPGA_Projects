module led_run_v3(
    clk,
    rst_n,
    led
    );
    input clk;
    input rst_n;
    output wire [7:0]led;

    reg [24:0] cnt;
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)
            cnt <= 0;
        else if(cnt == 25_000 - 1)
            cnt <= 0;
        else
            cnt <= cnt + 1'd1;
    end

    reg [2:0] cnt_a;
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)
            cnt_a <= 0;
        else if(cnt == 25_000 - 1)
            cnt_a <= cnt_a + 1'd1;
    end

    decoder_3_8 decoder_3_8_inst0(
    .A0(cnt_a[0]),
    .A1(cnt_a[1]),
    .A2(cnt_a[2]),    
    .Y0(led[0]),
    .Y1(led[1]),
    .Y2(led[2]),
    .Y3(led[3]),
    .Y4(led[4]),
    .Y5(led[5]),
    .Y6(led[6]),
    .Y7(led[7])
    );

endmodule
