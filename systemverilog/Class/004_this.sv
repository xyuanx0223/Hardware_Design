//`timescale 1ns/1ps

class temp;
  bit [3: 0] a;
  function get_data(input bit [3: 0] a);
    this.a = a;
  endfunction
endclass

module tb();
  temp t1; // handler
  bit [3: 0] data;
  
  initial begin
    t1 = new();
    t1.get_data(4'b1010);
    data = t1.a;
    #10;
    $display("----------------");
    $display("value of the data member: %0b", data);
    $display("----------------");
    
    $dumpfile("dump.vcd"); 
    $dumpvars;
    #200;
    $finish();
  end
  
endmodule
