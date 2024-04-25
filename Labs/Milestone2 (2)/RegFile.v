`timescale 1ns / 1ps

/*******************************************************************
*
* Module: RegFile.v
* Project: Milestone 2
* Author: Mohamed Abbas mohamed_abbas02@aucegypt 
          Omar Bahgat omar_bahgat@aucegypt.edu
* Description: Register File 
*
* Change history: 
**********************************************************************/


module RegFile #(parameter N = 32)(
    input clk,
    input rst,
    input RegWrite,
    input [4:0] rs1,
    input [4:0] rs2,
    input [4:0] rd,
    input [N-1:0] write_data,
    output [N-1:0] read_data_1,
    output [N-1:0] read_data_2
    );
    
    reg [N-1:0] registers [N-1:0];
    integer i;
    always @(posedge clk) begin
        if(rst == 1'b1) begin
            for(i = 0; i < N; i = i + 1) begin
                registers[i] <= 0;
            end
        end
        else begin
            if(RegWrite == 1'b1 && rd != 0) begin
                registers[rd] <= write_data;
            end
        end
    end
    assign read_data_1 = registers[rs1];
    assign read_data_2 = registers[rs2];
endmodule