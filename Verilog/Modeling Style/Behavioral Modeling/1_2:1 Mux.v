module 2_1_mux(
  input a, b, sel,
  output y
);
  assign y = sel? a: b;
endmodule
