`timescale 1ns/1ps

module top(
  input [1: 0] a, b, c, d,
  input [1: 0] sel,
  output reg [1: 0] y
);
  always @ (*) begin
    if (sel == 2'b00) begin
      y = a;
    end
    else if (sel == 2'b01) begin
      y = b;
    end
    else if (sel == 2'b10) begin
      y = c;
    end
    else begin
      y = d;
    end
  end
endmodule

interface top_mux();
  logic [1: 0] a, b, c, d;
  logic [1: 0] sel;
  logic [1: 0] y;
endinterface

module tb();
  top_mux vif();
  top top_tb(.a(vif.a), .b(vif.b), .c(vif.c),
             .d(vif.d), .sel(vif.sel), .y(vif.y));
  integer i;
  initial begin
    for (i = 0; i < 10; i++) begin
      vif.a = $random();      
      vif.b = $random();
      vif.c = $random();
      vif.d = $random();
      vif.sel = $random();
      # 10;
      $display("a: %0d, b: %0d, c: %0d, d: %0d", vif.a, vif.b, vif.c, vif.d);
      $display("sel: %0d, y: %0d", vif.sel, vif.y);
    end
  end
endmodule

// #10;
// very important
