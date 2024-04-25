`timescale 1ns / 1ps
/*******************************************************************
*
* Module: ShiftLeft.v
* Project: NBitRegister 3
* Author: Mohamed Abbas mohamed_Ragab02@aucegypt 
          Omar Bahgat omar_bahgat@aucegypt.edu
* Description: ShiftLeft
*
* Change history: 
**********************************************************************/


module ShiftLeft #(parameter n = 32)(
    input [n-1:0] A,
    output [n-1:0] Y
    );
    assign Y = {A[n-2:0], 1'b0};
endmodule