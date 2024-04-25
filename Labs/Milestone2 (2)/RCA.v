`timescale 1ns / 1ps

/*******************************************************************
*
* Module: RCA.v
* Project: Milestone 2
* Author: Mohamed Abbas mohamed_abbas02@aucegypt 
          Omar Bahgat omar_bahgat@aucegypt.edu
* Description: Ripple Carry Adder
*
* Change history: 
**********************************************************************/


module RCA #(parameter N = 32)(
    input [N-1:0] A, 
    input [N-1:0] B,
    input CarryIn,
    output [N-1:0] Sum,
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