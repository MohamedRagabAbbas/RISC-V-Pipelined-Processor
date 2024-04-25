`timescale 1ns / 1ps

/*******************************************************************
*
* Module: topModule.v
* Project: Milestone 2
* Author: Mohamed Abbas mohamed_abbas02@aucegypt 
          Omar Bahgat omar_bahgat@aucegypt.edu
* Description: Top Module (starting point of our program)
*
* Change history: 
**********************************************************************/


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