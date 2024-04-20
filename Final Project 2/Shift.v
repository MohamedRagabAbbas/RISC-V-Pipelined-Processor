`timescale 1ns / 1ps

/*******************************************************************
*
* Module: Shift.v
* Project: Milestone 2
* Author: Mohamed Abbas mohamed_abbas02@aucegypt 
          Omar Bahgat omar_bahgat@aucegypt.edu
* Description: Shifter
*
* Change history: 
**********************************************************************/


module Shift(
    input [31:0] A, 
    input [4:0] Shamt, 
    input [1:0] Type, 
    output reg [31:0] ShiftOutput
    );
    always @(*) begin
        case(Type)
         2'b00: ShiftOutput = A >> Shamt;   //SRL
         2'b01: ShiftOutput = A << Shamt;   //SLL
         2'b10: ShiftOutput = A >>> Shamt;  //SRA
        endcase
    end
endmodule