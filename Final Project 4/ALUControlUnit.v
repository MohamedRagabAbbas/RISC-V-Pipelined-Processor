`timescale 1ns / 1ps
`include "defines.v"

/*******************************************************************
*
* Module: ALUControlUnit.v
* Project: Milestone 2
* Author: Mohamed Abbas mohamed_abbas02@aucegypt 
          Omar Bahgat omar_bahgat@aucegypt.edu
* Description: Control Unit
*
* Change history: 
**********************************************************************/

module ALUControlUnit(
    input [3:0] ALUOp, 
    input inst30,
    input [2:0] funct3, 
    output reg [3:0] ALUSel
);

    always @(*) begin
        if(ALUOp == 4'b0000) begin
            case(funct3)
              `F3_OR: ALUSel = `ALU_OR;
              `F3_AND: ALUSel = `ALU_AND;
              `F3_XOR: ALUSel = `ALU_XOR;
              `F3_ADD: begin
                  if(inst30 == 0)
                    ALUSel = `ALU_ADD;
                  else
                    ALUSel = `ALU_SUB;
                end
              `F3_SLT: ALUSel = `ALU_SLT;
              `F3_SLL: ALUSel = `ALU_SLL;
              `F3_SLTU: ALUSel = `ALU_SLTU;
               `F3_SRL: 
                begin
                  if(inst30 == 0)
                    ALUSel = `ALU_SRL;
                  else
                    ALUSel = `ALU_SRA;
                end
            endcase
          end
        else if(ALUOp == 4'b0001) //I-Format Instructions
          begin
            case(funct3)
              `F3_ADD: ALUSel = `ALU_ADD;
              `F3_OR: ALUSel = `ALU_OR;
              `F3_AND: ALUSel = `ALU_AND;
              `F3_XOR: ALUSel = `ALU_XOR;
              `F3_SLT: ALUSel = `ALU_SLT;
              `F3_SLTU: ALUSel = `ALU_SLTU;
              `F3_SLL: ALUSel = `ALU_SLL;
              `F3_SRL: 
                begin
                  if(inst30 == 0)
                    ALUSel = `ALU_SRL;
                  else
                    ALUSel = `ALU_SRA;
                end
            endcase
          end
        else if(ALUOp == 4'b0010) //Branching
          ALUSel = `ALU_SUB;
        else if(ALUOp == 4'b0011) //Load
          ALUSel = `ALU_ADD;
        else if(ALUOp == 4'b0100) //Store
          ALUSel = `ALU_ADD;
          
         else if(ALUOp == 4'b0111) //AUIPC
            ALUSel = `ALU_AUIPC;
            
          else if(ALUOp == 4'b1000) //LUI
            ALUSel = `ALU_LUI;
          else if(ALUOp == 4'b0101) //JALR
            ALUSel = `ALU_ADD;
          else if(ALUOp == 4'b0110) //JAL
            ALUSel = `ALU_ADD;
    end
endmodule