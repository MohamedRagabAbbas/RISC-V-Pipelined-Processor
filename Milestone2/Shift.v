`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/27/2024 09:30:42 PM
// Design Name: 
// Module Name: Shift
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


module Shift(
    input [31:0] A, 
    input [4:0] Shamt, 
    input [1:0] Type, 
    output reg [31:0] ShiftOutput
    );
    always @(*) begin
        case(Type)
         2'b00: ShiftOutput = A >> Shamt;   //SRL
         2'b01: ShiftOutput = A << Shamt;   //SLL
         2'b10: ShiftOutput = A >>> Shamt;  //SRA
        endcase
    end
endmodule