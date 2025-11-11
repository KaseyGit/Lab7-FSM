`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/16/2025 01:38:41 PM
// Design Name: 
// Module Name: segment_7_binary
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


module segment_7_binary(
    input [3:0] data_in,
    output reg [6:0] seg
    
    );
    
    
    //behavioral
	always @* begin
		case (data_in)
			0: seg = 7'b0000001; //bit order is ABCDEFG, where A = seg[6]
			1'b0001: seg = 7'b1001111; //can write cases either way
			2: seg = 7'b0010010;
			3: seg = 7'b0000110;
			4: seg = 7'b1001100;
			5: seg = 7'b0100100;
			6: seg = 7'b0100000;
			7: seg = 7'b0001111;
			8: seg = 7'b0000000;
			9: seg = 7'b0000100;
			default: seg = 7'b1111111; //default is no display
		endcase
	end
    
endmodule
