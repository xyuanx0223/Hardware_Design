## Modeling style
### 1) Gate-level modeling style
*Basic Logic Gates*

### 2) Switch level modeling style
*Switches* is
non-synthesizable in Vivado

### 3) Structural-level modeling style
eg: 
A) Johnson Counter(q=0, qbar=1, q<=din, qbar<=~din)/ Ring Counter(q=0, q<=din, qbar<=din)
BAsed on DFF(clk, din, q, qbar)
J.C. would connect to the qbar at the end of the serials of DFFs(while R.C. always connect to the DFFs)
NEEDS rst to give an initial value
P.S. 4_bit serial in also consists 4 DFFs.

B) Ripple Carry Adder
half adder: s = a ^ b; c = a & b;
full adder: 2 H.A.s with a OR gate
connect F.A.s in a series

C) Mux_81
Mux21: y = sel? a: b;
Mux41: 2 Mux21
Mux81: 4Mux21 + 2 Mux21 + Mux21

### 4) Behavioral level modeling style
*doesn't know the internal logic*
A) Declare Module
B) Declare temporary reg variable for output
C) initialize all the reg variable
D) implement system Behavior with procedural block
E) assign the value of the temporary variable to O/I ports

## Construct
### 1) initial: 
initialize

### 2) always: 
Combinational: it depends on all the inputs
always @ (*)
Sequential: O/P depends clock 
always @ (posedge clk)
*posedge/ negedge*
synchronous：  always @ (posedge clk)
asynchronous： always @ (posedge clk, posedge rst)

### 3) if(express): == != >= <= < > !
      if ()
      else if ()
      else if ()
      ...
      else
### 4) case(express)
      case(express)
      __: begin
      end
      __: begin
      end
      default:
      endcase
### if VS case:
*if would have a priority, while the case is fair.*

## Instance
1) sub-system code must be in the same project directory
2) Module name must be used to access the system

### explicit( mapping by name)

### implicit( mapping by position)
