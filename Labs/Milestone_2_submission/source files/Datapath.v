`timescale 1ns / 1ps
`include "defines.v"

/*******************************************************************
*
* Module: Datapath.v
* Project: Milestone 2
* Author: Mohamed Abbas mohamed_abbas02@aucegypt 
          Omar Bahgat omar_bahgat@aucegypt.edu
* Description: Datapath
*
* Change history: 
**********************************************************************/

module Datapath(
    input clk,
    input rst,
    input [1:0] ledSel,
    input [3:0] ssdSel,
    output reg [15:0] leds,
    output reg [12:0] ssd
);
    // Program Counter
    
    wire [31:0] PCInput;
    wire [31:0] PCOutput;
   
    NBitRegister nBitRegister(clk, rst, 1'b1, PCInput, PCOutput);
    
    // Instruction Memory
    
    wire [31:0] inst;
    InstMem instMem(PCOutput[7:2], inst); // divide by 4
    
    // Control Unit
    
    wire [3:0] ALUOp;
    wire MemRead;
    wire MemWrite;
    wire RegWrite;
    wire ALUSrc;
    wire MemToReg;
    wire [1:0] RegData;
    wire [1:0] Branch;
    wire pc_rst;
    wire pc_halt;
    
    ControlUnit controlUnit(inst, ALUOp, MemRead, MemWrite, RegWrite, ALUSrc, MemToReg,RegData , Branch, pc_rst, pc_halt);
    
    wire [3:0] ALUSel;
    ALUControlUnit ALUcu(ALUOp, inst[30], inst[14:12], ALUSel);
    
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
    wire [31:0] MemOut2;
    wire [31:0] ALUOutput;
    
    LoadUnit loadUnit(MemOut, inst[14:12], MemOut2);
    NBitMUX2x1 mux1(MemOut2, ALUOutput, MemToReg, RegWriteData);
    
    //RegFile regfile(clk, rst, RegWrite, rs1, rs2, rd, RegWriteData, RegOut1, RegOut2);
    RegFile regfile(rs1, rs2, rd, RegWriteData, clk, rst, RegWrite, RegOut1, RegOut2);
        
    // Immediate Generator
    
    wire [31:0] ImmOut;
    ImmGen immGen(inst, ImmOut);
    
    // ALU
    
    wire cf;
    wire zf;
    wire vf;
    wire sf;
    wire [31:0] ALUSecondSrc;
    wire [4:0]  shamt;
        
    NBitMUX2x1 mux3(ImmOut, RegOut2, ALUSrc, ALUSecondSrc);
    ALU alu(RegOut1, ALUSecondSrc, ALUSel, shamt, ALUOutput, cf, zf, vf, sf);
    
    assign shamt = ALUSecondSrc[4:0];

    
    // Data Memory
    wire [31:0] MemIn;
    StoreUnit storeUnit(RegOut2, inst[14:12], MemIn);
    DataMem dataMem(clk, MemRead, MemWrite, ALUOutput[7:2], MemIn, MemOut);
    
    // Left shift
    
//    wire [31:0] Shifted;
//    ShiftLeft shiftLeft(ImmOut, Shifted);
    
    // Conditional Branching
    
//    wire [31:0] TargetAddress;
//    wire CarryOutBranch;
//    RCA rca1(PCOutput, Shifted, 1'b0, TargetAddress, CarryOutBranch);
  
//    // Sequential Instruction
//    wire [31:0] PC4;
//    wire CarryOutPC;
    
//    RCA rca2(PCOutput, 3'b100, 1'b0, PC4, CarryOutPC);

    wire conditionResult;
    Conditional_Branches condBranches(inst[14:12], zf, cf, vf, sf, conditionResult);
    
   
    NBitMUX2x1 mux4(PCOutput + ImmOut, PCOutput + 4, Branch[0] & conditionResult, PCInput);
         
//    always @(*) begin
//        case(ledSel)
//            0: leds = inst[15:0];
//            1: leds = inst[31:16];
//            2: leds = {2'b00, ALUOp, ALUSel, ZeroFlag, Branch & ZeroFlag, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite};
//            default: leds = 0;
//        endcase
//    end
    
//    wire [31:0] PCUpdated = PCOutput + 4;
//    wire [31:0] PCBranch = PCOutput + ImmOut;
//    always @(*) begin
//        case(ssdSel)
//            0: ssd = PCOutput[12:0];
//            1: ssd = PCUpdated[12:0];
//            2: ssd = PCBranch[12:0];
//            3: ssd = PCInput[12:0];
//            4: ssd = RegOut1[12:0];
//            5: ssd = RegOut2[12:0];
//            6: ssd = RegWriteData[12:0]; 
//            7: ssd = ImmOut[12:0];
//            8: ssd = Shifted[12:0];
//            9: ssd = ALUSecondSrc[12:0];
//            10: ssd = ALUOutput[12:0];
//            11: ssd = MemOut[12:0];
//            default: ssd = 0;
//        endcase
//    end
        
endmodule