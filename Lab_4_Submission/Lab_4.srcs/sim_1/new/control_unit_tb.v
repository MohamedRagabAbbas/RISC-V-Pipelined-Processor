`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2024 11:02:43 AM
// Design Name: 
// Module Name: control_unit_tb
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


module control_unit_tb();
    reg [4:0] inst;
    wire Branch;
    wire MemRead;
    wire MemtoReg;
    wire [1:0] ALUop;
    wire MemWrite;
    wire ALUSrc;
    wire RegWrite;
    
    control_unit cu(inst, Branch, MemRead, MemtoReg, ALUop, MemWrite, ALUSrc, RegWrite);
    
    initial begin
        inst = 5'b01100; 
        #100
        inst = 5'b00000; 
        #100 
        inst = 5'b01000; 
        #100 
        inst = 5'b11000; 
    end
endmodule
