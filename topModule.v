`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/21/2025 03:25:33 PM
// Design Name: 
// Module Name: Display_Top
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

module topModule(
input mclk, 
input reset,
output wire [6:0] seg, 
output wire [3:0] an);

reg[15:0] stat_bcd = 16'b0;

//wire en;
wire [11:0] bin_d_in;
wire [15:0] bcd_d_out;
wire rdy;
wire clock_out;
wire multiseg_to_counter, counter_to_bin2bcd, bin2bcd_to_multiseg;


  
Clock_divider divider(.clock_in(mclk), .clock_out(clock_out)); //added a reset
counter_4095 counter(.en(multiseg_to_counter), .clk(clock_out),.reset(reset),.count(bin_d_in), .rdy(counter_to_bin2bcd)); //slow clock
//clock_divided_counter cd(.count(bin_d_in), .main_clk(mclk), .reset(reset));//clock divider
bin2bcd convert(.bin(bin_d_in), .en(counter_to_bin2bcd), .bcd_out(bcd_d_out), .rdy(bin2bcd_to_multiseg), .clk(mclk), .reset(reset));//bin2bcd //slow clock
multiseg_driver multiseg(.en(bin2bcd_to_multiseg), .bcd_in(bcd_d_out), .seg_anode(an), .seg_cathode(seg), .clk(mclk), .rdy(multiseg_to_counter));//multisegdriver

endmodule
