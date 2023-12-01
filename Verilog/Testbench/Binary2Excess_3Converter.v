module bin_to_xs3(
  input  [3:0] a,
  output reg [4:0] y
);
 
always@(*)begin
y = {1'b0,a} + 5'b00011;
end 
endmodule

////////////////////////////Testbench Code

`timescale 1ns / 1ps
 
module tb;
reg [3:0] a = 0;
wire [4:0] y;
integer i =0;
 
bin_to_xs3 dut (a, y);
 
initial begin
for( i = 0; i < 20; i = i + 1)begin
a = $urandom();
#10;
$display("Value of I/P : %0d and O/P : %0d", a, y);
end
end
endmodule
