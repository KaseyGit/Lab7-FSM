`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/30/2025 01:37:23 PM
// Design Name: 
// Module Name: anode_generator
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module anode_generator(
    input clk,
    input [15:0] bcd_in,
    output [3:0] seg_anode,
    output reg [3:0] bcd_out//the given four bits to display to the selected anode
    );
    
	reg [9:0] counter = 0; //10-bit counter is more stable for some reason
	reg [3:0] anode = 4'b1110; //active low
	reg [3:0] anode_buff;
	
	always @(posedge clk) begin
		counter <= counter + 1; //so this is slow enough for us to see the changes, allows all four shifts to be shown
		if (counter == 1023) begin
		    anode_buff <= anode;
			anode <= {anode[2:0], anode[3]}; //acts like a circular shift register
			//do this so we can sequence through the four anodes: 1110 -> 0111 -> 1011 -> 1101
			
			//group the data
			case (anode)
				4'b1110: bcd_out <= bcd_in[3:0]; //if rightmost anode is active, 4 LSB from bcd are the displayed here
				4'b1101: bcd_out <= bcd_in[7:4];
				4'b1011: bcd_out <= bcd_in[11:8];
				4'b0111: bcd_out <= bcd_in[15:12];
				default: bcd_out <= 4'b0;
			endcase
			counter <= 0;
		end
	end
	
	assign seg_anode = anode_buff;
endmodule
