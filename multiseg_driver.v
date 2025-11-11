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
    input en,
    input [15:0] bcd_in,
    output [3:0] seg_anode,
    output [6:0] seg_cathode,
    output rdy //take after all anodes have displayed
    );
    wire [3:0] bcd_result;
	reg [15:0] anode_bcd_in;

    
    always @(posedge clk) begin
    	if(en)
            begin
            anode_bcd_in<=bcd_in;
            end
    end
	
	anode_generator anode_gen(.en(en), .clk(clk), .bcd_in(bcd_in), .seg_anode(seg_anode), .bcd_out(bcd_result), .rdy(rdy));
	segment_7_binary cat_gen(.data_in(bcd_result), .seg(seg_cathode));
endmodule
