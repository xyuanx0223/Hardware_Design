`timescale 1ns / 1ps   //10^3 -> 3
 
module tb();
  reg clk16 = 0;
  reg clk8 = 0;  ///initialize variable
   
   always #31.25 clk16 = ~clk16;
   always #62.5 clk8 = ~clk8;
  
  initial begin
    #200;
    $finish();
  end 
endmodule
