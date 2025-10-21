module moore_seq_detector(
	input clk, rst, P1,
	output reg Y);
	
	//want to detect 1100
	
	parameter S0=0, S1 = 1, S2 = 2, S3 = 3, S4 = 4; //our 5 states
	reg [1:0] PS, NS; //present state and next state
	
	
	//state initialization
	always@(posedge clk or rst) begin
		//given by the slides
		if (rst) PS <= S0; //reset puts us back at initial state
		else PS <= NS;
	end
	
	//state transition; non-overlapping implementation so reaching S4 moves us to S0
	always@(PS or P1) begin
		case (PS) begin
			S0:
				begin
					//next state depends on present state and input
					if (P1) NS = S1; //1 moves us forward
					else NS = S0; //resets fully
				end
			S1: 
				begin
					if (P1) NS = S2; //11... moves us forward
					else NS = S0; //10... resets us fully
				end
			S2:
				begin
					if (!P1) NS = S3; //110... moves us forward
					else NS = S2; //1 11... resets us to this state
				end
			S3:
				begin
					if (!P1) NS = S4; //1100 yay
					else NS = S1; //110 1... reset to S1
				end
			S4: 
				begin
					if (P1) NS = S1; //1100 1...
					else NS = S0; //1100 0... need a 1 to start again
				end
		endcase
	
	end
	
	//output; combinational	
	always@(PS) begin //MOORE
		case(PS) begin
			S0: Y = 0;
			S1: Y = 0;
			S2: Y = 0;
			S3: Y = 1;
		endcase
	end

endmodule