`timescale 1ns / 1ps
`include "defines.v" 

/*******************************************************************
*
* Module: ControlUnit.v
* Project: Milestone 2
* Author: Mohamed Abbas mohamed_abbas02@aucegypt 
          Omar Bahgat omar_bahgat@aucegypt.edu
* Description: Control Unit
*
* Change history: 
**********************************************************************/

module ControlUnit(
    input [31:0] inst,
    output reg [1:0] Branch,
    output reg MemRead,
    output reg MemToReg, 
    output reg [3:0] AluOp,
    output reg MemWrite,
    output reg ALUSrc,
    output reg RegWrite,
    output reg [1:0] RegData, 
    output reg pc_rst,
    output reg pc_halt
);

    always @(*) begin 
      case (inst[`IR_opcode]) 
        `OPCODE_Branch: begin 
                            Branch = 2'b01;
                            MemRead = 1'b0;
                            MemToReg = 1'b0; 
                            AluOp = 4'b0010;
                            MemWrite = 1'b0;
                            ALUSrc = 1'b0;
                            RegWrite = 1'b0;
                            RegData = 2'b01;
                            pc_halt=1'b0;
                            pc_rst=1'b0;
                        end
        `OPCODE_Load: begin
                            Branch = 2'b00;
                            MemRead = 1'b1;
                            MemToReg = 1'b1; 
                            AluOp = 4'b0011;
                            MemWrite = 1'b0;
                            ALUSrc = 1'b1;
                            RegWrite = 1'b1;
                            RegData = 2'b10;
                            pc_halt=1'b0;
                            pc_rst=1'b0;
                         end
        `OPCODE_Store: begin
                            AluOp = 4'b0100;
                            MemRead = 1'b0;
                            MemWrite = 1'b1;
                            RegWrite = 1'b0;
                            ALUSrc = 1'b1;
                            MemToReg = 1'b0;  
                            RegData = 2'b01;
                            Branch = 2'b00;
                            pc_halt=1'b0;
                            pc_rst=1'b0;
                         end
        `OPCODE_JALR: begin
                            AluOp = 4'b0101;
                            MemRead = 1'b0;
                            MemWrite = 1'b0;
                            RegWrite = 1'b1;
                            ALUSrc = 1'b1;
                            MemToReg = 1'b0;  
                            RegData = 2'b00;
                            Branch = 2'b11;
                            pc_halt=1'b0;
                            pc_rst=1'b0;
                         end
        `OPCODE_JAL: begin
                            AluOp = 4'b0110;
                            MemRead = 1'b0;
                            MemWrite = 1'b0;
                            RegWrite = 1'b1;
                            ALUSrc = 1'b1;
                            MemToReg = 1'b0; 
                            RegData = 2'b00;
                            Branch = 2'b10;
                            pc_halt=1'b0;
                            pc_rst=1'b0;
                         end
        `OPCODE_Arith_I: begin
                            AluOp = 4'b0001;
                            MemRead = 1'b0;
                            MemWrite = 1'b0;
                            RegWrite = 1'b1;
                            ALUSrc = 1'b1;
                            MemToReg = 1'b0;  
                            RegData = 2'b10;
                            Branch = 2'b00;
                            pc_halt=1'b0;
                            pc_rst=1'b0;    
                         end       
        `OPCODE_Arith_R: begin
                            MemRead = 1'b0;
                            MemWrite = 1'b0;
                            RegWrite = 1'b1;
                            ALUSrc = 1'b0;
                            MemToReg = 1'b0; // 
                            RegData = 2'b10;
                            Branch = 2'b00;
                            pc_halt=1'b0;
                            pc_rst=1'b0;
                            if(inst[25]==0)
                                AluOp = 4'b0000;
                            else
                                AluOp = 4'b1001; 
                          end
        `OPCODE_AUIPC: begin
                            AluOp = 4'b0111;
                            MemRead = 1'b0;
                            MemWrite = 1'b0;
                            RegWrite = 1'b1;
                            ALUSrc = 1'b0;
                            MemToReg = 1'b0;  
                            RegData = 2'b01;
                            Branch = 2'b00;
                            pc_halt=1'b0;
                            pc_rst=1'b0;
                         end
        `OPCODE_LUI: begin
                            AluOp = 4'b1000;
                            MemRead = 1'b0;
                            MemWrite = 1'b0;
                            RegWrite = 1'b1;
                            ALUSrc = 1'b1;
                            MemToReg = 1'b0; // donotCare
                            RegData = 2'b10;
                            Branch = 2'b00;
                            pc_halt=1'b0;
                            pc_rst=1'b0;
                         end
        `OPCODE_SYSTEM: begin
                            MemRead = 1'b0;// donotCare
                            MemWrite = 1'b0;// donotCare
                            RegWrite = 1'b0;// donotCare
                            ALUSrc = 1'b0;// donotCare
                            MemToReg = 1'b0; // donotCare
                            RegData = 2'b00;// donotCare
                            Branch = 2'b00;
                            if(inst[21]==1)
                                pc_rst=1'b0;
                            else 
                                pc_halt=1'b1;
                        end
         `OPCODE_Fence: begin
                          pc_rst=1'b1;
                          MemRead = 1'b0;
                          MemWrite = 1'b0;
                          RegWrite = 1'b0;
                          ALUSrc = 1'b0;
                          MemToReg = 1'b0; // donotCare
                          RegData = 2'b00;
                          Branch = 2'b00;
                          pc_halt=1'b0;
                       end
            endcase
    end 

endmodule