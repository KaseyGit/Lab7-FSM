module topModule_tb();

    reg reset;
    reg clk;
    wire [3:0] an;
    wire [6:0] cath;
    topModule dut(.mclk(clk), .an(an), .seg(cath),.reset(reset));
 
 initial begin
 
 clk = 1'b0;
 
 forever #5 clk = ~clk; //changed from #1 to #5
 end
    
    initial begin
        reset = 1'b1;
        #20; //changed from #10
        reset = 1'b0;
        #15000; 
    
        $finish;
    end
endmodule

