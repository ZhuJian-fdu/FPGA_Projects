module uart_byte_tx_univ(
    clk,
    rst_n,
    send_go,
    data,
    uart_tx,
    tx_done
    );
    input clk;
    input rst_n;
    input [7:0] data;
    input send_go;
    output reg uart_tx;
    output reg tx_done;

    parameter BAUD = 9600;
    parameter CLOCK_FREQ = 50_000_000;

    parameter MCNT_BAUD = CLOCK_FREQ / BAUD - 1;
    parameter MCNT_BIT = 10 - 1;

    reg [29:0] baud_div_cnt;
    reg en_baud_cnt;
    reg [3:0] bit_cnt;
    reg [7:0] r_data;
    wire w_tx_done;

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
        else if(send_go) begin
            en_baud_cnt <= 1'b1;
        end
        else if(w_tx_done) begin
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
            r_data <= 0;
        end
        else if(send_go) begin
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

    assign w_tx_done = (bit_cnt == MCNT_BIT && baud_div_cnt == MCNT_BAUD);

    always @(posedge clk) begin
        tx_done <= w_tx_done;
    end

endmodule
