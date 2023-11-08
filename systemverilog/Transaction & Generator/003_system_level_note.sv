//`timescale 1ns/1ps

module tb();
  bit a = 1'b0;
  
  initial begin
    assert(a)
    else
      //$warning("value of a is false");      
      $error("value of a is false");
      //$fatal("value of a is false");
      ///// fatal ends simulation here
      $display("value of a is %0b", a);

    $dumpfile("dump.vcd"); 
    $dumpvars;
    #200;
    $finish();
  end
  
endmodule

