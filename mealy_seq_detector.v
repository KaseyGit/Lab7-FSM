`timescale 1ns / 1ps
module mealy_seq_detector(
input P1,clk,reset,
output reg z
);

//declare states
parameter S0 = 0 , S1 = 1 , S2 = 2 , S3 = 3;

//describes state variables
reg [1:0] PS,NS;

//initialize states
always@(posedge clk or posedge reset)
 	begin
 	if(reset)
 		PS <= S0;
 	else
		PS <= NS ;
 	end

//state transitions
always@(PS or P1)
	begin
 	case(PS)

	S0 : begin
 	z = 0 ;
 	if (P1) //if 1
 		NS = S1;
 	else
 		NS = S0;
 	end

 	S1 : begin //if 1
 	if (P1)
 		NS = S2;
 	else
 		NS = S1;
 	end

 	S2 : begin
 	if(!P1) //if 0
		NS = S3;
	else
		NS = S0;
 	end

	S3: begin
	if (P1) //if 1
		NS = S0;
	else
		NS = S0;
	end
	endcase
	end

//output
always @ (PS or P1)
	begin
 	case (PS)

 	S0 : z = 0 ;
 	S1 : z = 0 ;
 	S2 : z = 0 ;
 	S3 : begin
	if (P1)
	z = 1;
	end
 	endcase
	end
endmodule
