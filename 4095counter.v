module counter(
	input wire clk, 
	input wire reset, 
	output reg [11:0] count //12 bit counter output
);

reg[11:0] next_count; //next state of the counter

//get the next count
always @(*) begin
	next_count = count + 1;
end

always @(posedge clk) begin
	if(reset) begin
	count <= 12'd0; //reset output to 0
		end
	else begin
	count <= next_count; //update the counter
	end
end

endmodule
