`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/05/2024 09:09:13 AM
// Design Name: 
// Module Name: DataMem
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


module DataMem (
    input clk, 
    input MemRead, 
    input MemWrite,
    input [2:0] funct3,
    input [7:0] addr, 
    input [31:0] data_in, 
    output reg [31:0] data_out
    );
    //reg [31:0] mem [0:63];
    reg [7:0] mem [0:255];
    initial begin
        mem[0]=32'd149; //  10010101
        mem[1]=32'd137; //  10001001
        mem[2]=32'd89;  //  01011001
        mem[3]=32'd74;  //  01001010
    end
    always @(posedge clk) begin
        if(MemWrite == 1)
            begin
               case(funct3) 
                  3'b000: mem[addr] = data_in[7:0];
                  3'b001: 
                      begin 
                        mem[addr] = data_in[7:0];
                        mem[addr+1] = data_in[15:8];
                      end
                  3'b010:
                       begin 
                        mem[addr] = data_in[7:0];
                        mem[addr+1] = data_in[15:8];
                        mem[addr+2] = data_in[23:15];
                        mem[addr+3] = data_in[31:24];
                       end
                endcase
            end 
    end
    
    always @(*) begin
             if (MemRead) 
             begin
                begin
                    case(funct3)
                        3'b000: data_out <= {{24{mem[addr][7]}},mem[addr]};//lb
                        3'b001: data_out <= {{16{mem[addr+1][7]}},mem[addr+1],mem[addr]};//lh       
                        3'b010: data_out <= {mem[addr+3],mem[addr+2],mem[addr+1],mem[addr]};//lw         
                        3'b100: data_out <= {24'd0,mem[addr]};//lbu
                        3'b101: data_out <= {16'd0,mem[addr+1],mem[addr]};//lhu
                        default: data_out <= 0;
                    endcase 
                end
            end
        
    end
endmodule 