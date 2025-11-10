`timescale 1ns / 1ps
//clock divider 50MHz to 100Hz
module Clock_divider(
input clock_in,
input reset, 
output reg clock_out);

//19 bit counter to count to 500,000
reg[18:0] counter;

//50,000,000 / (100 Hz * 2) = 250,000
localparam MAX_COUNT = 19'd9;


 always @(posedge clock_in or posedge reset) begin
    if (reset) begin
        //reset to 0
        counter <= 19'd0;
        clock_out <= 1'b0;
    end
    else begin
        if(counter == MAX_COUNT) begin
            counter <= 19'b0;
            clock_out <= ~clock_out;
        end
        else begin
        counter <= counter + 1;
        end
    end
 end
 endmodule

