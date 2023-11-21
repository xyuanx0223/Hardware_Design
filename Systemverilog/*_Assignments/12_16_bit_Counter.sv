//Design SV testbench for the 16-bit Counter

`timescale 1ns/1ps

module counter(
input clk, rst, up, load,
input [15:0] loadin,
output reg [15:0] y
);

always@(posedge clk) begin
if(rst == 1'b1) y <= 16'b0000_0000_0000_0000;
else if (load == 1'b1) y <= loadin;
else begin
if(up == 1'b1) y <= y + 1;
else y <= y - 1;
end
end
endmodule


class transaction;
randc bit [15:0] loadin;
rand bit up;
bit [15:0] y;
endclass: transaction



class generator;
transaction t;
mailbox mbx;
event done;
function new(mailbox mbx);
this.mbx = mbx;
endfunction
task run();
t = new();
forever begin
//Generate the random stimulus for loadin and up
if(t.randomize()) $display("Randomization works");
else $fatal("Randomization is in error");
mbx.put(t);
$display("[GEN]: Data send to Driver");
@(done); //wait until done signal from driver
end
endtask: run
endclass: generator


interface intf_counter();
logic clk, rst, up, load;
logic [15:0] loadin;
logic [15:0] y;
endinterface: intf_counter

class driver;
transaction t;
mailbox mbx;
virtual intf_counter vif;
event done;
function new(mailbox mbx);
this.mbx = mbx;
endfunction
task run();
t = new();
forever begin
mbx.get(t);
vif.loadin = t.loadin;
vif.up = t.up;
$display("[DRV] : Trigger Interface");
@(posedge vif.clk) -> done;
end
endtask: run
endclass: driver


class monitor;
transaction t;
mailbox mbx;
virtual intf_counter vif;
function new(mailbox mbx);
this.mbx = mbx;
endfunction
task run();
t = new();
forever begin
t.loadin = vif.loadin;
t.y = vif.y;
mbx.put(t);
$display("[MON] : Data send to Scoreboard");
@(posedge vif.clk);
end
endtask: run
endclass: monitor

class scoreboard;
transaction t;
mailbox mbx;
function new(mailbox mbx);
this.mbx = mbx;
endfunction
task run();
t = new();
forever begin
mbx.get(t);
$display("[SCO] : Rcvd data from Monitor");
end
endtask: run
endclass: scoreboard

class environment;
generator gen;
driver drv;
monitor mon;
scoreboard sco;
mailbox gdmbx, msmbx;
virtual intf_counter vif;
event gddone;
//specify the mailbox
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
join_none;
endtask: run
endclass: environment

module tb();
environment env;
mailbox gdmbx, msmbx;
intf_counter vif();
counter iDUT (.clk(vif.clk), .rst(vif.rst), .up(vif.up), .load(vif.load), .loadin(vif.loadin), .y(vif.y));

//set clk
always #5 vif.clk = ~vif.clk;
//set clk, rst, load
initial begin
vif.clk = 0;
vif.rst = 1;
vif.load = 0;
#100;
vif.load = 1;
#50;
vif.rst = 0;
#100;
vif.load = 0;
#700;
end

initial begin
gdmbx = new();
msmbx = new();
env = new(gdmbx, msmbx);
env.vif = vif;
env.run();
#1000;
$finish;
end
endmodule: tb
