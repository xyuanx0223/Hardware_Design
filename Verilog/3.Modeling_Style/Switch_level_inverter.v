// not synthesizable
module inverter(
  input vin,
  output vout
);
  supply1 vdd;
  supply0 gnd;
  
  pmos p1(vout, vdd, vin);
  nmos n1(vout, gnd, vin);
  
endmodule
