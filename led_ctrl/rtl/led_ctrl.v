module led_ctrl(
    clk,
    rst_n,
    led,
    SW
);

    input clk;
    input rst_n;
    input [7:0] SW;
    output reg led;

    reg [23:0] counter1;
    parameter MCNT1 = 12_500_000;
    
    reg [2:0] counter2;
    reg encounter1;

    reg [25:0] counter3;
    parameter MCNT3 = 50_000_000;

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            counter1 <= 0;
        end 
        else begin
            if(encounter1) begin
                if(counter1 == MCNT1 - 1) begin
                    counter1 <= 0;
                end
                else begin
                    counter1 <= counter1 + 1;
                end
            end
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            counter2 <= 0;
        end 
        else begin
            if(counter1 == MCNT1 - 1) begin
                counter2 <= counter2 + 1;
            end
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            counter3 <= 0;
        end 
        else begin
            if(~encounter1) begin
                if(counter3 == MCNT3 - 1) begin
                    counter3 <= 0;
                end
                else begin
                    counter3 <= counter3 + 1;
                end
            end
            else begin
                counter3 <= 0;
            end
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            encounter1 <= 0;
        end 
        else begin
            if(counter1 == MCNT1 - 1 && counter2 == 7) begin
                encounter1 <= 0;
            end
            else if(counter3 == MCNT3 - 1) begin
                encounter1 <= 1;
            end
        end
    end


    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            led <= 0;
        end 
        else begin
            if(encounter1 == 0)
                led <= 0;
            else begin
                case(counter2)
                    0: led <= SW[0];
                    1: led <= SW[1];
                    2: led <= SW[2];
                    3: led <= SW[3];
                    4: led <= SW[4];
                    5: led <= SW[5];
                    6: led <= SW[6];
                    7: led <= SW[7];
                endcase
            end
        end
    end

endmodule
