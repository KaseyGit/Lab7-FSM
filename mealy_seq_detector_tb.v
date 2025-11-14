module mealy_seq_detector_tb();
	reg p1, clk, reset; //inputs
	wire z; //output
	
	mealy_seq_detector uut(.P1(p1), .clk(clk), .reset(reset), .z(z));
	
	initial begin
		clk = 0;
		reset = 1;
		p1 = 0;
		#15 reset = 0;
	end
	
	always #5 clk = ~clk; //each cycle takes 10 time units
	
	initial begin
	   //failed test
	    p1 = 1; #10;
	    p1 = 1; #10;
	    p1 = 0; #10;
	    p1 = 0; #10;
	    
	    //successful test
	    p1 = 1; #10;
	    p1 = 1; #10;
	    p1 = 0; #10;
	    p1 = 1; #10;
	    
	    //restart
	    p1 = 0; #10;
	    p1 = 1; #10;
	    
		$finish;
	end
endmodule
