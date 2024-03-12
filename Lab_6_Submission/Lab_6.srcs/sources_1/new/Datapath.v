`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/12/2024 01:10:35 PM
// Design Name: 
// Module Name: Datapath
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


module Datapath(
    input clk,
    input rst,
    input [1:0] ledSel,
    output reg [15:0] out
    );
    
    // Program counter part
    
    wire [31:0] PC;
    assign PC = 0;
    
    wire [31:0] inst;
    InstMem instMem(PC >> 2, inst);
   
   // Control Units part  
   
    wire Branch;
    wire MemRead;
    wire MemtoReg;
    wire ALUop;
    wire MemWrite;
    wire ALUSrc;
    wire RegWrite;
    
    controlUnit cu(inst[6:2], Branch, MemRead, MemtoReg, ALUop, MemWrite, ALUSrc, RegWrite);
    
    wire [3:0] ALUSel;
    ALUControlUnit ALUcu(ALUop, inst[14:12], inst[30], ALUSel);
    
   // Register File
   
    wire [4:0] rs1;
    wire [4:0] rs2;
    wire [4:0] rd;

    assign rs1 = inst[19:15];
    assign rs2 = inst[24:20];
    assign rd = inst[11:7];
    
    wire [31:0] writeData;
    wire [31:0] out1;
    wire [31:0] out2;
    RegFile regfile(rs1, rs2, rd, MemtoReg == 1 ? memOut : ALUOutput, clk, rst, RegWrite, out1, out2);
    
    wire [31:0] imm;
    ImmGen immGen(inst, imm);
    
    // ALU 
    
    wire [31:0] ALUOutput;
    wire CarryOut;
    wire zeroFlag;
    ALU alu(out1, ALUSrc == 1 ? imm : out2, ALUSel, ALUOutput, CarryOut, zeroFlag);
    
    // Data Memory  
       
    wire [31:0] memOut;
    DataMem dataMem(clk, MemRead, Memwrite, ALUOutput, out2, memOut);
    
    wire [31:0] shiftedImm;
    ShiftLeft shiftLeft(imm, shiftedImm);
    
    // Take care of PC (not divisible by 4) 
    
    wire [31:0] targetAddress;
    wire CarryOutBranch;
    RCA rca1(PC, shiftedLeft, targetAddress, CarryOutBranch);
    
    wire [31:0] newPC;
    wire CarryOutPC;
    RCA rca2(PC, 4, newPC, CarryOutPC);
    
    wire anding = (Branch && zeroFlag);
    assign PC = (anding == 1 ? targetAddress : newPC);
    
    always @(posedge clk or posedge rst) begin
        if(ledSel == 2'b00) begin
            out = inst[15:0];
        end
        else if(ledSel == 2'b01) begin
            out = inst[31:16];
        end
        else if (ledSel == 2'b10) begin
            out = {2'b00, ALUop, ALUSel, zeroFlag, anding, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite};
        end
    end

endmodule
