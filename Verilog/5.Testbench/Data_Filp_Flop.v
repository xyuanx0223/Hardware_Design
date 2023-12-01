module dff (
  input clk, din,
  output reg q, qbar
);
 
always@(posedge clk)
begin
q    <= din;
qbar <= ~din;
end
endmodule

///////////////////////////////Testbench Code:

`timescale 1ns / 1ps 
module tb;
 
reg clk = 0, din = 0;s
wire q, qbar;
integer i = 0;
 
dff dut (clk, din , q, qbar);
 
always #5 clk = ~clk;
 
initial begin 
for(i =0; i < 20; i= i+1)
begin
@(posedge clk);
din = $urandom();
end
end
 
initial begin
#250;
$finish();
end
endmodule
