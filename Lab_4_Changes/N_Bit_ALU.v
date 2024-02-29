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
    output CarryOut_add,
    output CarryOut_sub,
    output zeroFlag
    );
    
    wire [N-1:0] ADD;
    wire [N-1:0] SUB;
    wire [N-1:0] AND;
    wire [N-1:0] OR;
    
    RCA_8 rca1(.A(A),.B(B),.CarryIn(1'b0),.Sum(ADD),.CarryOut(CarryOut_add));   
    RCA_8 rca2(.A(A),.B(~B),.CarryIn(1'b1),.Sum(SUB),.CarryOut(CarryOut_sub));
    assign AND = A & B;
    assign OR = A | B;
    
    always @(*) begin
        case(sel)
        4'b0010: ALUOutput = ADD;
        4'b0110: ALUOutput = SUB;
        4'b0000: ALUOutput = AND;
        4'b0001: ALUOutput = OR;
        default: ALUOutput = 1'bX;
        endcase
    end
    assign zeroFlag = (ALUOutput == 0);
endmodule
