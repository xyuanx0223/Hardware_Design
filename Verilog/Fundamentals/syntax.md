# identifiers & number format
eg: Module __;
1) Must always start with an alphabet
2) alphabet, numbers, _
Verilog is case-sensitive  & SystemVerilog isn't case-sensitive

size of the variable + radix + value
eg: reg [3:0] a = 4'd12;
Decimal     == d
Binary      == b
Octal       == o
Hexadecimal == h

# reg & wire
Reg type has a history & Wire doesn't have a history
1) Procedural assignment
   reg
   left hand side = expression
3) Continuous assignment
   wire

single  bit: reg a;             wire b;
multi   bit: reg [n-1 : 0] a;   wire [n-1 : 0] b;
