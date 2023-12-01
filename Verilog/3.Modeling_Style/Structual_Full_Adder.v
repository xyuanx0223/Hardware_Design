`timescale 1ns / 1ps

module ha(
    input a, b,
    output s, c
);
    assign s = a & b;
    assign c = a ^ b;
endmodule

//////////////////////////////////////

module fa(
    input a, b, cin,
    output s, cout
);
    wire t1, t2, t3;
    ha h1(a, b, t2, t1);
    ha h2(t2, cin, s, t3);
    assign cout = t1 | t3;
endmodule
