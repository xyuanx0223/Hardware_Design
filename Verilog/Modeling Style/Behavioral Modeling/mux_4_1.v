module mux_4_1(
  input a, b, c, d,
  input [1: 0] sel,
  output y
);
  assign y = sel[1]? (~sel[0]? c: d): (~sel[0]? a: b);
endmodule
