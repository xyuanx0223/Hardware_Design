interface test();
  logic [3: 0] a;  
  logic [3: 0] b;
endinterface

class driver;
  virtual test vif;
  
  task run();
    vif.a = $random();
    vif.b = $random();
  endtask
endclass

module tb();
  test vif();
  driver drv;
  logic [3: 0] da, db;
  
  initial begin
    drv = new();
    drv.vif = vif;
    drv.run();
    #10;
    da = vif.a;    
    db = vif.b;
    $display("value of a: %0d and b: %0d", da, db);   
  end
endmodule
