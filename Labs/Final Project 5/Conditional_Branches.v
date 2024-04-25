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
    input [1:0] branchOp,
    input [2:0] func3,
    input zf, cf, vf, sf,
    output reg [1:0]result 
    );
    
    always@(*) begin
        case(branchOp)
            2'b00:result =2'b00;
            2'b01: begin
                case(func3)
                    0: result = (zf==1)?1:0;           //BEQ
                    1: result = (zf!=1)? 1:0;          //BNQ
                    4: result = (sf != vf)?1:0;     //BLT
                    5: result = (sf == vf)?1:0;     //BGE
                    6: result = (cf!=1)?1:0;          // BLTU
                    7: result = (cf==1)?1:0;           // BGEU
                    default: result = 0;
                 endcase
                end
            2'b10:result = 2'b01; // Jal
            2'b11:result = 2'b10; // JalR
        endcase
    end
endmodule