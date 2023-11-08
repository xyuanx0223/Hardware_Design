//`timescale 1ns/1ps

class first;
  
  bit [7: 0] data;
  
  function get_data(bit [7: 0] a);
    this.data = a;
  endfunction
  
endclass: first

module tb();
  
  first f1; // handler
  bit [7: 0] datarcvd;
  
  initial begin
    f1 = new();
    f1.get_data(8'h34);
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
