module counter
(
input clk, rst,///active high
input ld,
input [3:0] ldvalue,
output [3:0] dout 
);
 
reg [3:0] temp;
 
initial begin
temp = 0;
end
 
//always@(posedge clk) /////////synchronus reset
//or
always@(posedge clk, posedge rst) /////////////asynchronus reset
begin
 if(rst == 1'b1)
   begin
   temp <= 4'b0000;
   end
 else 
     begin
       if(ld == 1'b1)
         temp <= ldvalue;
       else
         temp <= temp + 1;
     end
end 
assign dout = temp;
endmodule

////////////////TB code

`timescale 1ns / 1ps
 
module tb;
 
reg clk =0, rst = 0;
reg ld = 0;
reg [3:0] ldvalue;
wire [3:0] dout;
integer i =0;
 
counter dut (clk, rst, ld, ldvalue, dout);
 
always #5 clk = ~clk;
 
initial begin
rst = 1'b1;
#50;
rst = 1'b0;
end
 
task counter_test;
begin
@(posedge clk);
ld = 1'b1;
ldvalue = $urandom();
@(posedge clk);
ld = 1'b0;
repeat(10) @(posedge clk);
end
endtask
 
initial begin
#50;
for(i =0; i < 5; i = i+ 1)
begin
counter_test();
end
end
 
initial begin
#650;
$finish();
end 
endmodule
