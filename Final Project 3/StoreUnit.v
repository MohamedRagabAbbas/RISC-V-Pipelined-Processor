`timescale 1ns / 1ps

/*******************************************************************
*
* Module: StoreUnit.v
* Project: Milestone 2
* Author: Mohamed Abbas mohamed_abbas02@aucegypt 
          Omar Bahgat omar_bahgat@aucegypt.edu
* Description: Storing Unit
*
* Change history: 
**********************************************************************/


module StoreUnit(
    input [31:0] RegOut2,
    input [2:0] funct3,
    output reg [31:0] MemIn
    );
    
  always @(*) begin
    case(funct3)
        3'b000: MemIn =  RegOut2[7:0];
        3'b001: MemIn =  RegOut2[15:0];
        3'b010: MemIn =  RegOut2;
    endcase
  end
    
    
endmodule
