module ram(
input clk, rst, wr,
input [7:0] din, addr,
output reg [7:0] dout
);
reg [7:0] mem [256];
integer i;
 
always@(posedge clk)
begin
if(rst == 1'b1) begin
for( i = 0; i < 256; i++)
begin
mem[i] <= 0;
end
end
else if(wr == 1'b1)
mem[addr] <= din;
else
dout <= mem[addr];
end
endmodule
 
 
class transaction;
rand bit [7:0] din;
randc bit [7:0] addr;
bit wr;
bit [7:0] dout;
 
constraint addr_c {addr > 10; addr < 20;};
endclass
 
class generator;
mailbox mbx;
transaction t;
event done;
integer i;
 
function new(mailbox mbx);
this.mbx = mbx;
endfunction
 
task run();
t = new();
for(i = 0; i < 100; i++)begin
t.randomize();
mbx.put(t);
$display("[GEN] : Data send to driver din : %0d addr : %0d", t.din, t.addr);
@(done);
end
endtask
endclass
 
 
interface counter_intf();
logic clk,rst, wr;
logic [7:0] din, addr;
logic [7:0] dout;
endinterface
 
class driver;
mailbox mbx;
event done;
transaction t;
virtual counter_intf vif;
 
function new(mailbox mbx);
this.mbx = mbx;
endfunction
 
task run();
t = new();
forever begin
mbx.get(t);
vif.din = t.din;
vif.addr = t.addr;
$display("[DRV] : Interface Trigger wr: %0b din : %0d addr : %0d", vif.wr , t.din, t.addr);
@(posedge vif.clk);
 
if(vif.wr == 1'b1)
begin
@(posedge vif.clk);
end
 
if(vif.wr == 1'b0)
begin
@(posedge vif.clk);
end
 
->done;
end
endtask
endclass  
 
class monitor;
mailbox mbx;
virtual counter_intf vif;
transaction t;
 
function new(mailbox mbx);
this.mbx = mbx;
endfunction
 
task run();
t = new();
forever begin
@(posedge vif.clk);
 
if(vif.wr == 1'b1) begin
@(posedge vif.clk);
t.din = vif.din;
t.addr = vif.addr;
t.dout = 0;
t.wr = vif.wr;
end
 
if(vif.wr == 1'b0) begin
@(posedge vif.clk);
t.din = vif.din;
t.addr = vif.addr;
t.dout = vif.dout;
t.wr = vif.wr;
end
 
mbx.put(t);
$display("[MON] : data send to Scoreboard wr :%0b din : %0d addr: %0d dout:%0d", t.wr, t.din, t.addr, t.dout);
end
endtask
endclass
 
class scoreboard;
mailbox mbx;
reg [7:0] tarr[256] = '{default:0};
transaction t;
 
function new(mailbox mbx);
this.mbx = mbx;
endfunction
 
task run();
forever begin
mbx.get(t);
$display("[SCO] : Data rcvd wr :%0b din : %0d addr: %0d dout:%0d", t.wr, t.din, t.addr, t.dout);
 
if(t.wr == 1'b1) begin
tarr[t.addr] = t.din;
$display("[SCO] : Data Stored din : %0d addr: %0d",  t.din, t.addr);
end
 
if(t.wr == 1'b0) begin
  if(t.dout == 0)
   $display("[SCO]: Not Written any data at this location on RAM Test Passed");
  else if (t.dout == tarr[t.addr])
   $display("[SCO] : Valid Data written at this Location Test Passed");
  else
    $display("[SCO]: Test Failed");
end
 
 
/*
if(t.wr == 1'b1) begin
  if(tarr[t.addr] == null) begin
     tarr[t.addr] = new();
     tarr[t.addr] = t;
     $display("[SCO] : Data stored");
     end
    end
 else begin
   if(tarr[t.addr] == null) begin
     if(t.dout == 0) 
       $display("[SCO] : Data read Test Passed");
     else
       $display("[SCO] : Data read Test Failed"); 
    end
    else begin
      if(t.dout == tarr[t.addr].din)
       $display("[SCO] : Data read Test Passed");
       else
       $display("[SCO] : Data read Test Failed"); 
    end
    end
*/    
end
endtask
endclass
 
class environment;
generator gen;
driver drv;
monitor mon;
scoreboard sco;
 
virtual counter_intf vif;
 
mailbox gdmbx;
mailbox msmbx;
 
event gddone;
 
function new(mailbox gdmbx, mailbox msmbx);
this.gdmbx = gdmbx;
this.msmbx = msmbx;
 
gen = new(gdmbx);
drv = new(gdmbx);
 
mon = new(msmbx);
sco = new(msmbx);
endfunction
 
task run();
gen.done = gddone;
drv.done = gddone;
 
drv.vif = vif;
mon.vif = vif;
 
fork 
gen.run();
drv.run();
mon.run();
sco.run();
join_any
 
endtask
 
endclass
 
module tb;
 
environment env;
counter_intf vif();
mailbox gdmbx, msmbx;
 
ram dut (vif.clk, vif.rst, vif.wr, vif.din, vif.addr, vif.dout);
 
always #5 vif.clk = ~vif.clk;
 
 
initial begin
vif.clk = 0;
vif.rst = 1;
#50;
vif.wr = 1;
vif.rst = 0;
#300;
vif.wr = 0;
#300;
end
 
initial begin
gdmbx = new();
msmbx = new();
 
env = new(gdmbx,msmbx);
env.vif = vif;
#50;
env.run();
#600;
$finish;
end
endmodule
