/////////////// arithmetic operators : + , - , *, / , %
////////////// Logical Operators     : ~, &, |, ^
///////////// Expression Operator  : && || ! > >= < <= == != ////case if
//////////// Shift : >> <<
/////////// Concat : {,}
/////////// Repetition Operator {f{v}}
/////////// Ternary Operator : ()? a : b;
//////exclaimation !
/// 11110 = 30
module tb;
reg [3:0] din1 = 4'b0101 , din2 = 4'b0110;
reg [4:0] add = 0;
integer sub = 0;
reg [7:0] mul = 0;

reg [7:0] concat = 0;
reg [11:0] rep = 0;
 
initial begin
concat = {din1, din2};
 
//concat = {4'b0101, 4'b0110};
rep = {3{din2}};
$display("Concat : %b and Rep : %b", concat, rep);
end
 
/*
reg [3:0] sdin1 = 0, sdin2 = 0;
 
initial begin
sdin1 = din1 >> 2;
sdin2 = din2 << 1;
$display("din1 : %b and din2 :%b", din1, din2);
$display("sdin1 : %b and sdin2 :%b", sdin1, sdin2);
end
*/
  
/*
initial begin
add = din1 + din2;
sub = din1 - din2;
mul = din1 * din2;
#1;
//$display("Value of add : %0d sub :%0d and mul :%0d",add,sub,mul );
$display("din1 : %b and din2 :%b", din1, din2);
$display("and : %0b or : %0b xor : %0b xnor : %0b", (din1 & din2),(din1 | din2),(din1 ^ din2),(din1 ~^ din2));
end
*/
endmodule
