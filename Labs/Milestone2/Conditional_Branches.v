`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/27/2024 04:27:35 PM
// Design Name: 
// Module Name: Conditional_Branches
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


module Conditional_Branches(
    input [2:0]func3,
    input zeroFlag,
    input carryOut,
    input overflow,
    input sign,
    output reg result 
    );
    
    always@(*) begin
            case(func3)
                0: result = zeroFlag;           //BEQ
                1: result = ~zeroFlag;          //BNQ
                4: result = sign != overflow;   //BLT
                5: result = sign == overflow;   //BGE
                6: result = ~carryOut;          // BLTU
                7: result = carryOut;           // BGEU
                default: result = 0;
            endcase
    end
endmodule
