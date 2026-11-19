module uart_byte_tx(
    clk,
    rst_n,
    data,
    uart_tx,
    led
    );
    input clk;
    input rst_n;
    input [7:0] data;
    output reg uart_tx;
    output reg led;

    parameter MCNT_BAUD = 5208 - 1;
    parameter MCNT_BIT = 10 - 1;
    parameter MCNT_DELAY = 50_000_000 - 1;

    reg [12:0] baud_div_cnt;
    reg en_baud_cnt;
    reg [3:0] bit_cnt;
    reg [25:0] delay_cnt;
    reg [7:0] r_data;

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            baud_div_cnt <= 0;
        end
        else if(en_baud_cnt) begin
            if(baud_div_cnt == MCNT_BAUD) begin
                baud_div_cnt <= 0;
            end
            else begin
                baud_div_cnt <= baud_div_cnt + 1'b1;
            end
        end
        else begin
            baud_div_cnt <= 0;
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            en_baud_cnt <= 0;
        end
        else if(delay_cnt == MCNT_DELAY) begin
            en_baud_cnt <= 1'b1;
        end
        else if(bit_cnt == MCNT_BIT && baud_div_cnt == MCNT_BAUD) begin
            en_baud_cnt <= 1'b0;
        end
    end


    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            bit_cnt <= 0;
        end
        else if(baud_div_cnt == MCNT_BAUD) begin
            if(bit_cnt == MCNT_BIT) begin
                bit_cnt <= 0;
            end
            else begin
                bit_cnt <= bit_cnt + 1'b1;
            end
        end
    end


    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            delay_cnt <= 0;
        end
        else if(delay_cnt == MCNT_DELAY) begin
            delay_cnt <= 0;
        end
        else begin
            delay_cnt <= delay_cnt + 1'b1;
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            r_data <= 0;
        end
        else if(delay_cnt == MCNT_DELAY) begin
            r_data <= data;
        end
        else begin
            r_data <= r_data;
        end
    end


    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            uart_tx <= 1'b1;
        end
        else if(en_baud_cnt == 0)
            uart_tx <= 1'b1;
        else begin
            case(bit_cnt)
                4'd0: uart_tx <= 1'b0; 
                4'd1: uart_tx <= r_data[0];
                4'd2: uart_tx <= r_data[1];
                4'd3: uart_tx <= r_data[2];
                4'd4: uart_tx <= r_data[3];
                4'd5: uart_tx <= r_data[4];
                4'd6: uart_tx <= r_data[5];
                4'd7: uart_tx <= r_data[6];
                4'd8: uart_tx <= r_data[7];
                4'd9: uart_tx <= 1'b1; 
                default: uart_tx <= uart_tx;
            endcase
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            led <= 0;
        end
        else if(bit_cnt == MCNT_BIT && baud_div_cnt == MCNT_BAUD) begin
            led <= ~led;
        end
    end
endmodule
