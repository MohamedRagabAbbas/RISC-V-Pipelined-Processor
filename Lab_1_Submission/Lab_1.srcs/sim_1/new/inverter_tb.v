`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/06/2024 09:31:24 AM
// Design Name: 
// Module Name: inverter_tb
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


module inverter_tb();

    reg A;
    wire B;
    
    inverter DUT(.A(A),.B(B));
    
    initial begin
        A = 1'b0;
        #100
        A = 1'b1;
        #100
        A = 1'b0;
        #100
        A = 1'b1;
    end
    
endmodule
