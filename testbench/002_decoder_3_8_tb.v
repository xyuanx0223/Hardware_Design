`timescale 1ns/1ns

module 002_decoder_3_8_tb();
  
  reg s_a, s_b, s_c;
  wire [7: 0] out;
  
  decoder_3_8_tb 002_decoder_3_8_inst(
    .a(s_a),
    .b(s_b),
    .c(s_c),
    .out(out)
  );

  initial begin
    s_a = 0; s_b = 0; sel = 0;
    #200;
    s_a = 0; s_b = 0; sel = 1;
    #200;
    s_a = 0; s_b = 1; sel = 0;
    #200;
    s_a = 0; s_b = 1; sel = 1;
    #200;
    s_a = 1; s_b = 0; sel = 0;
    #200;
    s_a = 1; s_b = 0; sel = 1;
    #200;
    s_a = 1; s_b = 1; sel = 0;
    #200;
    s_a = 1; s_b = 1; sel = 1;
    $stop;
  end
  
endmodule
