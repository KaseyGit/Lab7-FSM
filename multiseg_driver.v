`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/30/2025 01:37:23 PM
// Design Name: 
// Module Name: multiseg_driver
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


module multiseg_driver(
    input clk,
    input [15:0] bcd_in,
    output [3:0] seg_anode,
    output [6:0] seg_cathode
    );
    
	wire [3:0] bcd_result;
	
	anode_generator anode_gen(.clk(clk), .bcd_in(bcd_in), .seg_anode(seg_anode), .bcd_out(bcd_result));
	segment_7_binary cat_gen(.data_in(bcd_result), .seg(seg_cathode));
endmodule
