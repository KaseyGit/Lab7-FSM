module counter_4095(
    input wire en,
	input wire clk, 
	input wire reset, 
	output reg [11:0] count, //12 bit counter output
	output reg rdy);


always @(posedge clk or posedge reset) begin
    rdy <= 0;
	if(reset) begin
        count <= 12'd0; //reset output to 0
        rdy <= 0;
	end
	else if(count == 12'd4095)begin
	   count <= 12'd0;
	end
	else if (en) begin
        count <= count + 1; //update the counter
        rdy <= 1; //enable into the binary to BCD module
	end

end

endmodule

