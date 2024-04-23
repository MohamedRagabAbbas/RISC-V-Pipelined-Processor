`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/23/2024 10:21:31 AM
// Design Name: 
// Module Name: DataCacheController_tb
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


module DataCacheController_tb();
    
    localparam period = 50;
    
    reg clk;
    reg MemRead; 
    reg MemWrite; 
    reg [4:0] index; 
    reg [2:0] tag; 
    wire stall; 
    wire fill; 
    wire update; 
    wire MsRead; 
    reg MsReady;
    
    DataCacheController DUT(clk, MemRead, MemWrite, index, tag, stall, fill, update, MsRead, MsReady);
    
    initial begin
        clk = 1; 
        forever #(period/2) clk = ~clk;
    end
    
    initial begin 
        MemRead = 0; MemWrite = 1; index = 5; tag = 2; MsReady = 0;
        #period 
        MemRead = 0; MemWrite = 0; index = 3; tag = 4; MsReady = 1;
        #period 
        MemRead = 1; MemWrite = 0; index = 5; tag = 2; MsReady = 1;
        #period 
        MemRead = 1; MemWrite = 0; index = 5; tag = 2; MsReady = 1;
        #period 
        MemRead = 1; MemWrite = 0; index = 5; tag = 2; MsReady = 1;
    end
    
endmodule
