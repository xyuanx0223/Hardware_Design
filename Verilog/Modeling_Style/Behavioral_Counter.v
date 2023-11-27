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
  always @ (posedge clk, posedge rst) begin
    if (rst) temp <= 4'b0;
    else begin
      if(ld) temp <= ldvalue;
      else temp <= temp + 4'b1;
    end
  end
  
  assign temp = dout;
endmodule
