`timescale 1ns / 1ps

/*******************************************************************
*
* Module: NBitMUX2x1.v
* Project: Milestone 2
* Author: Mohamed Abbas mohamed_abbas02@aucegypt 
          Omar Bahgat omar_bahgat@aucegypt.edu
* Description: N-bit 2x1 Mux
*
* Change history: 
**********************************************************************/


module NBitMUX2x1 #(parameter N = 32)(
    input [N-1:0] A,
    input [N-1:0] B,
    input sel,
    output [N-1:0] Y
    );
    
    genvar i;
    generate
        for(i = 0; i < N; i = i + 1)
        begin: Gen_Modules
        MUX2x1 mux(.A(A[i]), .B(B[i]), .sel(sel), .Y(Y[i])); 
        end
     endgenerate
endmodule