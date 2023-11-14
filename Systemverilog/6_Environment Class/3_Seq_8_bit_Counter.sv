module counter(
  input clk, rst, up, load,
  input  [7: 0] loadin,
  output reg [7:0] dout
);

  always @ (posedge clk) begin
    if (rst == 1'b1)
      dout <= 8'b0;
    else if (load == 1'b1)
      dout <= loadin;
    else begin
      if (up == 1'b1) dout <= dout + 1'b1;      
      else dout <= dout - 1'b1;
    end
  end
  
endmodule

class transaction;
  randc bit [7: 0] loadin;
  bit [7: 0] dout;
endclass

class generator;
  mailbox mbx;
  transaction t;
  event done;
  
  function new(mailbox mbx);
    this.mbx = mbx;
  endfunction
  
  task run();
    t = new();
    t.randomize();
    mbx.put(t);
    $display("[GEN] send data to drv");
    @(done);
  endtask
endclass

interface counter_intf();
  logic clk, rst, up, load;
  logic [7: 0] loadin;
  logic [7:0] dout;
endinterface

class driver;
  mailbox mbx;
  transaction t;
  event done;
  virtual counter_intf vif;
  
  function new(mailbox mbx);
    this.mbx = mbx;
  endfunction
  
  task run();
    t = new();
	forever begin
      mbx.get(t);
      vif.loadin = t.loadin;
      $display("[DRV] interface triggered"); 
      -> done;
      @(posedge vif.clk);
    end
  endtask
endclass

class monitor;
  mailbox mbx;
  transaction t;
  virtual counter_intf vif;
  
  function new(mailbox mbx);
    this.mbx = mbx;
  endfunction
  
  task run();
    t = new();
	forever begin
      t.loadin = vif.loadin;
      t.dout = vif.dout;
      mbx.put(t);
      $display("[MON] send data to sco"); 
      @(posedge vif.clk);
    end
  endtask
endclass

class scoreboard;
  mailbox mbx;
  transaction t;
  bit [7:0] temp;
  
  function new(mailbox mbx);
    this.mbx = mbx;
  endfunction
  
  task run();
    t = new();
	forever begin
      mbx.get(t);
      $display("[SCO] data rcvd"); 
    end
  endtask
endclass

class environment;
  mailbox gdmbx;
  mailbox msmbx;
  
  generator gen;
  driver drv;
  monitor mon;
  scoreboard sco;
  event gddone;
  
  virtual counter_intf vif;
  
  function new(mailbox gdmbx, mailbox msmbx);
    this.gdmbx = gdmbx;    
    this.msmbx = msmbx;
    gen = new(gdmbx);
	drv = new(gdmbx);
    mon = new(msmbx);
    sco = new(msmbx);
  endfunction
  
  task run();
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
  counter_intf vif();
  environment env;
  
  mailbox gdmbx;
  mailbox msmbx;
  
  counter dut(vif.clk, vif.rst, vif.up, vif.load, vif.loadin, vif.dout);
  
  always #5 vif.clk = ~vif.clk;
  
  initial begin
    vif.clk  = 0;    
    vif.rst  = 1;
    vif.up   = 0;
    vif.load = 0;
    #20;
	vif.load = 1;
    #50;
	vif.load = 0;    
    #100;
	vif.rst  = 0;    
    #100;
	vif.up = 1;
    #100;
	vif.up = 0;
  end
  
  initial begin
    gdmbx = new();    
    msmbx = new();
    env = new(gdmbx, msmbx);
    env.vif = vif;
    env.run();
    #500;
    $finish;
  end
endmodule
