`timescale 1ns/1ps

module mul(
  input [3: 0] a, b,
  output [7: 0] mul
);
  assign mul = a * b;
endmodule

class transaction;
  randc bit [3: 0] a;  
  randc bit [3: 0] b;
  bit [7: 0] mul;
endclass

class generator;
  transaction t;
  mailbox mbx;
  event done;
  integer i;
  
  function new(mailbox mbx);
    this.mbx = mbx;
  endfunction
  
  task run();
    t = new();
    for (i = 1; i < 10; i++) begin
      t.randomize();
      mbx.put(t);
      #10;
    end
    -> done;
  endtask
endclass

interface mul_intf();
  logic [3: 0] a, b;
  logic [7: 0] mul;
endinterface

class driver;
  transaction t;
  mailbox mbx;
  virtual mul_intf vif;
  
  function new (mailbox mbx);
    this.mbx =mbx;
  endfunction
  
  task run();
    forever begin
      t = new();
      mbx.get(t);
      vif.a = t.a;      
      vif.b = t.b;
      #10;
    end
  endtask
endclass

module tb();
  transaction t;
  generator gen;
  driver drv;
  mailbox mbx;
  
  mul_intf vif();
  
  mul dut (vif.a, vif.b, vif.mul);
  
  initial begin
    t = new();
    mbx = new();
    drv = new(mbx);    
    gen = new(mbx);
    fork
      gen.run();
      drv.run();
    join_any
    wait(gen.done.triggered);
  end
endmodule



