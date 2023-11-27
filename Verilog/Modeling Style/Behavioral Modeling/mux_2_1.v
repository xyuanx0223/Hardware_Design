module mux_2_1(
  input a, b, sel,
  output y
);
  assign y = sel? a: b;
endmodule
