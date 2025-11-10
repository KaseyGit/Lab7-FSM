module counter_4095(
	input wire clk, 
	input wire reset, 
	output reg [11:0] count //12 bit counter output
);

//use asynch reset
always @(posedge clk or posedge reset) begin
	if(reset) begin
	count <= 12'd0; //reset output to 0
		end
	else if(count == 12'd4095)begin
	   count <= 12'd0;
	end
	else begin
	count <= count + 1; //update the counter
	end

end

endmodule




