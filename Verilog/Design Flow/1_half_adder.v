module half_adder(
    input a,b,
    output s,c
    );
assign s = a ^ b;
assign c = a & b; 
  // assign {c, s} = a + b;
endmodule
