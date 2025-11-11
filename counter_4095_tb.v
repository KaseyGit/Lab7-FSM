module counter_4095_tb();

reg clk, reset, en;
wire count, rdy;

	counter_4095 dut(.clk(clk), .reset(reset), .count(count), .en(en), .rdy(rdy));

always #40950 clk = ~clk;
	
initial begin 
	clk = 0; reset = 1; en = 1;
	#15;
	
	reset = 0;
	#15;
	$finish;
	
	end
endmodule
