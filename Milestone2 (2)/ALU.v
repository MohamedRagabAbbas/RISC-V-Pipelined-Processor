`timescale 1ns / 1ps

/*******************************************************************
*
* Module: ALU.v
* Project: Milestone 2
* Author: Mohamed Abbas mohamed_abbas02@aucegypt 
          Omar Bahgat omar_bahgat@aucegypt.edu
* Description: Arithmetic and Logical Unit
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
    NBitMUX2x1 mux(.A(~B), .B(B), .sel(sel[2]), .Y(ALU_B_input));
    RCA rca(.A(A),.B(ALU_B_input),.CarryIn(sel[2]),.Sum(Sum),.CarryOut(cf));  
     
    assign AND = A & B;
    assign OR = A | B;
    
    //shifting
    wire[31:0] shifted;
    Shift shifter0(A, shamt, sel[1:0], shifted);
        
    always @(*) begin
        case(sel)
            //Arithmetic
            4'b0010: ALUOutput = Sum;
            4'b0110: ALUOutput = Sum;
            
            //logical
            4'b0000: ALUOutput = AND;
            4'b0001: ALUOutput = OR;
            4'b0111: ALUOutput = A^B;  // XOR
            
            // shifting
            4'b1000: ALUOutput = shifted; //SRL
            4'b1001: ALUOutput = shifted;//SLL
            4'b1010: ALUOutput = shifted;//SRA
            default: ALUOutput = 1'b0;
        endcase
    end
    
    assign zf = (Sum == 0);
    assign sign = (Sum[31] == 0);
    assign overflow = (A[31] ^ B[31] ^ Sum[31] ^ cf);
    
endmodule