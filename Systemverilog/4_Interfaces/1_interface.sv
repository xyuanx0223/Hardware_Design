interface mux();
  logic [1: 0] a;  
  logic [1: 0] b;
  logic [1: 0] c;
endinterface

module tb();
  mux vif();
  initial begin
    vif.a = $random();    
    vif.b = $random();
    $display("The number of data in vif a: %0b, b: %0b.",
            vif.a, vif.b);
  end
endmodule
