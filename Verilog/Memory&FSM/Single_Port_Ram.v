`timescale 1ns / 1ps
// General Method
// 64 * 8 ram
module ram(
    input clk,
    input we,
    input rst,
    input [5: 0] addr,
    input [7: 0] din,
    output [7: 0] dout
);
    reg [7: 0] mem [63: 0];
    reg [7: 0] temp;
    integer i;
    // blk_mem_gen_0 b1 (clk, we, addr, din, dout);
    always @ (posedge clk) begin
        if (rst) begin
            for(i = 0; i < 64; i = i + 1) begin
                mem[i] <= 8'b0;
            end
            temp <= 8'b0;
        end
        if (we) begin
            mem[addr] <= din;
        end else begin
            temp <= mem[addr];
        end
    end
    assign dout = temp;
endmodule

