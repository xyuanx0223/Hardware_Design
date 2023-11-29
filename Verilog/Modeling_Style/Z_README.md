## Modeling style
### 1) Gate-level modeling style
*Basic Logic Gates*

### 2) Switch level modeling style
*Switches*
non-synthesizable in Vivado

### 3) Structural-level modeling style

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
