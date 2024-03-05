`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/05/2024 08:44:46 AM
// Design Name: 
// Module Name: InstMem
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module InstMem (
    input [5:0] addr, 
    output [31:0] data_out
    ); 
    reg [31:0] mem [0:63];
    initial begin
        mem[0] = 32'h003100b3;
        mem[1] = 32'h01612023;
        mem[2] = 32'h0101a483;
        mem[3] = 32'h00000463;
        mem[4] = 32'h00726193;
        mem[5] = 32'h003270b3;
    end
    assign data_out = mem[addr]; 
endmodule
