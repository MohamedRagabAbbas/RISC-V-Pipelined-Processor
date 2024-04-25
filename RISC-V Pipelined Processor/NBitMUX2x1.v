`timescale 1ns / 1ps
/*******************************************************************
*
* Module: SingleMem.v
* Project: NBitRegister 3
* Author: Mohamed Abbas mohamed_Ragab02@aucegypt 
          Omar Bahgat omar_bahgat@aucegypt.edu
* Description: SingleMem
*
* Change history: 
**********************************************************************/

module NBitMUX2x1 #(parameter n = 32)(
    input [n-1:0] A,
    input [n-1:0] B,
    input sel,
    output [n-1:0] Y
    );
    
    genvar i;
    generate
        for(i = 0; i < n; i = i + 1)
        begin: Gen_Modules
        MUX2x1 mux(.A(A[i]), .B(B[i]), .sel(sel), .Y(Y[i])); 
        end
     endgenerate
endmodule