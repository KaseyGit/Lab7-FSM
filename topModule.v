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


  
Clock_divider divider(.clock_in(mclk),.reset(reset), .clock_out(clock_out)); //added a reset
counter_4095 counter(.clk(clock_out),.reset(reset),.count(bin_d_in)); //slow clock
//clock_divided_counter cd(.count(bin_d_in), .main_clk(mclk), .reset(reset));//clock divider
bin2bcd convert(.bin(bin_d_in), .en(1'b1), .bcd_out(bcd_d_out), .rdy(rdy), .clk(clock_out), .reset(reset));//bin2bcd //slow clock
multiseg_driver multiseg(.bcd_in(stat_bcd), .seg_anode(an), .seg_cathode(seg), .clk(mclk));//multisegdriver


always @ (posedge clock_out)
	begin
	if(rdy)
		begin
		stat_bcd<=bcd_d_out;
		end
	end
endmodule
