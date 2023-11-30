module fsm(
    input clk, rst, din,
    output reg dout
    );
parameter idle = 0;
parameter s0 = 1;
parameter s1 = 2; 
 
reg [1:0] state = idle;   
    
/////one process methodology 
 
always@(posedge clk)
begin
 
if(rst == 1'b1)
  begin
  dout <= 1'b0;
  state <= idle;
  end
else
  begin
 
       case(state)
            idle: begin
                 dout  <= 1'b0;
                 state <= s0;
                 end
             
            s0: begin
               dout <= 1'b0;
               if(din == 1'b1) 
                 begin
                 state <= s1;
                 dout <= 1'b1;
                 end
               else
                begin
                 state <= s0;
                end
            end
             
            s1 : begin
              dout <= 1'b1;
                 if(din == 1'b1)
                 begin
                 state <= s0;
                 dout  <= 1'b0; 
                 end
               else
                 begin
                 state <= s1;
                 end
            end
             
            default : begin 
                 state <= idle;
                 dout  <= 1'b0;
            end             
            endcase
  end
end
    
endmodule
Testbench Code :

module tb(
);
 
reg clk = 0, rst = 0, din = 0;
wire dout;
integer i = 0;
 
 
fsm dut (clk,rst,din,dout);
 
always #10 clk = ~clk;
 
initial begin
rst = 1;
#40;
rst = 0;
end
 
initial begin
#40;
for(i = 0; i < 10; i = i + 1)
begin
din = 1;
@(posedge clk);
din = 0;
@(posedge clk);
end
end
 
initial begin
#500;
$finish;
end
 
endmodule
