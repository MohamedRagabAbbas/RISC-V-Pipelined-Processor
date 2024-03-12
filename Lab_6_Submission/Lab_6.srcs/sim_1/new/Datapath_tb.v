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
    wire [15:0] out;
    
    Datapath DUT(clk, rst, ledSel, out);
    
    initial begin
        clk = 0;
        forever #(period/2) clk = ~clk;
    end
    
    initial begin 
        clk = 0; rst = 1;
        #100
        clk = 1; rst = 0; ledSel = 2'b00;
        #100 
        clk = 0;
        #100
        clk = 1; rst = 0; ledSel = 2'b01;
        #100 
        clk = 0;
        #100
        clk = 1; rst = 0; ledSel = 2'b10;
    end
    
endmodule
