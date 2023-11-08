//`timescale 1ns/1ps

class transaction;
  
  randc bit [3: 0] a;
  rand bit [4: 0] b; 
  rand bit [6: 0] c;
  bit [7: 0] dout;
  bit [6: 0] qout;

endclass


module tb();
  transaction t1; // handler
  integer i;
  
  initial begin
    t1 = new();
    for (i = 0; i <20; i++) begin
      t1.randomize();
      #10;
      $display("--------------------");
      $display("value of a: %0d", t1.a);
      $display("--------------------");
    end
    
    $dumpfile("dump.vcd"); 
    $dumpvars;
    #200;
    $finish();
  end
  
endmodule



//// randc would not iterate untill all cases are listed
