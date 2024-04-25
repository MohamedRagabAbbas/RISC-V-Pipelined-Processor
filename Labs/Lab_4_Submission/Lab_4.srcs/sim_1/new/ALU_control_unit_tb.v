`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2024 11:22:44 AM
// Design Name: 
// Module Name: ALU_control_unit_tb
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


module ALU_control_unit_tb();
    reg [1:0] ALUop;
    reg [2:0] inst;
    reg inst1;
    wire [3:0] ALUsel;
    
    ALU_control_unit DUT(ALUop, inst, inst1, ALUsel);
    
    initial begin
        ALUop = 2'b00;
        #100  
        ALUop = 2'b01; 
        #100  
        ALUop = 2'b10; inst = 3'b000; inst1 = 1'b0;
        #100  
        ALUop = 2'b10; inst = 3'b000; inst1 = 1'b1;
        #100  
        ALUop = 2'b10; inst = 3'b111; inst1 = 1'b0;
        #100  
        ALUop = 2'b10; inst = 3'b110; inst1 = 1'b0;
    end
endmodule
