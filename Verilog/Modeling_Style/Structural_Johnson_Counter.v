// Design 4-bit Johnson Counter using Structural Modeling style.

module johnson(
input clk, rst,
output [3:0] count, count_bar
);

dff d0 (clk, count_bar[3], rst, count[0], count_bar[0]);
dff d1 (clk, count[0], rst, count[1], count_bar[1]);
dff d2 (clk, count[1], rst, count[2], count_bar[2]);
dff d3 (clk, count[2], rst, count[3], count_bar[3]);

endmodule

module dff(
input clk, din, rst,
output reg q, qbar
);

always@(posedge clk, posedge rst)
if (rst == 1'b1)
begin
q <= 1'b0;
qbar <= 1'b1;
end
else
begin
q <= din;
qbar <= ~din;
end
endmodule
