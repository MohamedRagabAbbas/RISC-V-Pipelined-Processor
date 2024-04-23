`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/23/2024 12:42:28 AM
// Design Name: 
// Module Name: SingleMem
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


module SingleMem(input clk, input MemRead,input [2:0]func3, input MemWrite,input [7:0] addr,input [31:0] data_in, output reg [31:0] data_out);

     reg [7:0] mem [0:510]; //255 + 255 = 510
     localparam [8:0] pointer = 256; // 100000000    //  points to the first row reserved for data
     wire [8:0] data_address;
     assign data_address = addr + pointer;    // 8 bits + 9 bits = 9 bits
     
     // for reading
     always @(*)begin 
         if(clk == 1)  // there is no need to test whtether MemRead == 1 as we will not write instructions and we are always reading instructions to the memory
             data_out = {mem[addr],mem[addr+1],mem[addr+2],mem[addr+3]};  // read instriction
         else begin
            if(MemRead == 1) 
                    begin 
                      case(func3) 
                          3'b000: data_out <= {{24{mem[data_address+3][7]}},mem[data_address+3]};//lb
                          3'b001: data_out <= {{16{mem[data_address+2][7]}},mem[data_address+2],mem[data_address+3]};//lh       
                          3'b010: data_out <= {mem[data_address],mem[data_address+1],mem[data_address+2],mem[data_address+3]};//lw         
                          3'b100: data_out <= {24'd0,mem[data_address+3]};//lbu
                          3'b101: data_out <= {16'd0,mem[data_address+2],mem[data_address+3]};//lhu
                          default: data_out <= 7;
                      endcase
                    end
                  else data_out <= 6 ;
         end
     end
     
     // for data writing
     always @(posedge clk)begin 
         if(MemWrite==1)
             case(func3) 
                   3'b000: mem[data_address+3] = data_in[7:0]; //sb
                   3'b001: 
                       begin 
                       {mem[data_address+2],mem[data_address+3]} = {data_in[15:8],data_in[7:0]};
//                         mem[addr] = data_in[7:0]; //sh
//                         mem[addr+1] = data_in[15:8];
                       end
                   3'b010:
                        begin 
                         {mem[data_address],mem[data_address+1],mem[data_address+2],mem[data_address+3]} = {data_in[31:24],data_in[23:15],data_in[15:8],data_in[7:0]};
//                         mem[addr] = data_in[7:0]; //sw
//                         mem[addr+1] = data_in[15:8];
//                         mem[addr+2] = data_in[23:15];
//                         mem[addr+3] = data_in[31:24];
                        end
             endcase
     end
     
    // test cases
    initial begin
//            mem[256]=32'd149; //  10010101
//            mem[257]=32'd137; //  10001001
//            mem[258]=32'd89;  //  01011001
//            mem[259]=32'd74;  //  01001010
            
               {mem[256],mem[257],mem[258],mem[259]}=32'd17; 
               {mem[260],mem[261],mem[262],mem[263]}=32'd9; 
               {mem[264],mem[265],mem[266],mem[267]}=32'd25;       
                
            
    ////        // # Assign values to registers
//            {mem[0],mem[1],mem[2],mem[3]}    =32'b00000000001000000000000010010011;    // addi x1, x0, 2      2  tested
//            {mem[4],mem[5],mem[6],mem[7]}    =32'b00000000011000000000000100010011;    // addi x2, x0, 6      #  write_data = 6     tested
//            {mem[8],mem[9],mem[10],mem[11]}  =32'b00000001000100000000000110010011;    // addi x3, x0, 17     #  write_data = 17    tested
//            {mem[12],mem[13],mem[14],mem[15]}=32'b00000010010000000000001000010011;    // addi x4, x0, 36     #  write_data = 36    tested
//            {mem[16],mem[17],mem[18],mem[19]}=32'b00100011010000000000001010010011;    // addi x5, x0, 564    #  write_data = 564   tested
//            {mem[20],mem[21],mem[22],mem[23]}=32'b00000000010100101000001010110011;    // add x5, x5, x5      #  write_data = 1128  tested
//            // # Test ADD operation
//            {mem[24],mem[25],mem[26],mem[27]}=32'b00000000010000011000001100110011;    // add x6, x3, x4      #   write_data = 53   tested
//            //# Test SUB operation
//            {mem[28],mem[29],mem[30],mem[31]}=32'b01000000001000100000001110110011;    // sub x7, x4, x2      #  write_data = 30  tested
//            // # Test XOR operation
//            {mem[32],mem[33],mem[34],mem[35]}=32'b00000000001000100100010000110011;    // xor x8, x4, x2      #    write_data = 34 tested
//            // # Test OR operation
//            {mem[36],mem[37],mem[38],mem[39]}=32'b00000000001000100110010010110011;    // or x9, x4, x2       #  write_data = 38 tested
//            // # Test AND operation
//            {mem[40],mem[41],mem[42],mem[43]}=32'b00000000001000100111010100110011;   // and x10, x4, x2      #  write_data = 4 tested
//            // # Test SLL operation 
//            {mem[44],mem[45],mem[46],mem[47]}=32'b00000000000100100001010110110011;// sll x11, x4, x1      # x1 << x2  144 tested
//            // # Test SRL operation
//            {mem[48],mem[49],mem[50],mem[51]}=32'b00000000000100100101011000110011;// srl x12, x4, x1      # x2 >> x1  9 tested
//            // # Test SRA operation
//            {mem[52],mem[53],mem[54],mem[55]}=32'b01000000000100100101011010110011;// sra x13, x4, x1     # x1 >> x2   9 tested
//            // # Test ADDI operation
//            {mem[56],mem[57],mem[58],mem[59]}=32'b00000000011100010000011100010011;// addi x14, x2, 7     # 13         tested
//            // # Test XORI operation
//            {mem[60],mem[61],mem[62],mem[63]}=32'b00000000111100010100011110010011;// xori x15, x2, 15    # 9          tested
//            // # Test ORI operation 
//            {mem[64],mem[65],mem[66],mem[67]}=32'b00000001010000001110100000010011;// ori x16, x1, 20     # 22         tested
//            // # Test SLLI operation
//            {mem[68],mem[69],mem[70],mem[71]}=32'b00000000010100101001100010010011;// slli x17, x5, 5     #  x5 << 5   36096   tested
//            // # Test SRLI operation 
//            {mem[72],mem[73],mem[74],mem[75]}=32'b00000000010100100101100100010011;// srli x18, x4, 5     # x4 >> 5     1   tested
//            // # Test SRAI operation
//            {mem[76],mem[77],mem[78],mem[79]}=32'b01000000000100010101100110010011;// srai x19, x2, 1     # x2 >> 1  needs to be tested again
    
//             // # Assign values to registers
//            {mem[80],mem[81],mem[82],mem[83]}=32'b00000010010000000000101000010011; // addi x20,x0,36   # write_data = 36
//            // # Test BEQ taken  tested
//            {mem[84],mem[85],mem[86],mem[87]}=32'b00000001010000100000010001100011; // beq x4, x20, eq_label # Branch if x20 == x4
//            {mem[88],mem[89],mem[90],mem[91]}=32'b00000000000100000000101010010011; // addi x21, x0, 1     # x21 = 1
//            {mem[92],mem[93],mem[94],mem[95]}=32'b00000000001000000000101010010011; // eq_label: addi x21, x0, 2     # x21 = 2
//            // # Test BEQ not taken tested
//            {mem[96],mem[97],mem[98],mem[99]}=32'b00000001010000101000010001100011; // beq x5, x20, eq_label2 # Branch if x20 == x5
//            {mem[100],mem[101],mem[102],mem[103]}=32'b00000000000100000000101010010011; // addi x21, x0, 1     # x21 = 1
//            {mem[104],mem[105],mem[106],mem[107]}=32'b00000000001000000000101010010011; // eq_label2: addi x21, x0, 2     # x21 = 2
//            // # Test BNE taken  tested
//            {mem[108],mem[109],mem[110],mem[111]}=32'b00000000001000001001010001100011; // bne x1, x2, ne_label # Branch if x1 != x2  
//            {mem[112],mem[113],mem[114],mem[115]}=32'b00000000000100000000101100010011; // addi x22, x0, 1     # x22 = 1
//            {mem[116],mem[117],mem[118],mem[119]}=32'b00000000001000000000101100010011; // ne_label: addi x22, x0, 2     # x22 = 2
//            // # Test BNE not taken tested
//            {mem[120],mem[121],mem[122],mem[123]}=32'b00000001010000100001010001100011; // bne x4, x20, ne_label2 # Branch if x4 != x20 
//            {mem[124],mem[125],mem[126],mem[127]}=32'b00000000000100000000101100010011; // addi x22, x0, 1     # x22 = 1
//            {mem[128],mem[129],mem[130],mem[131]}=32'b00000000001000000000101100010011; // ne_label2: addi x22, x0, 2     # x22 = 2
//            // # Test BLT taken tested
//            {mem[132],mem[133],mem[134],mem[135]}=32'b00000000001000001100010001100011; // blt x1, x2, lt_label # Branch if x1 < x2 2<6
//            {mem[136],mem[137],mem[138],mem[139]}=32'b00000000000100000000101110010011; // addi x23, x0, 1     # x23 = 1
//            {mem[140],mem[141],mem[142],mem[143]}=32'b00000000001000000000101110010011; // lt_label: addi x23, x0, 2    # x23 = 2
//            // # Test BLT not taken tested
//            {mem[144],mem[145],mem[146],mem[147]}=32'b00000000000100010100010001100011; // blt x2, x1, lt_label2 # Branch if x2 < x1
//            {mem[148],mem[149],mem[150],mem[151]}=32'b00000000000100000000101110010011; // addi x23, x0, 1     # x23 = 1
//            {mem[152],mem[153],mem[154],mem[155]}=32'b00000000001000000000101110010011; // lt_label2: addi x23, x0, 2    # x23 = 2
//            // # Test BGE taken tested
//            {mem[156],mem[157],mem[158],mem[159]}=32'b00000000001100100101010001100011; // bge x4, x3, ge_label # Branch if x4 >= x3
//            {mem[160],mem[161],mem[162],mem[163]}=32'b00000000000100000000110000010011; // addi x24, x0, 1     # x24 = 1
//            {mem[164],mem[165],mem[166],mem[167]}=32'b00000000001000000000110000010011; // ge_label: addi x24, x0, 2     # x20 = 2
//            // # Test BGE not taken tested
//            {mem[168],mem[169],mem[170],mem[171]}=32'b00000000010000011101010001100011; // bge x3, x4, ge_label2 # Branch if x3 >= x4
//            {mem[172],mem[173],mem[174],mem[175]}=32'b00000000000100000000110000010011; // addi x24, x0, 1     # x24 = 1
//            {mem[176],mem[177],mem[178],mem[179]}=32'b00000000001000000000110000010011; // ge_label2: addi x24, x0, 2     # x20 = 2
//            // # Test BLTU taken tested
//            {mem[180],mem[181],mem[182],mem[183]}=32'b00000000001000001110010001100011; // bltu x1, x2, ltu_label # Branch if x1 < x2 (unsigned)
//            {mem[184],mem[185],mem[186],mem[187]}=32'b00000000000100000000110010010011; // addi x25, x0, 1     # x25 = 1
//            {mem[188],mem[189],mem[190],mem[191]}=32'b00000000001000000000110010010011; // ltu_label:addi x25, x0, 2     # x25 = 2
//            // # Test BLTU not taken tested
//            {mem[192],mem[193],mem[194],mem[195]}=32'b00000000000100010110010001100011; // bltu x2, x1, ltu_label2 # Branch if x2 < x1 (unsigned)
//            {mem[196],mem[197],mem[198],mem[199]}=32'b00000000000100000000110010010011; // addi x25, x0, 1     # x25 = 1
//            {mem[200],mem[201],mem[202],mem[203]}=32'b00000000001000000000110010010011; // ltu_label2:addi x25, x0, 2     # x25 = 2
//            // # Test BGEU taken tested
//            {mem[204],mem[205],mem[206],mem[207]}=32'b00000000001100100111010001100011; // bgeu x4, x3, bgeu_label # Branch if x4 >= x3 (unsigned)
//            {mem[208],mem[209],mem[210],mem[211]}=32'b00000000000100000000110100010011; // addi x26, x0, 1     # x26 = 1
//            {mem[212],mem[213],mem[214],mem[215]}=32'b00000000001000000000110100010011; // bgeu_label: addi x26, x0, 2     # x26 = 2
//            // # Test BGEU not taken tested
//            {mem[216],mem[217],mem[218],mem[219]}=32'b00000000010000011111010001100011; //bgeu x3, x4, bgeu_label2 # Branch if x3 >= x4 (unsigned)
//            {mem[220],mem[221],mem[222],mem[223]}=32'b00000000000100000000110110010011; //addi x27, x0, 1     # x27 = 1
//            {mem[224],mem[225],mem[226],mem[227]}=32'b00000000001000000000110110010011; //bgeu_label2: addi x27, x0, 2     # x27 = 2
//            // #Set less than instructions
//            // # Test SLT operation
//            // # The condition is true  tested
//            {mem[228],mem[229],mem[230],mem[231]}=32'b00000000001000001010111000110011; // slt x28, x1, x2      # Set x28 = 1 if x1 < x2, else x26 = 0
//            // # The condition is false tested
//            {mem[232],mem[233],mem[234],mem[235]}=32'b00000000000100010010111000110011; //  slt x28, x2, x1      # Set x28 = 1 if x2 < x1, else x26 = 0
//            // # Test SLTU operation
//            // # The condition is true  tested
//            {mem[236],mem[237],mem[238],mem[239]}=32'b00000000001000001011111010110011; // sltu x29, x1, x2     # Set x29 = 1 if x1 < x2 (unsigned), else x29 = 0
//            // # The condition is false tested
//            {mem[240],mem[241],mem[242],mem[243]}=32'b00000000000100010011111010110011; // sltu x29, x2, x1     # Set x29 = 1 if x2 < x1 (unsigned), else x29 = 0
//            // # Test SLTI operation
//            // # The condition is true  tested
//            {mem[244],mem[245],mem[246],mem[247]}=32'b00000000101000010010111100010011; // slti x30, x2, 10     # Set x30 = 1 if x2 < 10, else x30 = 0
//            // # The condition is false tested
//            {mem[248],mem[249],mem[250],mem[251]}=32'b00000000010100010010111100010011; // slti x30, x2, 5     # Set x30 = 1 if x2 < 5, else x30 = 0
//            // Test SLTIU operation
//            // # The condition is true tested
//            {mem[252],mem[253],mem[254],mem[255]}=32'b00000000000000000000000001110011; // ecall  
//            //{mem[252],mem[253],mem[254],mem[255]}=32'b00000000101000001011111110010011; // sltiu x31, x1, 10    # Set x31 = 1 if x1 < 10 (unsigned), else x32 = 0
//            // # The condition is false tested
//            //{mem[256],mem[257],mem[258],mem[259]}=32'b00000000010100001011111110010011; // sltiu x31, x1, 5    # Set x31 = 1 if x1 < 5 (unsigned), else x32 = 0



        {mem[0],mem[1],mem[2],mem[3]}    =32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0
        {mem[4],mem[5],mem[6],mem[7]}    =32'b000000000000_00000_010_00001_0000011 ; //lw x1, 0(x0)  17
        {mem[8],mem[9],mem[10],mem[11]}  =32'b000000000100_00000_010_00010_0000011 ; //lw x2, 4(x0)  9 
        {mem[12],mem[13],mem[14],mem[15]}=32'b000000001000_00000_010_00011_0000011 ; //lw x3, 8(x0)  25
        {mem[16],mem[17],mem[18],mem[19]}=32'b0000000_00010_00001_110_00100_0110011 ; //or x4, x1, x2  25
        {mem[20],mem[21],mem[22],mem[23]}=32'b0000_0000_0011_0010_0000_0100_0110_0011; //beq x4, x3, 4  0 
        {mem[24],mem[25],mem[26],mem[27]}=32'b0000000_00010_00001_000_00011_0110011 ; //add x3, x1, x2 
        {mem[28],mem[29],mem[30],mem[31]}=32'b0000000_00010_00011_000_00101_0110011 ; //add x5, x3, x2    34  
        {mem[32],mem[33],mem[34],mem[35]}=32'b0000000_00101_00000_010_01100_0100011; //sw x5, 12(x0) 0
        {mem[36],mem[37],mem[38],mem[39]}=32'b000000001100_00000_010_00110_0000011 ; //lw x6, 12(x0)  34
        {mem[40],mem[41],mem[42],mem[43]}=32'b0000000_00001_00110_111_00111_0110011 ; //and x7, x6, x1 0
        {mem[44],mem[45],mem[46],mem[47]}=32'b0100000_00010_00001_000_01000_0110011 ; //sub x8, x1, x2  8
        {mem[48],mem[49],mem[50],mem[51]}=32'b0000000_00010_00001_000_00000_0110011 ; //add x0, x1, x2  26
        {mem[52],mem[53],mem[54],mem[55]}=32'b0000000_00001_00000_000_01001_0110011 ; //add x9, x0, x1 17
        {mem[56],mem[57],mem[58],mem[59]}=32'b00000000000000000000000001110011; // ecall
     end
endmodule
