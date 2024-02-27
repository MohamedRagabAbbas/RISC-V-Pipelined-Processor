`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2024 11:15:41 AM
// Design Name: 
// Module Name: ALU_control_unit
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


module ALU_control_unit(
    input [1:0] ALUop,
    input [2:0] inst,
    input inst1,
    output reg [3:0] ALUsel
    );
    
    always @(*) begin
        // 00
        if(ALUop == 2'b00) begin
            ALUsel = 4'b0010;
        end
        // 01
        else if(ALUop == 2'b01) begin
            ALUsel = 4'b0110;
        end
        else if(ALUop == 2'b10) begin
            if(inst == 3'b000) begin 
                if(inst1 == 0)
                    ALUsel = 4'b0010;
                 else if(inst1 == 1)
                    ALUsel = 4'b0110;
            end
            else if(inst == 3'b111) begin
                if(inst1 == 1'b0)
                    ALUsel = 4'b0000;
            end
            else if(inst == 3'b110) begin
                if(inst1 == 1'b0)
                    ALUsel = 4'b0001;
            end
        end
    end
endmodule
