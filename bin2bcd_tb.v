module bin2bcd_tb();
	reg clk, en;
	reg [11:0] bin_in;
	wire [15:0] bcd_out;
	wire rdy;
	
	bin2bcd uut(.clk(clk), .en(en), .bin(bin_in), .bcd_out(bcd_out), .rdy(rdy));
	
	initial begin
		clk = 0;
		bin_in = 12'b0;
	end
	
	always #5 clk = ~clk;
	
	initial begin
		bin_in = 12'b110100111100; //should be 3388
		#1000;
		
		bin_in = 12'b111111111111; //4095
		#1000;
		
		bin_in = 12'b0;
		#1000;
		$finish;
	end

endmodule