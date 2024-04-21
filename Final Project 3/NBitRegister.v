`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/20/2024 09:05:53 AM
// Design Name: 
// Module Name: n_bit_register
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


module NBitRegister #(parameter n = 32)(
    input clk,
    input rst,
    input load,
    input [n-1:0] D,
    output [n-1:0] Q
    );
    
    wire [n-1:0] out;
    genvar i;
    generate
        for(i = 0; i < n; i = i + 1)
        begin: Gen_Modules
        MUX2x1 mux(.A(D[i]), .B(Q[i]), .sel(load), .Y(out[i])); 
        DFlipFlop flip_flop(.clk(clk), .rst(rst), .D(out[i]), .Q(Q[i]));
        end
     endgenerate
endmodule