// Create a class adder that consists of two data members each of size 14-bit. 
// Create two functions inside the class, one will receive the two arguments from the user and update data members 
// while the other will return the result of the addition of data members.

class adder();
  bit [13: 0] add_a; 
  bit [13: 0] add_b; 
  
  function [14: 0] sum();
    return add_a + add_b;
  endfunction
  
  function void get_data(input [13: 0] a, b);
    this.add_a = a;
    this.add_b = b;
  endfunction
  
endclass:adder

module tb();
  bit [14: 0] datarcvd;
  adder a1;
  initial begin
    a1 = new();
    a1.get_data(14'h1, 14'h1);
    datarcvd = a1.sum();
    #10;
    $display("----------------------------");
    $display("Value rcvd : %0x",datarcvd);
    $display("-----------------------------");
  end
endmodule
