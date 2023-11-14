// Design a class with a 12-bit data member. Make the value of the data member local to the class. 
// Assume the user has a requirement to get access to the value of data member to perform some computation inside testbench, 
// Try to add a method to provide access to the value of the data member to the user.

// `timescale 1ns / 1ps

class access_data;
  local bit [11: 0] data = 12'h264;  
  
  function bit [11: 0] data_access();
    return this.data;
  endfunction
  
endclass:access_data

module tb();
  bit [11: 0] datarcvd;
  access_data a1;
  initial begin
    a1 = new();
    datarcvd = a1.data_access;
    #10;
    $display("----------------------------");
    $display("Value rcvd : %0x",datarcvd);
    $display("-----------------------------");
  end
endmodule
