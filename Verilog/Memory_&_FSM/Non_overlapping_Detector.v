module fsm(
  input clk, rst, din,
  output reg dout
);
  parameter idle = 0;
  parameter s0 = 1;  
  parameter s1 = 2;
  parameter s2 = 3;
  
  reg [1: 0] state = idle;
  
  always @ (posedge clk) begin
    case(state)
      idle: begin
        dout <= 1'b0;
        if(rst) state <= idle;
        else state <= s0;
      end
      s0: begin
        if(din) begin
          dout <= 1'b0;
          state <= s1;
        end
        else begin
          dout <= 1'b0;
          state <= s0;
        end
      end
      s1: begin
        if(din) begin
          dout <= 1'b0;
          state <= s2;
        end
        else begin
          dout <= 1'b0;
          state <= s0;
        end
      end
      s2: begin
        if(din) begin
          dout <= 1'b1;
          state <= idle;
        end
        else begin
          dout <= 1'b0;
          state <= s0;
        end
      end
      default: begin
        dout <= 1'b0;
        state <= idle;
      end
    endcase
  end

endmodule
