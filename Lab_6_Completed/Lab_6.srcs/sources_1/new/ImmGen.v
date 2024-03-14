`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/20/2024 10:11:22 AM
// Design Name: 
// Module Name: ImmGen
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
module ImmGen (input [31:0] inst, output reg[31:0] gen_out);
    wire [6:0] opcode;
    assign opcode = inst[6:0];
    
    always @(*) begin
        if(opcode[6] == 1'b0) begin 
            // LW
            if(opcode[5] == 1'b0) begin 
                 gen_out = inst[31:20];
            end 
            // SW
            else begin 
                 gen_out = {inst[31:25], inst[11:7]};
            end
        end
        // BEQ
        else begin 
             gen_out = {inst[31], inst[7], inst[30:25], inst[11:8]};
        end
        
        // Sign extension
        if(gen_out[11] == 1'b0)
             gen_out = {20'b0, gen_out[11:0]};
        else 
             gen_out = {20'b1, gen_out[11:0]};
      end
        
endmodule
