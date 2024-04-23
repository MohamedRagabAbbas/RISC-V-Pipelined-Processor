`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/23/2024 09:21:33 AM
// Design Name: 
// Module Name: Datamem_tb
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


module Datamem_tb();

    localparam period = 50;
    
    reg clk;
    reg MemRead;
    reg MemWrite; 
    reg [9:0] addr; 
    reg [31:0] data_in; 
    wire [127:0] data_out; 
    wire ready;
    
    DataMem DUT(clk, MemRead, MemWrite, addr, data_in, data_out, ready);
    
    initial begin 
        clk = 0;
        forever #(period/2) clk = ~clk;
    end
    
    initial begin  
        MemRead = 0; MemWrite = 1; addr = 5; data_in = 8;
        #(period*4)
        MemRead = 1; MemWrite = 0; addr = 3; data_in = 0;
        #(period*4)
        MemRead = 1; MemWrite = 0; addr = 5; data_in = 0;
    end

endmodule
