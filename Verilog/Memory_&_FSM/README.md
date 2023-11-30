## Memory
### RAM & ROM
1) Memory resources: Block Memory
2) Logic resources: Distributed Memory( SliceL(multiple) & SliceM(only one) )
   
### Method of implementation on FPGA
A) General code
B) Language template
C) IP

### Fundamentals
32 * 8 --> (depth(location) * size)
reg + size + memory instance name + depth
eg1: 32 * 8: reg [7: 0] mem [31: 0];
eg2: 128 * 16 reg [15: 0] mem [127: 0];

## FSM
### Moore FSM(Only On): output depends only on the present state 

### Mealy FSM: output depends on the present state and the input

### Implementation Methodology
RESET LOGIC:    State of the system when rst = 1/0
OUTPUT DECODER: Value of o/p in the specific state
NEXT STATE DECODER: transition

1) 1-process methodology
   single always block

2) 2-process methodology
   always -- R.L.           (Squential)
   always -- O.D. & N.S.D.  (Combinational)

3) 3-process methodology
   always -- R.L.
   always -- O.D.
   always -- N.S.D.
