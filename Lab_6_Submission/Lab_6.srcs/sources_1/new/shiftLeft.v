`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/20/2024 09:48:19 AM
// Design Name: 
// Module Name: shiftLeft
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


module ShiftLeft #(parameter n = 32)(
    input [n-1:0] A,
    output [n-1:0] Y
    );
    assign Y = {A[n-2:0], 1'b0};
endmodule
