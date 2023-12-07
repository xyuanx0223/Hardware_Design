`timescale 1ns / 1ps
module top_ram(
    input clk,oe,wr,
    input [15:0] din,
    input [7:0] addr,
    output [15:0] dout
    );
reg [15:0] mem [255:0];
reg [15:0] temp; 
 
always@(posedge clk)
begin
if(wr == 1'b1)
  mem[addr] <= din;
else
  temp <= mem[addr];
end  
assign  dout = (oe == 1'b1) ? temp : 16'h0000; 
endmodule

///////////////////////////////////Testbench Code

module ram_tb();
 
reg clk;
reg wr;
reg oe;
reg [15:0] din;
reg [7:0] addr;
wire [15:0] dout;
reg [15:0] data [19:0];
reg [15:0] res;
integer err = 0;
 
initial begin
clk = 0;
oe = 0;
wr = 0;
end
 
top_ram dut (clk,oe,wr,din,addr,dout);
 
always #5 clk = ~clk;
 
integer i;
integer file;
integer rfile;
 
/////////////////Writing data to file
 
initial begin
 
file = $fopen("D:/Vitis_Vivado/project_26/project_26.srcs/sim_1/imports/Desktop/data.txt", "w");
for(i =0; i < 10 ; i = i + 1) begin
@(posedge clk);
wr = 1'b1;
oe = 1'b0;
addr = i;
din = $urandom();
$fdisplay(file, "%0x",din);
end
$fclose(file);
 
file = $fopen("D:/Vitis_Vivado/project_26/project_26.srcs/sim_1/imports/Desktop/data.txt", "r");
$readmemh("D:/Vitis_Vivado/project_26/project_26.srcs/sim_1/imports/Desktop/data.txt", data);
$fclose(file);
 
#10;
 
for(i =0; i < 10 ; i = i + 1) begin ////1, 3, 5, 7
@(posedge clk);
wr = 1'b0;
oe = 1'b1;
addr = i;
@(posedge clk);
res = data[i];
$display("%d %d", res,dout);
 
if(dout != res)
begin
err = err + 1;
end
end
 
if(err == 0)
$display("--------------TEST PASSED---------");
else
$display("--------------TEST FAILED---------");
 
end
endmodule
