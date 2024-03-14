`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/13/2024 09:10:50 AM
// Design Name: 
// Module Name: RCA
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


module RCA #(parameter N = 32)(
    input [N-1:0] A, 
    input [N-1:0] B,
    input CarryIn,
    output [N-1:0]Sum,
    output CarryOut
    );
    
    wire [N:0] Cout;
    assign Cout[0] = CarryIn ;
    
    genvar i;
    generate
        for( i = 0; i < N; i = i+1) begin
        FullAdder FA(A[i], B[i], Cout[i], Sum[i], Cout[i+1]);
      end
    endgenerate
    
    assign CarryOut = Cout[N];
    
endmodule