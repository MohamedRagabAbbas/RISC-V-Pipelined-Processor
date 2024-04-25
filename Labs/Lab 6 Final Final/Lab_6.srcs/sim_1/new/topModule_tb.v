`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/19/2024 12:53:06 PM
// Design Name: 
// Module Name: topModule_tb
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


module topModule_tb(

    );
    
    localparam period1 = 50;
    localparam period2 = 200;
   
    reg clk;
    reg ssdClk;
    reg rst;
    reg [1:0] ledSel;
    reg [3:0] ssdSel;
    wire [15:0] leds;
    wire [3:0] Anode;
    wire [6:0] LED_out;
    
    topModule DUT(clk, ssdClk, rst, ledSel, ssdSel, leds, Anode, LED_out);
    
    initial begin
        clk = 0;
        forever #(period2/2) clk = ~clk;
    end
    
        initial begin
        ssdClk = 0; 
        forever #(period1/2) ssdClk = ~ssdClk;
    end
    

    initial begin
        rst = 1;
        #5
        rst = 0; 
        #period2
        ledSel = 0; ssdSel = 0;
        #period2 
        ledSel = 0; ssdSel = 0;
    end
endmodule
