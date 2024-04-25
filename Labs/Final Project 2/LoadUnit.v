`timescale 1ns / 1ps

/*******************************************************************
*
* Module: LoadUnit.v
* Project: Milestone 2
* Author: Mohamed Abbas mohamed_abbas02@aucegypt 
          Omar Bahgat omar_bahgat@aucegypt.edu
* Description: Instruction Memory
*
* Change history: 
**********************************************************************/



module LoadUnit(
    input [31:0] MemOut,
    input [2:0] funct3,
    output reg [31:0] MemOut2
    );
    
    always @(*) begin
        case(funct3)
            3'b000: MemOut2 =  (MemOut[7] == 1'b1) ? {24'b1111_1111_1111_1111_1111_1111 , MemOut[7:0]} : {24'b0 , MemOut[7:0]};
            3'b001: MemOut2 =  (MemOut[15] == 1'b1) ? {16'b1111_1111_1111_1111 , MemOut[15:0]} : {16'b0 , MemOut[15:0]};
            3'b010: MemOut2 = MemOut;
            3'b100: MemOut2 = MemOut[7:0];
            3'b101: MemOut2 = MemOut[15:0];
        endcase
    end
    
endmodule

