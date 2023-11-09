module add(
input [3:0] a,
input [3:0] b,
output [4:0] sum
);
assign sum = a + b;
endmodule
 
interface add_intf();
logic [3:0] a;
logic [3:0] b;
logic [4:0] sum;
endinterface
 
class driver;
virtual add_intf vif;
integer i;
task run();
for(i =0; i <10; i++) begin
vif.a = $random();
vif.b = $random();
#10;
end
endtask
endclass
 
 
module tb();
driver drv;
add_intf vif();
 
add dut (vif.a, vif.b, vif.sum);
initial begin
drv = new();
drv.vif = vif;
drv.run();
#10;
end
endmodule
