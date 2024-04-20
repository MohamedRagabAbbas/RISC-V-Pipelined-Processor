`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/14/2024 01:47:46 PM
// Design Name: 
// Module Name: topModule
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


module topModule(
    input clk,
    input ssdClk,
    input rst,
    input [1:0] ledSel,
    input [3:0] ssdSel,
    output [15:0] leds,
    output [3:0] Anode, 
    output [6:0] LED_out
    );
    
    wire [12:0] sevSegOutput;
    Datapath datapath(clk, rst, ledSel, ssdSel, leds, sevSegOutput);
    Four_Digit_Seven_Segment_Driver_Optimized sevSeg(ssdClk, sevSegOutput, Anode, LED_out);
    
endmodule
