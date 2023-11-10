module andtop(
  input  [3:0] a,b,
  output [3:0] y
);
  assign y = a & b;
endmodule

interface andtop_intf();
  logic [3: 0] a;  
  logic [3: 0] b;  
  logic [3: 0] y;
endinterface

class transaction;
  bit [3: 0] a;  
  bit [3: 0] b;  
  bit [3: 0] y;
endclass

class monitor;
  mailbox mbx;
  transaction t;
  integer i;
  virtual andtop_intf vif;
  
  function new (mailbox mbx);
    this.mbx = mbx;
  endfunction
  
  task run ();
    t = new();
    t.a = vif.a;    
    t.b = vif.b;
    t.y = vif.y;
    mbx.put(t);
    #10;
    $display("[MON] RCVD data");
    $display("[MON] a: %0d, b: %0d, y: %0d", vif.a, vif.b, vif.y);
  endtask  
endclass

class scoreboard;
  mailbox mbx;
  transaction t;
  bit [3: 0] temp;
  
  function new (mailbox mbx);
    this.mbx = mbx;
  endfunction
  
  task run ();
    t = new();
    forever begin
      mbx.get(t);
      #10;
      $display("[SCO] : a : %0b , b : %0b and y : %0b",t.a, t.b, t.y);
      temp = t.a & t.b;
      #10;
      if (temp == t.y)
        $display("PASSED");
      else
        $display("FAILED");
    end
  endtask
endclass

module tb();
  mailbox mbx;
  transaction t;
  scoreboard sco;
  monitor mon;
  
  andtop_intf vif();
  integer i;
  andtop dut(vif.a, vif.b, vif.y);

  initial begin
    for (i = 0; i < 25; i++) begin
      vif.a=$random;
      vif.b=$random;
      t = new();
      mbx = new();
      mon = new(mbx);
      sco = new(mbx);
    
      mon.vif = vif;
	  #10;
      fork
        sco.run();
        mon.run();
      join_any
    end
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
endmodule
