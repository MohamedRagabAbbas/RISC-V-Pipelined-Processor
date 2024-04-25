`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/05/2024 09:14:55 AM
// Design Name: 
// Module Name: DataMem_tb
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


module DataMem_tb();

    localparam period = 100;
    
    reg clk;
    reg MemRead;
    reg MemWrite;
    reg [5:0] addr;
    reg [31:0] data_in;
    wire [31:0] data_out;
    
    DataMem DUT(clk, MemRead, MemWrite, addr, data_in, data_out);
    
    initial begin
        clk = 0;
        forever #(period/2) clk = ~clk;
    end
    initial begin
        MemRead = 1; MemWrite = 1; addr = 0; data_in = 7;
        #period
        MemRead = 1; MemWrite = 0; addr = 0; data_in = 10;
        #period
        MemRead = 1; MemWrite = 1; addr = 0; data_in = 10;
        #period
        MemRead = 0; MemWrite = 0; addr = 0; data_in = 10;
    end
endmodule
