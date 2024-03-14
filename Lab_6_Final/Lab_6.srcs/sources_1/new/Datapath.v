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
    input [3:0] ssdSel,
    output reg [15:0] leds,
    output reg [12:0] ssd
);
    // Program Counter
    
    reg [31:0] PCInput;
    wire [31:0] PCOutput;
    always @(rst) begin
        PCInput <= 0;
    end
    
    
    NBitRegister nBitRegister(clk, rst, 1'b1, PCInput, PCOutput);
    
    // Instruction Memory
    
    wire [31:0] inst;
    InstMem instMem(PCOutput[7:2], inst); // ignore first 2 bits instead of shifting right by 2
    
    // Control Unit
    
    wire Branch;
    wire MemRead;
    wire MemtoReg;
    wire [1:0] ALUOp;
    wire MemWrite;
    wire ALUSrc;
    wire RegWrite;
    
    ControlUnit controlUnit(inst[6:2], Branch, MemRead, MemtoReg, ALUOp, MemWrite,ALUSrc, RegWrite);
    
    wire [3:0] ALUSel;
    ALUControlUnit ALUcu(ALUOp, inst[14:12], inst[30], ALUSel);
    
    // Register File
    
    wire [4:0] rs1;
    wire [4:0] rs2;
    wire [4:0] rd;
    
    assign rs1 = inst[19:15];
    assign rs2 = inst[24:20];
    assign rd = inst[11:7];
    
    wire [31:0] RegOut1;
    wire [31:0] RegOut2;
    wire [31:0] RegWriteData;
    wire [31:0] MemOut;
    wire [31:0] ALUOutput;
    
    NBitMUX2x1 mux(MemOut, ALUOutput, MemtoReg, RegWriteData);
    RegFile regfile(rs1, rs2, rd, RegWriteData, clk, rst,RegWrite, RegOut1, RegOut2);
        
    // Immediate Generator
    
    wire [31:0] ImmOut;
    ImmGen immGen(inst, ImmOut);
    
    // ALU
    
    wire CarryOutALU;
    wire ZeroFlag;
    wire [31:0] ALUSecondSrc;
    
    // assign ALUSecondSrc = (ALUSrc == 1 ? ImmOut : RegOut2);
    ALU alu(RegOut1, ALUSrc == 1 ? ImmOut : RegOut2, ALUSel, ALUOutput,CarryOutALU, ZeroFlag);
    
    // Data Memory
    
    DataMem dataMem(clk, MemRead, MemWrite, ALUOutput[7:2], RegOut2, MemOut);
    
    // Left shift
    
    wire [31:0] Shifted;
    ShiftLeft shiftLeft(ImmOut, Shifted);
    
    // Branching
    
    wire [31:0] TargetAddress;
    wire CarryOutBranch;
    RCA rca1(PCOutput, Shifted, 1'b0, TargetAddress, CarryOutBranch);
    
    // Sequential Instruction
    wire [31:0] PC4;
    wire CarryOutPC;
    
    RCA rca2(PCOutput, 3'b100, 1'b0, PC4, CarryOutPC);
    
    wire Anding = (Branch & ZeroFlag);
     always @(clk) begin
        PCInput <= (Anding == 1 ? PCOutput + Shifted : PCOutput + 4);
     end
    
    
    always @(posedge clk) begin
        case(ledSel)
            0: leds = inst[15:0];
            1: leds = inst[31:16];
            2: leds = {2'b00, ALUOp, ALUSel, ZeroFlag, Anding, Branch, MemRead,MemtoReg, MemWrite, ALUSrc, RegWrite};
            default: leds = 0;
        endcase
    end
    
    wire [31:0] PCUpdated = PCOutput + 4;
    wire [31:0] PCBranch = PCOutput + Shifted;
    always @(posedge clk) begin
        case(ssdSel)
            0: ssd = PCOutput[12:0];
            1: ssd = PCUpdated[12:0];
            2: ssd = PCBranch[12:0];
            3: ssd = PCInput[12:0];
            4: ssd = RegOut1[12:0];
            5: ssd = RegOut2[12:0];
            6: ssd = (MemtoReg == 1 ? MemOut[12:0] : ALUOutput[12:0]); // RegWriteData
            7: ssd = ImmOut[12:0];
            8: ssd = Shifted[12:0];
            9: ssd = (ALUSrc == 1 ? ImmOut[12:0] : RegOut2[12:0]); // ALUSecondSrc
            10: ssd = ALUOutput[12:0];
            11: ssd = MemOut[12:0];
            default: ssd = 0;
        endcase
    end
        
endmodule
