module clock_divided_counter(
    input wire main_clk,
    input wire reset,
    output wire [11:0] count
);
    wire divided_clk;
    
    Clock_divider divider(.clock_in(main_clk),.clock_out(divided_clk));

    counter_4095 count(.clk(divided_clk),.reset(reset),.count(count));

endmodule
