//`timescale 1ns/1ps

class first;
  
  bit [7: 0] data;
 // function 
  function new(bit [7: 0] a);
    data = a;
  endfunction
  
endclass: first

module tb();
  
  first f1;
  bit [7: 0] datarcvd;
  
  initial begin
    f1 = new(8'h33);
    
    datarcvd = f1.data;
    #10;
    $display("----------------");
    $display("value rcvd: %0x", datarcvd);
    $display("----------------");
  end
  

  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;
    #200;
    $finish();
  end
  
endmodule
