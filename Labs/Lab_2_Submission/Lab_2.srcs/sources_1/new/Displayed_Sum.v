`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/13/2024 09:26:01 AM
// Design Name: 
// Module Name: Displayed_Sum
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


module Displayed_Sum #(parameter N = 8)(
    input clk,
    input [N-1:0] A, B,
    output [3:0] Anode, 
    output [6:0] LED_out
    );
    
    wire [N:0] Sum;
     RCA_8  #(8) RCA(A, B, Sum);
    
    Four_Digit_Seven_Segment_Driver_Optimized inst(clk, {4'b0, Sum}, Anode, LED_out);
    
endmodule
