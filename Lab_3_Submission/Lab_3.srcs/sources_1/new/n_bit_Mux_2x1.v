`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/20/2024 09:39:57 AM
// Design Name: 
// Module Name: n_bit_Mux_2x1
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


module n_bit_Mux_2x1 #(parameter n = 32)(
    input [n-1:0] A,
    input [n-1:0] B,
    input sel,
    output [n-1:0] Y
    );
    
    genvar i;
    generate
        for(i = 0; i < n; i = i + 1)
        begin: Gen_Modules
        Mux_2x1 mux(.A(A[i]), .B(B[i]), .sel(sel), .Y(Y[i])); 
        end
     endgenerate
endmodule
