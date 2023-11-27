# Identifiers & Number format
eg: Module __;
1) Must always start with an alphabet
2) Naming scheme
alphabet, numbers, _
3) Verilog is case-sensitive & SystemVerilog isn't case-sensitive

size of the variable + radix + value
eg: reg [3:0] a = 4'd12;
Decimal     == d
Binary      == b
Octal       == o
Hexadecimal == h

# Reg & Wire
Reg type has a history & Wire doesn't have a history
1) Procedural assignment
   reg type only
   left hand side = expression
3) Continuous assignment
   wire type only

Single-bit: reg a;             wire b;
Multi-bit:  reg [n-1 : 0] a;   wire [n-1 : 0] b;

# Veilog data type
1) Synthesizable: Hardware/RTL
unsigned: reg/ signed: integer (default 32-bit)
2) Simulation
time <- (10 ns, 10.13 ns) -> realtime
the floating type comes into play

# Reporting Mechanism 
1) $display();
can only observe the previous value of the non-blocking assignment
but can observe the updated value of Continuous & Blocking Assignment
Sequence：
| ------------------------ |
| Continuous    Assignment |
| Blocking      Assignment |
| $display();              |
| Nonblocking   Assignment |
| $monitor();              |
| $strobe ();              |
| ------------------------ |
2) $monitor();
report the value only when updated
can only be added once in the execution
3) $strobe();

$display is very simple like printf in C. It prints when that piece of code gets executed. 
$monitor is when any variable specified in the RHS changes it gets printed. Basically $monitor monitors continuously, and displays every time one of its display parameters changes.
$strobe prints the actual value at the end of each time step. $strobe executes in MONITOR/POSTPONE region, that is, at the end of the time stamp. Hence the updated value is shown by $strobe.

# Blocking & Nonblocking Assignment 
