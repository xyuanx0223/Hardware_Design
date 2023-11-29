module counter(
  input clk, rst,
  output reg [1:0] doutr, doutj
);
  always @ (posedge clk) begin
    if (rst) doutr <= 2'b01;
    else begin
      doutr[1] <= doutr[0];
      doutr[0] <= doutr[1];
    end
  end
  
  always @ (posedge clk) begin
    if (rst) doutj <= 2'b00;
    else begin
      doutj[1] <= ~doutj[0];
      doutj[0] <= doutj[1];
    end
  end
endmodule
