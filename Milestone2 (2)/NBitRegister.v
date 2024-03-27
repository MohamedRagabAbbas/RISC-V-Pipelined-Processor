`timescale 1ns / 1ps

/*******************************************************************
*
* Module: NBitRegister.v
* Project: Milestone 2
* Author: Mohamed Abbas mohamed_abbas02@aucegypt 
          Omar Bahgat omar_bahgat@aucegypt.edu
* Description: N-bit Register
*
* Change history: 
**********************************************************************/


module NBitRegister #(parameter N = 32)(
    input clk,
    input rst,
    input load,
    input [N-1:0] D,
    output [N-1:0] Q
);
    
    wire [N-1:0] out;
    genvar i;
    generate
        for(i = 0; i < N; i = i + 1)
        begin: Gen_Modules
        MUX2x1 mux(.A(D[i]), .B(Q[i]), .sel(load), .Y(out[i])); 
        DFlipFlop flip_flop(.clk(clk), .rst(rst), .D(out[i]), .Q(Q[i]));
        end
     endgenerate
endmodule