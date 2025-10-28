module topModule_tb();

    reg reset;
    reg clk;
    wire [3:0] an;
    wire [6:0] cath;
    topModule dut(.mclk(clk), .an(an), .seg(cath),.reset(reset));
 
 initial begin
 
 clk = 1'b0;
 
 forever #1 clk = ~clk;
 end
    
    initial begin
        reset = 1'b1;
        #10;
        reset = 1'b0;
        #10000;
        $finish;
    end
endmodule
