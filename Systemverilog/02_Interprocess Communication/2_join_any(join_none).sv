//`timescale 1ns/1ps

module tb();

  initial begin
    $display("-------------------------");
    fork
    begin
      $display("Process 1 at %0t", $time);
      #10;
    end
    begin
      #5;
      $display("Process 2 at %0t", $time);
      #10;
    end
    begin
      #20;
      $display("Process 3 at %0t", $time);
      #10;
    end
    // wait for no thread
    join_none
    // join_any
    $display("All the process are completed at %0t", $time);    
    $display("-------------------------");
    $dumpfile("dump.vcd"); 
    $dumpvars;
    #100;
    $finish();
  end
  
endmodule

