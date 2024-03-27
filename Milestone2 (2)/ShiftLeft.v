`timescale 1ns / 1ps

/*******************************************************************
*
* Module: ShiftLeft.v
* Project: Milestone 2
* Author: Mohamed Abbas mohamed_abbas02@aucegypt 
          Omar Bahgat omar_bahgat@aucegypt.edu
* Description: Left shift by 1
*
* Change history: 
**********************************************************************/


module ShiftLeft #(parameter N = 32)(
    input [N-1:0] A,
    output [N-1:0] Y
    );
    assign Y = {A[N-2:0], 1'b0};
endmodule