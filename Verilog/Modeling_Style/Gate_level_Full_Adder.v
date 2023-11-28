module fa(
  input a, b, cin,
  output cout, s
);
  wire t1, t2, t3;
  // wire [3:0] temp;
  /*
  assign t1 = a ^ b;    
  assign t2 = t1 & cin;  
  assign t3 = a & b;  
  assign s  = t1 ^ cin;  
  assign cout = t2 | t3;
  */
  xor x1 (t1, a, b);
  xor x2 (s, t1, cin);
  and a1 (t2, cin, t1);
  and a2 (t3, a, b);
  or  o1 (cout, t2, t3);
endmodule
