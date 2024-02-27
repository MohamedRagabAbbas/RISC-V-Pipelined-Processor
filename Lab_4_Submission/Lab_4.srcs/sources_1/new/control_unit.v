`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2024 10:51:52 AM
// Design Name: 
// Module Name: control_unit
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


module control_unit(
    input [4:0] inst,
    output reg Branch,
    output reg MemRead,
    output reg MemtoReg,
    output reg [1:0] ALUop,
    output reg MemWrite,
    output reg ALUSrc,
    output reg RegWrite
);
    always @(*) begin
    // R-format
        if(inst == 5'b01100) begin
            Branch = 0;
            MemRead = 0;
            MemtoReg = 0;
            ALUop = 2'b10;
            MemWrite = 0;
            ALUSrc = 0;
            RegWrite = 1;
        end
        // LW
         else if(inst == 5'b00000) begin
            Branch = 0;
            MemRead = 1;
            MemtoReg = 1;
            ALUop = 2'b00;
            MemWrite = 0;
            ALUSrc = 1;
            RegWrite = 1;
        end
        // SW
        else if(inst == 5'b01000) begin
            Branch = 0;
            MemRead = 0;
            MemtoReg = 1'bX;
            ALUop = 2'b00;
            MemWrite = 1;
            ALUSrc = 1;
            RegWrite = 0;
        end
        else if(inst == 5'b11000) begin
            Branch = 1;
            MemRead = 0;
            MemtoReg = 1'bX;
            ALUop = 2'b01;
            MemWrite = 0;
            ALUSrc = 0;
            RegWrite = 0;
        end
    end
   
endmodule
