module bin2bcd(bin, en, clk, bcd_out, rdy); //FSM version
	input [11:0] bin;
	input clk;
	input en;
	output [15:0] bcd_out;
	output rdy;
	
	parameter IDLE = 3'd0, SETUP = 3'd1, ADD = 3'd2, SHIFT = 3'd3, DONE = 3'd4;
	
	reg busy = 0;
	reg [27:0] bcd_data =0; //16 BCD + 12 bits binary
	reg [2:0] state = 0;
	reg [3:0] sh_counter=0; //can go 0 to 11 for number of SHIFTs, resets after
	reg [2:0] add_counter = 3; //can go 0 to 3 for BCD digits, resets after
	reg result_rdy = 0;
	
	//behavior based on flowchart in slides
	always @(posedge clk) begin
		case (state)
			IDLE:
				begin
					result_rdy <= 0;
					busy <= 0;
					if (en) state <= SETUP;
					else state <= IDLE;
				end
			
			SETUP:
				begin
				    bcd_data = bin;
					busy <= 1;
					state <= ADD;
				end
			
			ADD:
				begin
					case (add_counter)
						0: //time to check the ones place
						begin
							if (bcd_data[15:12] > 4) begin //if first 4 bits of BCD are >4
								bcd_data[27:12] <= bcd_data[27:12] + 3; //ADD 3 to the BCD number starting from bit position 12
								state <= SHIFT;
								add_counter <= 3;
							end
							state <= SHIFT;
							add_counter <= 3;
						end
						1: //check the tens place
						begin
							if (bcd_data[19:16] > 4) begin
								bcd_data[27:16] <= bcd_data[27:16] + 3;
								state <= SHIFT;
								add_counter <= 3;
							end
							else add_counter <= add_counter -1;
						end
						2: //check the hundreds place
						begin
							if (bcd_data[23:20] > 4) begin
								bcd_data[27:20] <= bcd_data[27:20] + 3;
								state <= SHIFT;
								add_counter <= 3;
							end
							else add_counter <= add_counter -1;
						end
						3: //check the thousands place
						begin
							if (bcd_data[27:24] > 4) begin
								bcd_data[27:24] <= bcd_data[27:24] + 3;
							    state <= SHIFT; 
							    add_counter <= 3;
							end
							else add_counter <= add_counter -1;
						end
					endcase
				end
			SHIFT:
				begin
					sh_counter <= sh_counter + 1; 
					bcd_data <= bcd_data << 1;
					if (sh_counter >= 11) begin
                        state <= DONE;
                        sh_counter <= 0;
					end
					else state <= ADD;
				end
			DONE:
				begin
					state <= IDLE;
					result_rdy = 1;
				end
			default: state <= IDLE;
		endcase
	end
	
	assign bcd_out = bcd_data[27:12];
	assign rdy = result_rdy;
endmodule
