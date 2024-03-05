`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/05/2024 08:53:19 AM
// Design Name: 
// Module Name: InstMem_tb
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


module InstMem_tb();
    reg [5:0] addr;
    wire [31:0] data_out;
    
    InstMem DUT(addr, data_out);
    
    initial begin
        addr = 0;
        #100
        addr = 1;
        #100
        addr = 2;
        #100
        addr = 3;
        #100
        addr = 4;
        #100
        addr = 5;
    end
    
endmodule
