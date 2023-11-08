//`timescale 1ns/1ps

event a;

module tb();
  
  mailbox mail;
  integer i;
  integer data;

  initial begin
    $display("-------------------------");
    mail = new();
    for (i = 0; i < 10; i++) begin
      mail.put(i);
      $display("Data inside mailbox : %0d", i);
      #1;
    end
  end
  
  initial begin
    forever begin
      mail.get(data);
      $display("value rcvd : %0d", data);
      #1;
    end
  end
  
  initial begin
    $display("-------------------------");
    $dumpfile("dump.vcd"); 
    $dumpvars;
    #100;
    $finish();
  end
  
endmodule
