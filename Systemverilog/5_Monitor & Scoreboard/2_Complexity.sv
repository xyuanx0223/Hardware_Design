module andtop(
  input  [3: 0] a,b,
  output [3: 0] y
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
  transaction t;
  mailbox mbx;
  
  virtual andtop_intf vif;
  
  function new (mailbox mbx);
    this.mbx = mbx;
  endfunction
  
  task run();
    t = new();
    #10;
    t.a = vif.a;    
    t.b = vif.b;
    t.y = vif.y;
    mbx.put(t);
    $display ("[MON] : Data Transmitted to SCO");    
    $display ("[MON] : a: %Ob, b: %0b, y: %0b", vif.a, vif.b, vif.y);
  endtask
endclass

class scoreboard;
  mailbox mbx;
  transaction t;
  bit [3: 0] temp;
  
  function new (mailbox mbx);
    this.mbx = mbx;
  endfunction
  
  task run();
    t = new();
    #10;
    forever begin
      mbx.get(t);
      $display ("[SCO] : Data RCVDING from MON");
      temp = t.a & t.b;
      if (t.y == temp)
        $display("PASSED");
      else
        $display("FAILED");
    end
  endtask
endclass

module tb();
  mailbox mbx;
  scoreboard sco;
  monitor mon;
  transaction t;
  andtop_intf vif();
  
  andtop dut (vif.a, vif.b, vif.y);
  
  initial begin
    vif.a = 4'b1010;    
    vif.b = 4'b0111;
  end
  
  initial begin
    t = new();
    mbx = new();
    mon = new(mbx);
    sco = new(mbx);
    mon.vif = vif;
    fork
      mon.run();
      sco.run();
    join
  end
endmodule
