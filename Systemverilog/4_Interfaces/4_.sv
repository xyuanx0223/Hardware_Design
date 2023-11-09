module fa(
  input clk, rst, up,
  output reg [3: 0] cout
);
  always @ (posedge clk) begin
    if (rst) cout <= 4'b0;
    else begin
      if (up) cout <= cout + 4'b1;
      else cout <= cout - 4'b1;
    end
  end
endmodule

interface fa_intf();
  logic clk, rst, up;
  logic [3: 0] cout;
endinterface

module tb();
  fa_intf vif();

  initial begin
    vif.clk = 1'b0;
    vif.rst = 1'b0;
  end
  
  always #5 vif.clk = ~vif.clk;
    
  initial begin
    vif.rst = 1'b1;
    #50;
    vif.rst = 1'b0;
  end
  
  fa dut(vif.clk, vif.rst, vif.up, vif.cout);
    
  initial begin
    #10;
    vif.up = 1'b1;
    #200;
    vif.up = 1'b0;
    #200;
    $finish;
  end
endmodule
