// Create a class named first and add a 16-bit data member to it. 
// Use a constructor to assign the value 16'h1111 to the data member.

class first;
  bit [15:0] data;
  function new(bit [15:0] a);
    data = a;
  endfunction
endclass

module tb();
  first f1; //handler
  bit [15:0] datarcvd;
  initial begin
    f1 = new(16'h1111);
    datarcvd = f1.data;
    #10;
    $display("-----------------------");
    $display("Value rcvd : %0x", datarcvd);
    $display("-----------------------");
  end
endmodule
