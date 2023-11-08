//`timescale 1ns/1ps

class transaction;
  randc bit [1: 0] a;
endclass

module tb();
  transaction t1;
  bit [1: 0] data;
  
  initial begin
    
    t1 = new();
    assert(!t1.randomize())
      data = t1.a;
    else
      //$warning("Randomization is unsuccessful");      
      //$error("Randomization is unsuccessful");
      $fatal("Randomization is unsuccessful");
      ///// fatal ends simulation here
      $display("value of data member is %0b", t1.a);

    $dumpfile("dump.vcd"); 
    $dumpvars;
    #200;
    $finish();
  end
  
endmodule

