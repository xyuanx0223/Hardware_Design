module dff(
  input clk,
  input din,
  output reg q,
  output reg q_bar,
);
  always @ (posedge clk) begin
    q <= din;
    q_bar <= ~din;
  end
endmodule
