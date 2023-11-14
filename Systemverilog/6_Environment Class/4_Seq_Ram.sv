module ram (
  input clk, rst, wr,
  input [7: 0] din,
  input [5: 0] addr,
  output reg [7: 0] dout
);
  
  reg [7: 0] mem[64];
  integer i;
  
  always @ (posedge clk) begin
    if (rst == 1'b1) begin
      for (i = 0; i < 64; i++) begin
        mem[i] <= 0;
      end
    end else begin
      if (wr == 1'b1) begin
        mem[addr] = din; 
      end else begin
        dout <= mem[addr];
      end
    end
  end
endmodule

class transaction;
  randc bit [7: 0] din;
  randc bit [5: 0] addr;
  bit [7: 0] dout;
  bit wr;
endclass

class generator;
  transaction t;
  mailbox mbx;
  integer i;
  event done;
  
  function new (mailbox mbx);
    this.mbx = mbx;
  endfunction
  
  task run();
    t = new();
    for (i = 0; i < 10; i++) begin
      t.randomize();
      mbx.put(t);
      $display("[GEN] pass data to DRV");
      @ (done)
    end
  endtask
endclass

interface ram_intf();
  logic clk, rst, wr,
  logic [7: 0] din,
  logic [5: 0] addr,
  logic [7: 0] dout
endinterface

class driver;
  transaction t;
  mailbox mbx;
  event done;
  
  virtual ram_intf vif;
  
  function new (mailbox mbx);
    this.mbx = mbx;
  endfunction
  
  task run();
    t = new();
    forever begin
      mbx.get(t);
      vif.din  = t.din;      
      vif.addr = t.addr;
      $display("[DRV] rcvd data from GEN");
      -> done;
      @ (posedge clk)
    end
  endtask
endclass

class monitor;
  transaction t;
  mailbox mbx;
  
  virtual ram_intf vif;
  
  function new (mailbox mbx);
    this.mbx = mbx;
  endfunction
  
  task run();
    t = new();
    forever begin
      t.din  = vif.din;      
      t.addr = vif.addr;
      t.dout = vif.dout;      
      t.wr   = vif.wr;
      mbx.put(t);
      $display("[MON] pass data to SCO");
      @ (posedge clk)
    end
  endtask
endclass

class scoreboard;
  transaction t;
  mailbox mbx;
  
  transaction tarr[256];
  
  function new (mailbox mbx);
    this.mbx = mbx;
  endfunction
  
  task run();
    t = new();
    forever begin
      mbx.get(t);
      if(t.wr == 1'b1) begin
        if(tarr[t.addr] == null) begin
           tarr[t.addr] = new();
           tarr[t.addr] = t;
           $display("[SCO] : Data stored");
        end
      end
      else begin
        if(tarr[t.addr] == null) begin
          if(t.dout == 0)
            $display("[SCO] : Data read Test Passed");
          else
            $display("[SCO] : Data read Test Failed"); 
          end
          else begin
            if(t.dout == tarr[t.addr].din)
              $display("[SCO] : Data read Test Passed");
            else
              $display("[SCO] : Data read Test Failed"); 
          end
      end
    end
  endtask
endclass

class environment;
  generator gen;
  driver drv;
  monitor mon;
  scoreboard sco;
  
  event gddone;
  virtual ram_intf vif;
  
  mailbox msmbx;
  mailbox gdmbx;
  
  function new (mailbox gdmbx, mailbox msmbx);
    this.gdmbx = gdmbx;
    this.msmbx = msmbx;
    gen = new(gdmbx);    
    drv = new(gdmbx);
    mon = new(msmbx);
    sco = new(msmbx);
  endfunction
  
  task run();
    mon.vif = vif;    
    drv.vif = vif;
	gen.done = gddone;	
    drv.done = gddone;
    fork
      gen.run();      
      drv.run();
      sco.run();
      mon.run();
    join_any
  endtask
endclass

module tb();
  environment env;
  mailbox gdmbx;  
  mailbox msmbx;
  
  ram_intf vif();
  ram dut (vif.clk, vif.rst, vif.wr, vif.din, vif.addr, vif.dout);
  
  always #5 vif.clk = ~vif.clk;
  
  initial begin
    vif.clk = 0;
    vif.rst = 1;
    vif.wr = 1;
    #50;
    vif.wr = 1;
    vif.rst = 0;
    #300;
    vif.wr = 0;
    #200
    vif.rst = 0;
    #50;
  end
  
  initial begin
    gdmbx = new();    
    msmbx = new();
    env = new(gdmbx, msmbx);
    env.vif = vif;
    env.run();
    #600;
    $finish;
  end
endmodules
