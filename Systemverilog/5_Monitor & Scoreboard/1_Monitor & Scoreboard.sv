class monitor;
  integer data = 12;
  mailbox mbx;
  
  function new (mailbox mbx);
    this.mbx = mbx;
  endfunction
  
  task run();
    mbx.put(data);
    $display ("[MON] : Data Transmitted to SCO");
    #10;
  endtask
endclass

class scoreboard;
  mailbox mbx;
  integer data;
  
  function new (mailbox mbx);
    this.mbx = mbx;
  endfunction
  
  task run();
    forever begin
      mbx.get(data);
      #10;
      $display ("[SCO] : Data RCVD from MON: %0d", data);
      if (data == 12)
        $display("PASS");
      else
        $display("FAILED");
    end
  endtask
endclass

module tb();
  mailbox mbx;
  scoreboard sco;
  monitor mon;
  initial begin
    mbx = new();
    mon = new(mbx);
    sco = new(mbx);
    fork
      mon.run();
      sco.run();
    join
  end
endmodule 
