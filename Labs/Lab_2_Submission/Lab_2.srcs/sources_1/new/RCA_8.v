`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/13/2024 09:10:50 AM
// Design Name: 
// Module Name: RCA_8
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


module RCA_8 #(parameter N = 8)(
    input [N-1:0] A, B,
    output [N:0] Sum
    );
    
    wire [N:0] Cout;
    
    assign Cout[0] = 1'b0;
    
    genvar i;
    generate
        for( i = 0; i < N; i = i+1) begin
        FullAdder FA(A[i], B[i], Cout[i], Sum[i], Cout[i+1]);
     //   assign Cin = Cout;
      end
    endgenerate
    
    assign Sum[N] = Cout[N];
    
endmodule
