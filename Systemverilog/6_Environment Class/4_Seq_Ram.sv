module ram (
  input clk, rst, wr,
  input [7: 0] din,
  input [5: 0] addr,
  output reg [7: 0] dout
);
  
  reg [7: 0] mem[64];
  integer i;
  
  always @ (posedge clk) begin
    if (rst == 1'b1) begin
      for (i = 0; i < 64; i++) begin
        mem[i] <= 0;
      end
    end else begin
      if (wr == 1'b1) begin
        mem[addr] = din; 
      end else begin
        dout <= mem[addr];
      end
    end
  end
endmodule
