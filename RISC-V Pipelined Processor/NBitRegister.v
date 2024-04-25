`timescale 1ns / 1ps
/*******************************************************************
*
* Module: RISCV_pipeline.v
* Project: NBitRegister 3
* Author: Mohamed Abbas mohamed_Ragab02@aucegypt 
          Omar Bahgat omar_bahgat@aucegypt.edu
* Description: NBitRegister
*
* Change history: 
**********************************************************************/


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