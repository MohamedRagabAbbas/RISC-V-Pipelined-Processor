`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/02/2024 02:36:57 PM
// Design Name: 
// Module Name: ForwardingUnit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ForwardingUnit(
        input [4:0] ID_EX_Rs1,
        input [4:0] ID_EX_Rs2,
        input [4:0] EX_MEM_Rd,
        input [4:0] MEM_WB_Rd,
        input EX_MEM_RegWrite,
        input MEM_WB_RegWrite,
        output reg [1:0] forwardA,
        output reg [1:0] forwardB
    );
    
    always @(*) begin
        if((EX_MEM_RegWrite == 1'b1) && ( EX_MEM_Rd != 0) && (ID_EX_Rs1 == EX_MEM_Rd))
            forwardA = 2'b10;
        else if ((MEM_WB_RegWrite == 1'b1) && ( MEM_WB_Rd != 0) && (ID_EX_Rs1 == MEM_WB_Rd))
            forwardA = 2'b01;
        else forwardA = 2'b00;
        
        if((EX_MEM_RegWrite == 1'b1) && ( EX_MEM_Rd != 0) && (ID_EX_Rs2 == EX_MEM_Rd))
            forwardB = 2'b10;
        else if ((MEM_WB_RegWrite == 1'b1) && ( MEM_WB_Rd != 0) && (ID_EX_Rs2 == MEM_WB_Rd))
            forwardB = 2'b01;
        else forwardB = 2'b00;
    
    end
  
endmodule
