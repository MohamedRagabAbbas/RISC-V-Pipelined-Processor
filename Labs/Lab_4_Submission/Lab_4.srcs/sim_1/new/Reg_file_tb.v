`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2024 10:30:32 AM
// Design Name: 
// Module Name: Reg_file_tb
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


module Reg_file_tb();
    
    localparam N = 32;
    localparam period = 100;
    
    reg [4:0] src1;
    reg [4:0] src2;
    reg [4:0] dest;
    reg [N-1:0] data;
    reg clk;
    reg rst;
    reg RegWrite;
    wire [N-1:0] out1;
    wire [N-1:0] out2;
    
    Reg_file DUT(src1, src2, dest, data, clk, rst, RegWrite, out1, out2);
    
    initial begin
        clk = 0;
        #100
        forever #(period/2) clk = ~clk;
    end
    initial begin
        rst = 1;
        #period
        rst = 0;
        #period
        RegWrite = 1; data = 15; src1 = 4; src2 = 6; dest = 4;
        #period 
        RegWrite = 1; data = 20; src1 = 4; src2 = 6; dest = 6;
        #period 
        RegWrite = 0; data = 7; src1 = 4; src2 = 6; dest = 6;
    end

endmodule
