module andtop(
  input  [7: 0] a, b,
  output [7: 0] y
);
  assign y = a & b;
endmodule

class transaction;
  randc bit [7: 0] a;  
  randc bit [7: 0] b;
  bit [7: 0] y;
endclass

class generator;
  transaction t;
  mailbox mbx;
  event done;
  integer i;
  
  function new (mailbox mbx);
    this.mbx = mbx;
  endfunction
  
  task run();
    t = new();
    for (i = 0; i < 10; i++) begin
      t.randomize();
      mbx.put(t);
      $display("[GEN] : Data send top DRV");
      @(done);
      #10;
    end
  endtask 
endclass

interface andtop_intf();
  logic [7: 0] a;  
  logic [7: 0] b;
  logic [7: 0] y;
endinterface

class driver;
  mailbox mbx;
  transaction t;
  event done;
  virtual andtop_intf vif;
  
  function new (mailbox mbx);
    this.mbx = mbx;
  endfunction
  
  task run();
    t = new();
    forever begin
      mbx.get(t);
      vif.a = t.a;      
      vif.b = t.b;
      $display("[DRV] : Trigger Interface");
      -> done;
      #10;
    end
  endtask
endclass

class monitor;
  virtual andtop_intf vif;
  mailbox mbx;
  transaction t;
  
  function new (mailbox mbx);
    this.mbx = mbx;
  endfunction
  
  task run();
    t = new();
    forever begin
      t.a = vif.a;      
      t.b = vif.b;
      t.y = vif.y;
      mbx.put(t);
      $display("[MON] : Data send to Scoreboard");
      #10;
    end
  endtask  
endclass
  
class scoreboard;
  mailbox mbx;
  transaction t;
  bit [7: 0] temp;
  
  function new(mailbox mbx);
    this.mbx = mbx;
  endfunction
  
  task run();
    t = new();
    forever begin 
      mbx.get(t);
      temp = t.a & t.b;
      if (t.y == temp) begin
        $display("[SCO] : Test Passed");
      end else begin
        $display("[SCO] : Test Failed");
      end
      #10;
    end
  endtask
endclass

class environment;
  generator  gen;
  driver     drv;
  monitor    mon;
  scoreboard sco;
  
  virtual andtop_intf vif;
  
  mailbox gdmbx;
  mailbox msmbx;

  event gddone;
  
  function new (mailbox gdmbx, mailbox msmbx);
    this.gdmbx = gdmbx;
    this.msmbx = msmbx;
    
    gen = new(gdmbx);    
    drv = new(gdmbx);
    
    mon = new(msmbx);
	sco = new(msmbx);
  endfunction
  
  task run();
    gen.done = gddone;
    drv.done = gddone;
    
    drv.vif = vif;
    mon.vif = vif;
  
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
  mailbox gdmbx;
  mailbox msmbx;
  
  andtop_intf vif();
  
  andtop dut(vif.a, vif.b, vif.y);
  
  initial begin
    gdmbx = new();    
    msmbx = new();
    env = new(gdmbx, msmbx);
    env.vif = vif;
    env.run();
    #200;
    $finish;
  end
endmodule
