`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/20/2024 09:16:15 AM
// Design Name: 
// Module Name: n_bit_register_tb
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


module n_bit_register_tb();
   
    localparam n = 8;
    localparam period = 10;
    
    reg [n-1:0] D;
    reg clk;
    reg load;
    reg rst;
    wire [n-1:0] Q;
    
    n_bit_register DUT(.D(D), .load(load), .clk(clk), .rst(rst), .Q(Q));
    
    initial begin
        clk = 1'b0;
        forever #(period/2) clk = ~clk;
    end
    
    initial begin 
        rst=1; D = 0; load = 0;
        #(period * 2) rst=0;
        D = 20; load = 1'b1;
        #(period)
        D = 30; load = 1'b0;
        #(period)
        load = 1'b1;
        #(period);
    end
    
endmodule
