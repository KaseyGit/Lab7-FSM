`timescale 1ns / 1ps
//THIS IS THE CLOCK DIVIDER MODULE FROM LAB 6
module Clock_divider(clock_in,clock_out);

input clock_in;
output reg clock_out = 1'b0;

reg[1:0] counter=2'd0;

 always @(posedge clock_in) begin
 	counter <= counter + 1;
 	if (counter == 2'b01) begin
 	clock_out <= ~clock_out; // Toggle the output clock
 		counter <= 0;
    end
 end
 endmodule


