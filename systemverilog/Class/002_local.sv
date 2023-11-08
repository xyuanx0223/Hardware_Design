//`timescale 1ns/1ps

class data_hide;
  // local modifier to hide the data
  local bit [3: 0] data = 4'b1111;
  
  function void data_hide_value();
    $display("----------------------");
    $display("value of the data: %0b", this.data);
    $display("----------------------");    
  endfunction
  
endclass
 
module tb();
  
  data_hide d1; // handler
  bit [3: 0] dr;
  
  initial begin
    d1 = new();
    #10;
    d1.data_hide_value();
  end
  

  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;
    #200;
    $finish();
  end
  
endmodule
