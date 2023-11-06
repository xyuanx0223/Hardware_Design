module mux_2 (
  input a,
  input b,
  input sel,
  output out
);
  assign out = sel? a: b;
endmodule
