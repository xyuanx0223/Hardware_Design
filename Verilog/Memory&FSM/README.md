## Memory
### Method of implementation on FPGA
1) Memory resources: Block Memory
2) Logic resources: Distributed Memory( SliceL(multiple) & SliceM(only one) )

A) General code
B) Language template
C) IP

32 * 8 --> (depth(location) * size)
reg + size + memory instance name + depth
eg1: 32 * 8: reg [7: 0] mem [31: 0];
eg2: 128 * 16 reg [15: 0] mem [127: 0];

### RAM

### ROM
