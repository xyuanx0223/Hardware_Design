//`timescale 1ns/1ps

class data_function;
  bit [3: 0] data1;
  bit [3: 0] data2;
  
  function new(input bit [3: 0] a, input bit [3: 0] b);
    this.data1 = a;
    this.data2 = b;
  endfunction
  
  extern function void display();
  
endclass: data_function

function void data_function::display();
  $display("---------------------");
  $display("value of data member 1: %0b and data member 2 : %0b",
           data1, data2);
  $display("---------------------");
endfunction

module tb();
  data_function d1; // handler
  
  initial begin
    d1 = new(4'b1111, 4'b1010);
    #10;
    d1.display();
    $dumpfile("dump.vcd"); 
    $dumpvars;
    #200;
    $finish();
  end
  
endmodule
