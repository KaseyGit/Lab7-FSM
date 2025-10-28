module topModule(
input mclk, 
output wire [6:0] seg, 
output wire [3:0] an);

reg[15:0] stat_bcd = 16'b0;

wire en;
wire [11:0] bin_d_in;
wire [15:0] bcd_d_out;
wire rdy;
wire clock_out;

Clock_divider cd();//clock divider
counter_4095 count();//counter
bin2bcd convert();//bin2bcd
multiseg_driver multiseg();//multisegdriver

always @ (posedge mclk)
	begin
	if(rdy)
		begin
		stat_bcd<=bcd_d_out;
		end
	end
endmodule