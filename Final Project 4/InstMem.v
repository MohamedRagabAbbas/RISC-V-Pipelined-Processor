`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/05/2024 08:44:46 AM
// Design Name: 
// Module Name: InstMem
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

module InstMem (
    input [5:0] addr, 
    output [31:0] data_out
    ); 
    reg [31:0] mem [0:63];
    
   initial begin
//        mem[0]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0//added to be skipped since PC starts with 4 after reset 
//        mem[1]=32'b000000000000_00000_010_00001_0000011 ; //lw x1, 0(x0)  17
//        mem[2]=32'b000000000100_00000_010_00010_0000011 ; //lw x2, 4(x0)  9 
//        mem[3]=32'b000000001000_00000_010_00011_0000011 ; //lw x3, 8(x0)  25
//        mem[4]=32'b0000000_00010_00001_110_00100_0110011 ; //or x4, x1, x2  25
//        mem[5]=32'b0000_0000_0011_0010_0000_0100_0110_0011; //beq x4, x3, 4  0 
//        mem[6]=32'b0000000_00010_00001_000_00011_0110011 ; //add x3, x1, x2 
//        mem[7]=32'b0000000_00010_00011_000_00101_0110011 ; //add x5, x3, x2    34  
//        mem[8]=32'b0000000_00101_00000_010_01100_0100011; //sw x5, 12(x0) 0
//        mem[9]=32'b000000001100_00000_010_00110_0000011 ; //lw x6, 12(x0)  34
//        mem[10]=32'b0000000_00001_00110_111_00111_0110011 ; //and x7, x6, x1 0
//        mem[11]=32'b0100000_00010_00001_000_01000_0110011 ; //sub x8, x1, x2  8
//        mem[12]=32'b0000000_00010_00001_000_00000_0110011 ; //add x0, x1, x2  26
//        mem[13]=32'b0000000_00001_00000_000_01001_0110011 ; //add x9, x0, x1 17


        // # Assign values to registers
        mem[0]=32'b00000000001000000000000010010011;    // addi x1, x0, 2      2  tested
        mem[1]=32'b00000000011000000000000100010011;    // addi x2, x0, 6      #  write_data = 6     tested
        mem[2]=32'b00000001000100000000000110010011;    // addi x3, x0, 17     #  write_data = 17    tested
        mem[3]=32'b00000010010000000000001000010011;    // addi x4, x0, 36     #  write_data = 36    tested
        mem[4]=32'b00100011010000000000001010010011;    // addi x5, x0, 564    #  write_data = 564   tested
        mem[5]=32'b00000000010100101000001010110011;    // add x5, x5, x5      #  write_data = 1128  tested

        // # Test ADD operation
        mem[6]=32'b00000000010000011000001100110011;    // add x6, x3, x4      #   write_data = 53   tested
        //# Test SUB operation
        mem[7]=32'b01000000001000100000001110110011;    // sub x7, x4, x2      #  write_data = 30  tested
        // # Test XOR operation
        mem[8]=32'b00000000001000100100010000110011;    // xor x8, x4, x2      #    write_data = 34 tested
        // # Test OR operation
        mem[9]=32'b00000000001000100110010010110011;    // or x9, x4, x2       #  write_data = 38 tested
        // # Test AND operation
        mem[10]=32'b00000000001000100111010100110011;   // and x10, x4, x2      #  write_data = 4 tested
        // # Test SLL operation 
        mem[11]=32'b00000000000100100001010110110011;// sll x11, x4, x1      # x1 << x2  144 tested
        // # Test SRL operation
        mem[12]=32'b00000000000100100101011000110011;// srl x12, x4, x1      # x2 >> x1  9 tested
        // # Test SRA operation
        mem[13]=32'b01000000000100100101011010110011;// sra x13, x4, x1     # x1 >> x2   9 tested
        // # Test ADDI operation
        mem[14]=32'b00000000011100010000011100010011;// addi x14, x2, 7     # 13         tested
        // # Test XORI operation
        mem[15]=32'b00000000111100010100011110010011;// xori x15, x2, 15    # 9          tested
        // # Test ORI operation 
        mem[16]=32'b00000001010000001110100000010011;// ori x16, x1, 20     # 22         tested
        // # Test SLLI operation
        mem[17]=32'b00000000010100101001100010010011;// slli x17, x5, 5     #  x5 << 5   36096   tested
        // # Test SRLI operation 
        mem[18]=32'b00000000010100100101100100010011;// srli x18, x4, 5     # x4 >> 5     1   tested
        // # Test SRAI operation
        mem[19]=32'b01000000000100010101100110010011;// srai x19, x2, 1     # x2 >> 1  needs to be tested again

         // # Assign values to registers
        mem[20]=32'b00000010010000000000101000010011; // addi x20,x0,36   # write_data = 36
        // # Test BEQ taken  tested
        mem[21]=32'b00000001010000100000010001100011; // beq x4, x20, eq_label # Branch if x20 == x4
        mem[22]=32'b00000000000100000000101010010011; // addi x21, x0, 1     # x21 = 1
        mem[23]=32'b00000000001000000000101010010011; // eq_label: addi x21, x0, 2     # x21 = 2
        // # Test BEQ not taken tested
        mem[24]=32'b00000001010000101000010001100011; // beq x5, x20, eq_label2 # Branch if x20 == x5
        mem[25]=32'b00000000000100000000101010010011; // addi x21, x0, 1     # x21 = 1
        mem[26]=32'b00000000001000000000101010010011; // eq_label2: addi x21, x0, 2     # x21 = 2
        // # Test BNE taken  tested
        mem[27]=32'b00000000001000001001010001100011; // bne x1, x2, ne_label # Branch if x1 != x2  
        mem[28]=32'b00000000000100000000101100010011; // addi x22, x0, 1     # x22 = 1
        mem[29]=32'b00000000001000000000101100010011; // ne_label: addi x22, x0, 2     # x22 = 2
        // # Test BNE not taken tested
        mem[30]=32'b00000001010000100001010001100011; // bne x4, x20, ne_label2 # Branch if x4 != x20 
        mem[31]=32'b00000000000100000000101100010011; // addi x22, x0, 1     # x22 = 1
        mem[32]=32'b00000000001000000000101100010011; // ne_label2: addi x22, x0, 2     # x22 = 2
        // # Test BLT taken tested
        mem[33]=32'b00000000001000001100010001100011; // blt x1, x2, lt_label # Branch if x1 < x2 2<6
        mem[34]=32'b00000000000100000000101110010011; // addi x23, x0, 1     # x23 = 1
        mem[35]=32'b00000000001000000000101110010011; // lt_label: addi x23, x0, 2    # x23 = 2
        // # Test BLT not taken tested
        mem[36]=32'b00000000000100010100010001100011; // blt x2, x1, lt_label2 # Branch if x2 < x1
        mem[37]=32'b00000000000100000000101110010011; // addi x23, x0, 1     # x23 = 1
        mem[38]=32'b00000000001000000000101110010011; // lt_label2: addi x23, x0, 2    # x23 = 2
        // # Test BGE taken tested
        mem[39]=32'b00000000001100100101010001100011; // bge x4, x3, ge_label # Branch if x4 >= x3
        mem[40]=32'b00000000000100000000110000010011; // addi x24, x0, 1     # x24 = 1
        mem[41]=32'b00000000001000000000110000010011; // ge_label: addi x24, x0, 2     # x20 = 2
        // # Test BGE not taken tested
        mem[42]=32'b00000000010000011101010001100011; // bge x3, x4, ge_label2 # Branch if x3 >= x4
        mem[43]=32'b00000000000100000000110000010011; // addi x24, x0, 1     # x24 = 1
        mem[44]=32'b00000000001000000000110000010011; // ge_label2: addi x24, x0, 2     # x20 = 2
        // # Test BLTU taken tested
        mem[45]=32'b00000000001000001110010001100011; // bltu x1, x2, ltu_label # Branch if x1 < x2 (unsigned)
        mem[46]=32'b00000000000100000000110010010011; // addi x25, x0, 1     # x25 = 1
        mem[47]=32'b00000000001000000000110010010011; // ltu_label:addi x25, x0, 2     # x25 = 2
        // # Test BLTU not taken tested
        mem[48]=32'b00000000000100010110010001100011; // bltu x2, x1, ltu_label2 # Branch if x2 < x1 (unsigned)
        mem[49]=32'b00000000000100000000110010010011; // addi x25, x0, 1     # x25 = 1
        mem[50]=32'b00000000001000000000110010010011; // ltu_label2:addi x25, x0, 2     # x25 = 2
        // # Test BGEU taken tested
        mem[51]=32'b00000000001100100111010001100011; // bgeu x4, x3, bgeu_label # Branch if x4 >= x3 (unsigned)
        mem[52]=32'b00000000000100000000110100010011; // addi x26, x0, 1     # x26 = 1
        mem[53]=32'b00000000001000000000110100010011; // bgeu_label: addi x26, x0, 2     # x26 = 2
        // # Test BGEU not taken tested
        mem[54]=32'b00000000010000011111010001100011; //bgeu x3, x4, bgeu_label2 # Branch if x3 >= x4 (unsigned)
        mem[55]=32'b00000000000100000000110110010011; //addi x27, x0, 1     # x27 = 1
        mem[56]=32'b00000000001000000000110110010011; //bgeu_label2: addi x27, x0, 2     # x27 = 2
        // #Set less than instructions
        // # Test SLT operation
        // # The condition is true  tested
        mem[57]=32'b00000000001000001010111000110011; // slt x28, x1, x2      # Set x28 = 1 if x1 < x2, else x26 = 0
        // # The condition is false tested
        mem[58]=32'b00000000000100010010111000110011; //  slt x28, x2, x1      # Set x28 = 1 if x2 < x1, else x26 = 0
        // # Test SLTU operation
        // # The condition is true  tested
        mem[59]=32'b00000000001000001011111010110011; // sltu x29, x1, x2     # Set x29 = 1 if x1 < x2 (unsigned), else x29 = 0
        // # The condition is false tested
        mem[60]=32'b00000000000100010011111010110011; // sltu x29, x2, x1     # Set x29 = 1 if x2 < x1 (unsigned), else x29 = 0
        // # Test SLTI operation
        // # The condition is true  tested
        mem[61]=32'b00000000101000010010111100010011; // slti x30, x2, 10     # Set x30 = 1 if x2 < 10, else x30 = 0
        // # The condition is false tested
        mem[62]=32'b00000000010100010010111100010011; // slti x30, x2, 5     # Set x30 = 1 if x2 < 5, else x30 = 0
        // Test SLTIU operation
        // # The condition is true tested
        mem[63]=32'b00000000101000001011111110010011; // sltiu x31, x1, 10    # Set x31 = 1 if x1 < 10 (unsigned), else x32 = 0
//        // # The condition is false tested
//        mem[64]=32'b00000000010100001011111110010011; // sltiu x31, x1, 5    # Set x31 = 1 if x1 < 5 (unsigned), else x32 = 0

//        // # Initialize memory addresses  tested
//        mem[1]=32'b00000110010000000000101000010011; // addi x20, x0, 100      # Memory address for byte   
//        mem[2]=32'b00000110100000000000101010010011; // addi x21, x0, 104      # Memory address for halfword  
//        mem[3]=32'b00000110110000000000101100010011; // addi x22, x0, 108      # Memory address for word
//        // # Assign values to registers   tested
//        mem[4]=32'b00000000111100000000000010010011; // addi x1, x0, 15        # Data for byte          1111
//        mem[5]=32'b00111110100000000000000100010011; // addi x2, x0, 1000      # Data for halfword	0011_1110_1000
//        mem[6]=32'b00110111111100000000000110010011; // addi x3, x0, 895       # Data for word
//        mem[7]=32'b00110111111100011000000110010011; // addi x3, x3, 895       # Data for word 
//        mem[8]=32'b00000000001100011000000110110011; // add x3, x3, x3         # Data for word 3580
//        mem[9]=32'b00000000001100011000000110110011; // add x3, x3, x3         # Data for word 7160   0001_1011_1111_1000
//        // # Store data into memory tested
//        mem[10]=32'b00000000000110100000000000100011; // sb  x1, 0(x20)          # Store byte     1111  15   tested
//        mem[11]=32'b00000000001010101001000000100011; // sh  x2, 0(x21)          # Store halfword  0011_1110_1000 --> (1110_1000  + 0000_0011)  tested
//        mem[12]=32'b00000000001110110010000000100011; // sw  x3, 0(x22)          # Store word    0001_1011_1111_1000 --?(1111_1000 + 0001_1011) tested
//        // # Load data from memory tested
//        mem[13]=32'b00000000000010100000001000000011; // lb  x4, 0(x20)          # Load byte   15 tested
//        mem[14]=32'b00000000000010101001001010000011; // lh  x5, 0(x21)          # Load halfword 1000 tested
//        mem[15]=32'b00000000000010110010001100000011; // lw  x6, 0(x22)          # Load word  7160 tested
//        // # Sign-extend byte data and load unsigned byte tested
//        mem[16]=32'b00000000000010100100001110000011; // lbu x7, 0(x20)          # Load unsigned byte  15  tested
//        // # Load unsigned halfword tested
//        mem[17]=32'b00000000000010101101010000000011; // lhu x8, 0(x21)          # Load unsigned halfword  1000  tested
//        // # After loading data and for simplicity, let's just add some values together tested
//        mem[18]=32'b00000000010100100000010010110011; // add x9, x4, x5         # Add byte and halfword  1015  tested
//        mem[19]=32'b00000000011001001000010100110011; // add x10, x9, x6        # Add previous result with word  1015 + 7160 = 8175  tested
//        // # Store results for verification tested
//        mem[20]=32'b00000111000000000000101110010011; // addi x23, x0, 112      # Memory address for storing results  tested
//        mem[21]=32'b00000000100110111010000000100011; // sw  x9, 0(x23)          # Store result of byte + halfword  0000_0011_1111_0111 (1111_0111 + 0000_0011) tested
//        mem[22]=32'b00000000101010111010001000100011; // sw  x10, 4(x23)         # Store final result  00001_1111_1110_1111 (1110_1111 + 0001_1111) tested
//        // Reading From Memory (initially assigned data) tested
//        mem[23]=32'b00000000000000000000010100000011; //lb x10,0(x0)  4294967189  1111_1111_1111_1111_1111_1111_1001_0101  tested
//        mem[24]=32'b00000000000000000001010100000011; //lh x10,0(x0)  4294936981  1111_1111_1111_1111_1000_1001_1001_0101  tested
//        mem[25]=32'b00000000000000000010010100000011; //lw x10,0(x0)  1247381909  0100_1010_0101_1001_1000_1001_1001_0101  tested
//        mem[26]=32'b00000000000000000100010100000011; //lbu x10,0(x0) 149         0000_0000_0000_0000_0000_0000_1001_0101  tested
//        mem[27]=32'b00000000000000000101010100000011; //lhu x10,0(x0) 35221       0000_0000_0000_0000_1000_1001_1001_0101  tested


          //JAL and JALR testing 
//          mem[0]=32'b00000001010000000000000010010011; // addi x1, x0, 20     
//          mem[1]=32'b00000001010100000000000100010011; //addi x2, x0, 21   
//          mem[2] = 32'b00000000000000000000000001110011; // ecall   
//          mem[3]=32'b00000000100000000000010101101111; //jal x10,L1
//          mem[4]=32'b00000010100000000000000010010011; //addi x1, x0, 40     
//          mem[5]=32'b00000001100000000000000110010011; //L1:addi x3, x0, 24      
//          mem[6]=32'b00000001011100000000001000010011; //addi x4, x0, 23 
//          mem[7]=32'b00000001100000000000001010010011; //addi x5, x0, 24  
//          mem[8]=32'b00000010110000000000001100010011; //addi x6,x0,44      44
//          mem[9]=32'b00000000100000110000010111100111; // jalr x11, 8(x6)  
//          mem[10]=32'b00000011110000000000000010010011; // addi x1, x0, 60     
//          mem[11]=32'b00000100011000000000000100010011; // addi x2, x0, 70
//          mem[12]=32'b00000001100100000000001000010011; // addi x4, x0, 25 
//          mem[13]=32'b00000001101000000000001010010011; // addi x5, x0, 26
//          mem[14]=32'b00000000111100000000000010010011; // addi x1, x0, 15
//          mem[15]=32'b00000000000010011000001110110111; // lui x7, 152
//          mem[16]=32'b00000000001010010011010000010111; //auipc x8,659


//          //JAL and JALR testing 
//          mem[0]=32'b00000001010000000000000010010011; // addi x1, x0, 20     
//          mem[1]=32'b00000001010100000000000100010011; //addi x2, x0, 21   
//          mem[2] =32'b00000001010100000000000100010011; //addi x2, x0, 21  
//          mem[3]=32'b00000000100000000000010101101111; //jal x10,L1
//          mem[4]=32'b00000010100000000000000010010011; //addi x1, x0, 40     
//          mem[5]=32'b00000001100000000000000110010011; //L1:addi x3, x0, 24      
//          mem[6]=32'b00000001011100000000001000010011; //addi x4, x0, 23 
//          mem[7]=32'b00000001100000000000001010010011; //addi x5, x0, 24  
//          mem[8]=32'b00000010110000000000001100010011; //addi x6,x0,44      44
//          mem[9]=32'b00000000100000110000010111100111; // jalr x11, 8(x6)  
//          mem[10]=32'b00000011110000000000000010010011; // addi x1, x0, 60     
//          mem[11]=32'b00000100011000000000000100010011; // addi x2, x0, 70
//          mem[12]=32'b00000001100100000000001000010011; // addi x4, x0, 25 
//          mem[13]=32'b00000001101000000000001010010011; // addi x5, x0, 26
//          mem[14]=32'b00000000111100000000000010010011; // addi x1, x0, 15
//          mem[15]=32'b00000000000010011000001110110111; // lui x7, 152
//          mem[16]=32'b00000000001010010011010000010111; //auipc x8,659



        
    end
    
    assign data_out = mem[addr]; 
endmodule