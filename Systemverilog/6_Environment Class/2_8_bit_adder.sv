`timescale 1ns/1ps
 
module add(
input [7:0] a,b,
output [8:0] sum 
);
 
assign sum = a + b;
 
endmodule

class transaction;
  randc bit [7: 0] a;  
  randc bit [7: 0] b;
  bit [8: 0] sum;
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
    for(i = 0; i < 10; i++) begin      
      t.randomize();
      mbx.put(t);
      $display("[GEN] Send message to DRV.");
      @(done);
      #10;
    end
  endtask
endclass

interface add_intf();
  logic [7: 0] a;  
  logic [7: 0] b;
  logic [8: 0] sum;
endinterface

class driver;
  transaction t;
  mailbox mbx;
  event done;
  virtual add_intf vif;
  
  function new(mailbox mbx);
    this.mbx = mbx;
  endfunction
  
  task run();
    t = new();
    forever begin
      mbx.get(t);
      vif.a = t.a;      
      vif.b = t.b;
      $display("[DRV] Rcvd message from GEN");
      -> done;
      #10;
    end
  endtask
endclass

class monitor;
  transaction t;
  mailbox mbx;
  virtual add_intf vif;

  function new(mailbox mbx);
    this.mbx = mbx;
  endfunction
  
  task run();
    t = new();
    forever begin
      t.a = vif.a;      
      t.b = vif.b;
      t.sum = vif.sum;
      mbx.put(t);
      $display("[MON] Send message to SCO");
      #10;
    end
  endtask 
endclass

class scoreboard;
  transaction t;
  mailbox mbx;
  bit [8: 0] temp;

  function new(mailbox mbx);
    this.mbx = mbx;
  endfunction
  
  task run();
    t = new();
    forever begin
      mbx.get(t);
      temp = t.a + t.b;
      if(temp == t.sum)
        $display("[SCO] PASSED");
      else
        $display("[SCO] FAILED");
      #10;
    end
  endtask
endclass

class environment;
  generator gen;
  driver drv;
  monitor mon;
  scoreboard sco;
  
  mailbox gdmbx;
  mailbox msmbx;
  
  event gddone;
  virtual add_intf vif;

  function new(mailbox gdmbx, mailbox msmbx);
    this.gdmbx = gdmbx;    
    this.msmbx = msmbx;
    gen = new(gdmbx);
    drv = new(gdmbx);
    mon = new(msmbx);
    sco = new(msmbx);
  endfunction  
  
  task main();
    drv.vif = vif;
    mon.vif = vif;

    gen.done = gddone;
    drv.done = gddone; 
    
    fork
    gen.run();
    drv.run();
    mon.run();
    sco.run();
    join_any
  endtask
endclass

module tb();
  environment env;
  add_intf vif();
  
  mailbox gdmbx; 
  mailbox msmbx;
  
  add dut(vif.a, vif.b, vif.sum);
   
  initial begin
    gdmbx = new();
	msmbx = new();
    env = new(gdmbx, msmbx);
    env.vif = vif;
    env.main();
    #500;
    $finish;
  end
endmodule
