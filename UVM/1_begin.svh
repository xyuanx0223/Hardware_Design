`include "uvm_macros.svh"
module tb;
   import uvm_pkg::*;
  
  initial begin
    `uvm_info("Test 1","Hello World", UVM_NONE);
     uvm_report_info("TEST 2", "This is Reporting", UVM_MEDIUM);
     uvm_report_info("TEST 2", "This is Reporting", UVM_FULL); 
  end
  
endmodule
