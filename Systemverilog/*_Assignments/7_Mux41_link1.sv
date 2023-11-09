class transaction;
  randc bit [15: 0] a, b, c, d;
  randc bit [1: 0] sel;
endclass:transaction

class generator;
  transaction t;
  mailbox mbx;
  event done;
  integer i;
  
  function new (mailbox mbx);
    this.mbx = mbx;
  endfunction
  
  task main();
    for (i = 0; i < 20; i++) begin
      t = new();
      t.randomize();
      mbx.put(t);
      $display("[GEN] SEND data to MBX as the following:");
      $display("a: %0h; b: %0h; c: %0h; d: %0h; sel: %0d;",
               t.a, t.b, t.c, t.d, t.sel);
      #1;
    end
    -> done;
  endtask
endclass:generator

class drive;
  transaction t;
  mailbox mbx;
  
  function new (mailbox mbx);
    this.mbx = mbx;
  endfunction
  
  task main();
    forever begin
      t = new();
      mbx.get(t);
      $display("[DRV] RCVD data from MBX as the following:");
      $display("a: %0h; b: %0h; c: %0h; d: %0h; sel: %0d;",
               t.a, t.b, t.c, t.d, t.sel);
      #1;
    end
  endtask
endclass:drive

module tb();
  transaction t;
  generator gen;
  drive drv;
  mailbox mbx;
  
  initial begin
    mbx = new();
    gen = new(mbx);
    drv = new(mbx);
    $display("----------------------------");
    fork
      gen.main();
      drv.main();
    join_any
      wait(gen.done.triggered);
    $display("----------------------------");
	$dumpfile("dump.vcd"); 
	$dumpvars;
  end
endmodule

