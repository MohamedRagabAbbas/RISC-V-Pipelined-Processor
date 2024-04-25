`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/09/2021 11:56:53 AM
// Design Name: 
// Module Name: forwarding_unit
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


module forwarding_unit(input [4:0] ID_EX_Rs1, [4:0]ID_EX_Rs2, [4:0] EX_MEM_Rd, [4:0]MEM_WB_Rd, input MEM_WB_RegWrite, EX_MEM_RegWrite, output reg[1:0] forwardA, output reg[1:0] forwardB);

always@(*) begin
    if ( EX_MEM_RegWrite && (EX_MEM_Rd != 0) && (EX_MEM_Rd == ID_EX_Rs1) )
            forwardA = 2'b10;
    else if ( EX_MEM_RegWrite && (EX_MEM_Rd != 0) && (EX_MEM_Rd == ID_EX_Rs2) )
            forwardB = 2'b10;
    else if ( MEM_WB_RegWrite && (MEM_WB_Rd != 0) && (MEM_WB_Rd == ID_EX_Rs1) )
            forwardA = 2'b01;
    else if ( MEM_WB_RegWrite && (MEM_WB_Rd != 0) && (MEM_WB_Rd == ID_EX_Rs2) )
            forwardB = 2'b01;
    else begin
        forwardA = 0;
        forwardB = 0;
    end
end
endmodule
