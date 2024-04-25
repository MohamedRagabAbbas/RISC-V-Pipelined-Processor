`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2024 08:56:23 AM
// Design Name: 
// Module Name: N_Bit_ALU
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


module N_Bit_ALU #(parameter N = 32)(
    input [N-1:0] A,
    input [N-1:0] B,
    input [3:0] sel,
    output reg [N-1:0] ALUOutput,
    output CarryOut,
    output zeroFlag
    );
    
    wire [N-1:0] Sum;
    wire [N-1:0] AND;
    wire [N-1:0] OR;
    
    //assign B = (sel[2] == 1 ? ~B : B);
    RCA_8 rca(.A(A),.B(sel[2] == 1 ? ~B : B),.CarryIn(sel[2]),.Sum(Sum),.CarryOut(CarryOut));  
     
    assign AND = A & B;
    assign OR = A | B;
    
    always @(*) begin
        case(sel)
        4'b0010: ALUOutput = Sum;
        4'b0110: ALUOutput = Sum;
        4'b0000: ALUOutput = AND;
        4'b0001: ALUOutput = OR;
        default: ALUOutput = 1'bX;
        endcase
    end
    assign zeroFlag = (ALUOutput == 0);
endmodule