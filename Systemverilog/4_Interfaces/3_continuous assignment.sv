module fa(
  input a, b, cin,
  output s, cout
);
  assign s = a ^ b ^ cin;
  assign cout = (a & cin) | (b & cin) | (a & b);
endmodule

interface fa_intf();
  logic a, b, cin;
  logic s, cout;
endinterface

module tb();
  fa_intf vif();
  fa dut (.a(vif.a), .b(vif.b), .cin(vif.cin), .s(vif.s), .cout(vif.cout));
  initial begin
    vif.a = 1;
    vif.b = 0;
    vif.cin = 0;
    # 10;
    vif.a = 0;
    vif.b = 0;
    vif.cin = 0;
    # 10;
    vif.a = 1;
    vif.b = 1;
    vif.cin = 1;
    # 10;
    vif.a = 1;
    vif.b = 0;
    vif.cin= 1;
    # 10;
  end
endmodule

//tcl console: creat_wave_config
