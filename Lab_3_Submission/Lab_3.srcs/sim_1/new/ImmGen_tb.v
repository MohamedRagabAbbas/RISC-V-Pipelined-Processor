`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/20/2024 10:33:24 AM
// Design Name: 
// Module Name: ImmGen_tb
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


module ImmGen_tb();
    reg [31:0] inst;
    wire [31:0] gen_out;
    
    ImmGen DUT(.inst(inst), .gen_out(gen_out));
    
    initial begin
        // LW 
        inst = 32'b00000000100000110010001010000011;
        #100 
        //SW 
        inst = 32'b00000000010100110010010000100011;
        #100 
        // BEQ
        inst = 32'b00000000000000000000001001100011;
    end
endmodule
