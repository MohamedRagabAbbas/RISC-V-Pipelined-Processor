`timescale 1ns / 1ps

/*******************************************************************
*
* Module: FullAdder.v
* Project: Milestone 2
* Author: Mohamed Abbas mohamed_abbas02@aucegypt 
          Omar Bahgat omar_bahgat@aucegypt.edu
* Description: Full Adder
*
* Change history: 
**********************************************************************/


module FullAdder(
    input A, B, Cin,
    output Sum, Cout
    );
    
    assign {Cout, Sum} = A + B + Cin;
    
endmodule