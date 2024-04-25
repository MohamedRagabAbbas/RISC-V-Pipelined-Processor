`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/12/2024 01:59:21 PM
// Design Name: 
// Module Name: Datapath_tb
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


module Datapath_tb();
    
    localparam period = 100;
    
    reg clk;
    reg rst;
    reg [1:0] ledSel;
    reg [3:0] ssdSel;
    wire [15:0] leds;
    wire [12:0] ssd;
    
    Datapath DUT(clk, rst, ledSel, ssdSel, leds, ssd);
    
    initial begin
        clk = 0;
        forever #(period/2) clk = ~clk;
    end
    
    initial begin 
        rst = 1;
        #100
        rst = 0; ledSel = 0; ssdSel = 0;
        #100
        ledSel = 0; ssdSel = 0;
        #100
        ledSel = 2; ssdSel = 2;
        #100 
        #100 
        #100 
        #100 
        #100 
        #100 
        #100 
        #100 
        #100
        #100
        #100 
        #100 
        #100
        rst = 0;
    end
    
endmodule