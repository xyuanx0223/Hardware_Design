module fa(
  input a, b, cin,
  output cout, s
);
  wire t1, t2, t3;
  // wire [3:0] temp;
  assign t1 = a ^ b;    
  assign t2 = t1 & cin;  
  assign t3 = a & b;  
  assign s  = t1 ^ cin;  
  assign cout = t2 | t3;
endmodule
