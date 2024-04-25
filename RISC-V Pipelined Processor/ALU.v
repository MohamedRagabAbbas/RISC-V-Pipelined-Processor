`timescale 1ns / 1ps
`include "defines.v"
/*******************************************************************
*
* Module: ALU.v
* Project: NBitRegister 3
* Author: Mohamed Abbas mohamed_Ragab02@aucegypt 
          Omar Bahgat omar_bahgat@aucegypt.edu
* Description: ALU
*
* Change history: 
**********************************************************************/

module ALU #(parameter N = 32)(
    input [N-1:0] A,
    input [N-1:0] B,
    input [3:0] sel,
    input [4:0]  shamt,
    output reg [N-1:0] ALUOutput,
    output cf, zf, vf, sf           // carry, zero, overflow, sign
);
    
    wire [N-1:0] Sum;
    wire [N-1:0] AND;
    wire [N-1:0] OR;
    
    wire [N-1:0] ALU_B_input; 
    NBitMUX2x1 mux(.A(~B), .B(B), .sel(sel[0]), .Y(ALU_B_input));
    RCA rca(.A(A),.B(ALU_B_input),.CarryIn(sel[0]),.Sum(Sum),.CarryOut(cf));  
     
    assign AND = A & B;
    assign OR = A | B;
    
    //shifting
    wire[31:0] shifted;
    Shift shifter0(A, shamt, sel[1:0], shifted);
        
    always @(*) begin
        case(sel)
            // Arithmetic
            `ALU_ADD:  ALUOutput = Sum;
            `ALU_SUB:  ALUOutput = Sum;
            
            // Logical
            `ALU_AND:  ALUOutput = AND;
            `ALU_OR:   ALUOutput = OR;
            `ALU_XOR:  ALUOutput = A^B;  
            
            // shifting
            `ALU_SRL:  ALUOutput = shifted; //SRL
            `ALU_SLL:  ALUOutput = shifted;//SLL
            `ALU_SRA:  ALUOutput = shifted;//SRA
            `ALU_SLT:  ALUOutput = {31'b0,(sf != vf)}; 
            `ALU_SLTU: ALUOutput = {31'b0,(~cf)};
             4'b1011: ALUOutput = B; //LUI
             
              //MUL
             `ALU_MUL: ALUOutput = A * B;
             //DIV
             `ALU_DIV: ALUOutput = A / B;
             //REM
             `ALU_REM: ALUOutput= A%B;
            default: ALUOutput = 1'b0;
        endcase
    end
    
    assign zf = (Sum == 0);
    assign sf = (Sum[31] == 0);
    assign vf = (A[31] ^ B[31] ^ Sum[31] ^ cf);
    
endmodule