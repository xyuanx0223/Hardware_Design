//`timescale 1ns/1ps

//module top(
//  input  [3: 0] a,
//  input  [4: 0] b,
//  input  [6: 0] c,
//  output [7: 0] dout,
//  output [6: 0] qout
//);
  ///////////
//endmodule

class transaction;
  
  rand bit [3: 0] a;
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
    for (i = 0; i <10; i++) begin
      t1.randomize();
      #10;
      $display("--------------------");
      $display("value of a: %0d", t1.a);
      $display("value of b: %0d", t1.b);
      $display("value of c: %0d", t1.c);
      $display("--------------------");
    end
    
    $dumpfile("dump.vcd"); 
    $dumpvars;
    #200;
    $finish();
  end
  
endmodule
