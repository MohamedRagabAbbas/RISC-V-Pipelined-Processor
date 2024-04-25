`timescale 1ns / 1ps

/*******************************************************************
*
* Module: Conditional_Branches.v
* Project: Milestone 2
* Author: Mohamed Abbas mohamed_abbas02@aucegypt 
          Omar Bahgat omar_bahgat@aucegypt.edu
* Description: Branch control unit
*
* Change history: 
**********************************************************************/


module Conditional_Branches(
    input [2:0] func3,
    input zf, cf, vf, sf,
    output reg result 
    );
    
    always@(*) begin
        case(func3)
            0: result = zf;           //BEQ
            1: result = ~zf;          //BNQ
            4: result = sf != vf;   //BLT
            5: result = sf == vf;   //BGE
            6: result = ~cf;          // BLTU
            7: result = cf;           // BGEU
            default: result = 0;
        endcase
    end
endmodule