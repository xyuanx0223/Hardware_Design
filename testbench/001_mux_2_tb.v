`timescale 1ns/1ns

module mux_2_tb();
  reg  s_a, s_b, sel;
  wire out;

  mux_2 mux_2_inst(
    .a(s_a),
    .b(s_b),
    .sel(sel),
    .out(out)
  );
  initial begin
    s_a = 0; s_b = 0; sel = 0;
    #200
    s_a = 0; s_b = 0; sel = 1;
    #200
    s_a = 0; s_b = 1; sel = 0;
    #200
    s_a = 0; s_b = 1; sel = 1;
    #200
    s_a = 1; s_b = 0; sel = 0;
    #200
    s_a = 1; s_b = 0; sel = 1;
    #200
    s_a = 1; s_b = 1; sel = 0;
    #200
    s_a = 1; s_b = 1; sel = 1;
    $stop;
  end
endmodule
