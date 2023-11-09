// Create a random stimulus for the 4-bit ALU

class transaction;
  randc bit [3:0]in1,in2;
  randc bit [1:0]opsel;
  bit [4:0]add, sub;
  bit [7:0]mul;
endclass

module alu_tb();
  transaction t1;
  integer i;
  initial begin
    t1 = new();
    for (i = 0; i < 15; i++) begin
      t1.randomize();
      #20;
      $display ("Iteration =  %0d : INPUTS IN1 = %0d, IN2 = %0d OPCODE SELECTION : %0d",
                i,t1.in1,t1.in2,t1.opsel);
    end
  end
endmodule
