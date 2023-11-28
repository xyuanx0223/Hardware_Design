module nand2(
  input a, b,
  output c
);
  supply1 vdd;
  supply0 gnd;
  wire t1;
  
  pmos p1(c, vdd, a);
  pmos p2(c, vdd, b);
  
  nmos n1(t1, gnd, a);
  nmos n2(c,  t1,  b);
  
endmodule

//And_gate
module and2(
  input a, b,
  output c
);
  supply1 vdd;
  supply0 gnd;
  wire t1;s
  
  pmos p1(t1, vdd, a);
  pmos p2(c,  t1,  b);
  
  nmos n1(c, gnd, a);
  nmos n2(c, gnd, b);
  
endmodule

/*And_gate
module nand2 (
  input a,b,
  output y
);
 
supply1 vdd;
supply0 gnd;
wire t1;
wire t2;
 
pmos p1 (t2, vdd, a);
pmos p2 (t2, vdd, b);
 
nmos n1 (t2, t1, a);
nmos n2 (t1, gnd, b);
 
pmos p3 (y, vdd, t2);
nmos n3 (y, gnd, t2);
 
endmodule 
*/
