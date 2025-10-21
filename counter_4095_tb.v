module counter_4095_tb();

reg clk, reset;
wire count;

counter_4095 dut(.clk(clk), .reset(reset), .count(count));

always #40950 clk = ~clk;
	
initial begin 
	clk = 0; reset = 1;
	#15;
	
	reset = 0;
	#15;
	$finish;
	
	end
endmodule
