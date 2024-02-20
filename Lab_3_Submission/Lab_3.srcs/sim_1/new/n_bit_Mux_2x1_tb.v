`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/20/2024 09:44:52 AM
// Design Name: 
// Module Name: n_bit_Mux_2x1_tb
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


module n_bit_Mux_2x1_tb();

    localparam n = 32;
    
    reg [n-1:0] A;
    reg [n-1:0] B;
    reg sel;
    wire [n-1:0] Y;
    
    n_bit_Mux_2x1 DUT(.A(A), .B(B), .sel(sel), .Y(Y));
    
    initial begin
        A = 10; B = 20; sel = 0;
        #100 
        A = 10; B = 20; sel  = 1;
    end
endmodule
