`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2024 09:37:41 AM
// Design Name: 
// Module Name: N_Bit_ALU_tb
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


module N_Bit_ALU_tb();
    
    localparam N = 32;
    
    reg [N-1:0] A;
    reg [N-1:0] B;
    reg [3:0] sel;
    wire [N-1:0] ALUOutput;
    wire CarryOut_add;
    wire CarryOut_sub;
    wire zeroFlag;
    
    N_Bit_ALU DUT(A, B, sel, ALUOutput, CarryOut_add, CarryOut_sub, zeroFlag);
    
    initial begin
        A = 7; B = 3; sel = 4'b0010;
        #100;
        A = 7; B = 3; sel = 4'b0110;
        #100 
        A = 7; B = 3; sel = 4'b0000;
        #100
        A = 7; B = 3; sel = 4'b0001;
        #100 
        A = 5; B = 5; sel = 4'b0110;
    end
    
endmodule
