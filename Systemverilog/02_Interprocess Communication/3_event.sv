//`timescale 1ns/1ps

event a;

module tb();

  initial begin
    $display("-------------------------");
    fork
    // process 1
    begin
      // trigger event notion ->
      #10;    
      -> a;
    end
    // process 2
    begin
      @(a.triggered);
      $display("Event Triggered at %0t", $time);
    end

    join
    $display("All the process executed successfully at %0t", $time);  
    
    $display("-------------------------");
    $dumpfile("dump.vcd"); 
    $dumpvars;
    #100;
    $finish();
  end
  
endmodule
