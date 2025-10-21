module moore_seq_detector_tb();
	reg p1, clk, rest; //inputs
	wire y; //output
	
	moore_seq_detector uut(.P1(p1), .clk(clk), .rst(rst), .Y(y));
	
	initial begin
		clk = 0;
		reset = 1;
		p1 = 0;
		#15 reset = 0;
	end
	
	always #5 clk = ~clk; //each cycle takes 10 time units
	
	initial begin
		p1 = 1; #10; //0 1...
		p1 = 0; #10; //0 10, restart
		p1 = 1; #20; //11...
		p1 = 0; #10; //110...
		p1 = 1; #10; //1101, restart
		p1 = 1; #20; //11...
		p1 = 0; #20; //1100 yay
		#10; //1100 0... should restart at s0
		p1 = 1; #10; //0 1... moves us to s1
		//so on and so forth
		$finish;
	end
endmodule