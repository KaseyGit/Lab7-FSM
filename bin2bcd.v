module bin2bcd(bin, en, clk, thousands, hundreds, tens, ones); //FSM version
	input [11:0] bin;
	input clk;
	input en;
	output reg [3:0] thousands, hundreds, tens, ones;
	
	parameter idle = 0, setup = 1, add = 2, shift = 3, done = 4;
	
	reg busy = 0;
	reg [27:0] bcd_data = 0; //16 BCD + 12 bits binary
	reg [2:0] state = 0;
	reg [3:0] sh_counter; //can go 0 to 11 for number of shifts, resets after
	reg [2:0] add_counter = 0; //can go 0 to 3 for BCD digits, resets after
	reg result_rdy = 0;
	
	//behavior based on flowchart in slides
	always @(posedge clk) begin
		case (state)
			idle:
			begin
				if (en) state <= setup;
				else state <= idle;
			end
			
			setup:
			begin
				busy <= 1;
				state <= add;
			end
			
			add:
			begin
				case (add_counter)
					0: //time to check the ones place
					begin
						if (bcd_data[15:12] > 4) begin //if first 4 bits of BCD are >4
							bcd_data[27:12] <= bcd_data[27:12] + 3; //add 3 to the BCD number starting from bit position 12
						end
						add_counter <= add_counter + 1; //increment
						state <= state;
					end
					1: //check the tens place
					begin
						if (bcd_data[19:16] > 4) begin
							bcd_data[27:16] <= bcd_data[27:16] + 3;
						end
						add_counter <= add_counter + 1;
						state <= state;
					end
					2: //check the hundreds place
					begin
						if (bcd_data[23:20] > 4) begin
							bcd_data[27:20] <= bcd_data[27:20] + 3;
						end
						add_counter <= add_counter + 1;
						state <= state;
					end
					3: //check the thousands place
					begin
						if (bcd_data[27:24] > 4) begin
							bcd_data[27:24] <= bcd_data[27:24] + 3;
						end
						add_counter <= 0; //reset for next time
						state <= shift;
					end
				endcase
			end
			shift:
			begin
				sh_counter <= sh_counter + 1; 
				bcd_data <= bcd_data << 1;
				if (sh_counter > 11) state <= done;
				else state <= add;
			end
			done:
			begin
				state <= idle;
				result_rdy = 1;
			end
		endcase
	end
endmodule