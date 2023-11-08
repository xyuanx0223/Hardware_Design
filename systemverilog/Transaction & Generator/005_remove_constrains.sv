//`timescale 1ns/1ps

class transaction;
  randc bit [3: 0] a;
  constraint d1 { a > 4'b0100;};
  constraint d2 { a < 4'b1100;};
endclass

module tb();
  transaction t1;
  integer i;
  bit [3: 0] data;
  
  initial begin
    $display("-------------------------");
    t1 = new();
    for (i = 0; i < 10; i++) begin
      // remove specific constrains
      t1.d1.constraint_mode(0);
      t1.randomize();
      data = t1.a;
      #10;
      $display("value after randomization is %0d", data);
    end
    $display("-------------------------");
    $dumpfile("dump.vcd"); 
    $dumpvars;
    #200;
    $finish();
  end
  
endmodule

