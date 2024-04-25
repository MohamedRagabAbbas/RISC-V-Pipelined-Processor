`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2024 10:17:04 AM
// Design Name: 
// Module Name: RegFile
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


module RegFile #(parameter N = 32)(
    input [4:0] src1,
    input [4:0] src2,
    input [4:0] dest,
    input [N-1:0] data,
    input clk,
    input rst,
    input RegWrite,
    output [N-1:0] out1,
    output [N-1:0] out2
    );
    
    reg [N-1:0] registers [N-1:0];
    integer i;
    always @(clk) begin
        if(rst == 1'b1) begin
            for(i = 0; i < N; i = i + 1) begin
                registers[i] <= 0;
            end
        end
        else begin
            if(RegWrite == 1'b1 && dest != 0) begin
                registers[dest] <= data;
            end
        end
    end
    assign out1 = registers[src1];
    assign out2 = registers[src2];
endmodule