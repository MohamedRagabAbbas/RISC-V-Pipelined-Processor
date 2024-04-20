`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2024 08:56:23 AM
// Design Name: 
// Module Name: ALU
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


module ALU #(parameter N = 32)(
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
    
    wire [N-1:0] ALU_B_input; 
    NBitMUX2x1 mux(.A(~B), .B(B), .sel(sel[2]), .Y(ALU_B_input));
    RCA rca(.A(A),.B(ALU_B_input),.CarryIn(sel[2]),.Sum(Sum),.CarryOut(CarryOut));  
     
    assign AND = A & B;
    assign OR = A | B;
    
    always @(*) begin
        case(sel)
        4'b0010: ALUOutput = Sum;
        4'b0110: ALUOutput = Sum;
        4'b0000: ALUOutput = AND;
        4'b0001: ALUOutput = OR;
        default: ALUOutput = 1'b0;
        endcase
    end
    assign zeroFlag = (ALUOutput == 0);
endmodule