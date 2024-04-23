`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/23/2024 09:45:55 AM
// Design Name: 
// Module Name: DataCacheController
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


module DataCacheController ( 
    input clk, 
    input MemRead, 
    input MemWrite, 
    input [4:0] index, 
    input [2:0] tag, 
    output reg stall, 
    output reg fill, 
    output reg update, 
    output reg MsRead, 
    input MsReady
    ); 
    
    reg [2:0] tags [0:31]; 
    reg valid_bits [0:31];
    
    integer i;
    initial begin 
        for(i = 0; i < 32; i = i+1) begin
            tags[i] = 3'b0;
            valid_bits[i] = 1'b0;   
         end   
            stall = 0; fill = 0; update = 0; MsRead = 0;
    end
   
    reg [1:0] state, nextState;
    parameter [1:0] Idle = 2'b00, Read = 2'b01, Write = 2'b10;
    
    always @ ( clk) begin
        case (state)
        
            Idle: begin
                    if(MemWrite) begin
                        if(valid_bits[index] && tag == tags[index]) update = 1;
                        stall = 1;
                        nextState = Write;
                    end
                    else if (MemRead) begin
                        if((valid_bits[index] && tag == tags[index]) == 0) MsRead = 1; 
                        stall = 1;
                        nextState = Read;
                    end
                    else begin
                        stall = 0; fill = 0; update = 0; MsRead = 0;
                    end
                end
                
             Write: begin
                      if(MsReady == 1) nextState = Idle;
                      else nextState = Write;
                    end 
                    
             Read: begin 
                     if(MsReady == 1) begin
                        fill = 1;
                        valid_bits[index] = 1;
                        tags[index] = tag;
                        nextState = Idle;
                     end
                     else nextState = Read;
                   end
            default: nextState = Idle;
        endcase
    end
    
    always @ ( clk) begin 
        state <= nextState;
    end

endmodule 
