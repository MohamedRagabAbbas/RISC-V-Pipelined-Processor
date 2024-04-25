`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/20/2024 09:50:14 AM
// Design Name: 
// Module Name: n_bit_left_shift_tb
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


module n_bit_left_shift_tb();

    localparam n = 32;
    reg [n-1:0] A;
    wire [n-1:0] Y;
    
    n_bit_left_shift DUT(.A(A), .Y(Y));
    
    initial begin
        A = 2;
        #100
        A = 7;
        #100
        A = 21;
    end
endmodule
