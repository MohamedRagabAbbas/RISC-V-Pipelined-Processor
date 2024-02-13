`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/13/2024 10:23:23 AM
// Design Name: 
// Module Name: Seven_Segment_Negative_Number
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


module Seven_Segment_Negative_Number(
    input clk,
    input [7:0] num, 
    output reg [3:0] Anode, 
    output reg [6:0] LED_out
    );
    
    reg [3:0] LED_BCD;
    reg [19:0] refresh_counter = 0; // 20-bit counter
    wire [1:0] LED_activating_counter; 
    
    always @(posedge clk)
        begin
            refresh_counter <= refresh_counter + 1;
        end
        
    assign LED_activating_counter = refresh_counter[19:18]; 
    
    wire [3:0] Thousands;
    wire [3:0] Thousands2;
    wire [7:0] num2;
    wire [3:0] Hundreds;
    wire [3:0] Tens;
    wire [3:0] Ones;
    
    wire flag = num[7];
    assign num2 = flag ? ~num + 1 : num;
    
    
    BCD bcd({6'd0, num2[6:0]}, Thousands2, Hundreds, Tens, Ones);
    
    assign Thousands = flag ? 10 : 11;
    
    always @(*)
        begin
            case(LED_activating_counter) 
            2'b00: begin
                Anode = 4'b0111; 
                LED_BCD = Thousands;
                end
            2'b01: begin
                Anode = 4'b1011;
                LED_BCD = Hundreds;
                end
            2'b10: begin
                Anode = 4'b1101;
                LED_BCD = Tens;
                end
            2'b11: begin
                Anode = 4'b1110;
                LED_BCD = Ones;
                end 
            endcase 
        end
    always @(*)
        begin
            case(LED_BCD)
                4'b0000: LED_out = 7'b0000001; // "0"
                4'b0001: LED_out = 7'b1001111; // "1"
                4'b0010: LED_out = 7'b0010010; // "2"
                4'b0011: LED_out = 7'b0000110; // "3"
                4'b0100: LED_out = 7'b1001100; // "4"
                4'b0101: LED_out = 7'b0100100; // "5"
                4'b0110: LED_out = 7'b0100000; // "6"
                4'b0111: LED_out = 7'b0001111; // "7"
                4'b1000: LED_out = 7'b0000000; // "8"
                4'b1001: LED_out = 7'b0000100; // "9"
                4'b1010: LED_out = 7'b1111110; // "-"
                4'b1011: LED_out = 7'b1111111; // "+"
                default: LED_out = 7'b0000001; // "0"
            endcase 
        end
endmodule
