`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/02/2024 02:33:30 PM
// Design Name: 
// Module Name: MUX4x1
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


module MUX4x1(
        input [31:0] a, b, c,
        input [1:0] sel,
        output reg [31:0] Y
    );
    
    always @(*) begin
        case(sel)
            2'b00: Y = a;
            2'b01: Y = b;
            2'b10: Y = c;
            default: Y = 32'b0;
        endcase
    end
    
endmodule




