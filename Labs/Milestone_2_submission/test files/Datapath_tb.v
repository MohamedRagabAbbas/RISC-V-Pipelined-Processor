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
module LoadUnit(
    input [31:0] MemOut,
    input [2:0] funct3,
    output reg [31:0] MemOut2
    );
    
    always @(*) begin
        case(funct3)
            3'b000: MemOut2 = {MemOut[7]? 24'b1 : 24'b0, MemOut[7:0]};
            3'b001: MemOut2 = {MemOut[15]? 16'b1 : 16'b0, MemOut[15:0]};
            3'b010: MemOut2 = MemOut;
            3'b100: MemOut2 = MemOut[7:0];
            3'b101: MemOut2 = MemOut[15:0];
        endcase
    end
    
endmodule

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