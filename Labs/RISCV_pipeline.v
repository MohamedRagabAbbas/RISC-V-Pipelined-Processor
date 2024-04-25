module RISCV_pipeline (
    input clk,
    input rst,
    input [1:0] ledSel,
    input [3:0] ssdSel,
    output reg [15:0] leds,
    output reg [12:0] ssd
    );
    
    // Stage 1
    
    wire[31:0] instruction;
    wire[31:0] PCInput;  
    wire[31:0] PC_IF_ID_input;
    wire [31:0] IF_ID_PC, IF_ID_Inst;
       
    NBitMUX2x1 mux_1(EX_MEM_BranchAddOut, PC_IF_ID_input + 4, Anding, PCInput);
    NBitRegister nBitRegister(clk, rst, 1'b1, PCInput, PC_IF_ID_input);
    InstMem instMem(PC_IF_ID_input[7:2], instruction);
    
    
    // Stage 2
    
    NBitRegister #(64) IF_ID (clk, rst, 1'b1,{PC_IF_ID_input, instruction},{IF_ID_PC,IF_ID_Inst} );
    
    
    wire [31:0] ID_EX_PC, ID_EX_RegR1, ID_EX_RegR2, ID_EX_Imm; 
    wire [7:0] ID_EX_Ctrl;
    wire [3:0] ID_EX_Func;
    wire [4:0] ID_EX_Rs1, ID_EX_Rs2, ID_EX_Rd; 
    
    wire [7:0] signals;
    //ControlUnit controlUnit(IF_ID_Inst[4:0], signals[0], signals[1], signals[2], signals[3:4], signals[5], signals[6], signals[7]);
    
    wire [31:0] read_data_1;
    wire [31:0] read_data_2;
    
//    wire Branch;
//    wire MemRead;
//    wire MemtoReg;
//    wire [1:0] ALUOp;
//    wire MemWrite;
//    wire ALUSrc;
//    wire RegWrite;
    
    ControlUnit controlUnit(IF_ID_Inst[6:2], signals[0], signals[1], signals[2], signals[4:3], signals[5], signals[6], signals[7]);
        
    RegFile regfile(IF_ID_Inst[19:15], IF_ID_Inst[24:20], MEM_WB_Rd, write_data, clk, rst, signals[7], read_data_1, read_data_2);
    
    wire [31:0] ImmOut;
    ImmGen immGen(IF_ID_Inst, ImmOut);
    
    NBitRegister #(155) ID_EX (clk,rst,1'b1,
    {signals, IF_ID_PC, read_data_1, read_data_2, ImmOut, 
    {IF_ID_Inst[30], IF_ID_Inst[14:12]}, IF_ID_Inst[19:15], IF_ID_Inst[24:20], IF_ID_Inst[11:7]},
    {ID_EX_Ctrl,ID_EX_PC,ID_EX_RegR1,ID_EX_RegR2, ID_EX_Imm, ID_EX_Func,ID_EX_Rs1,ID_EX_Rs2,ID_EX_Rd} );
     
     
    wire [31:0] EX_MEM_BranchAddOut, EX_MEM_ALU_out, EX_MEM_RegR2; 
    wire [7:0] EX_MEM_Ctrl;
    wire [4:0] EX_MEM_Rd; 
    wire EX_MEM_Zero;
    
    wire [31:0] shifted;
    ShiftLeft shiftLeft(ID_EX_Imm, shifted);
    
    wire[31:0] BranchTarget;
    assign BranchTarget = ID_EX_PC + shifted;
    
    wire [31:0] ALUOutput;
    wire CarryOutALU;
    wire ZeroFlag;
    wire [31:0] ALUSecondSrc;
    
    wire [3:0] ALUSel;
    ALUControlUnit ALUcu(ID_EX_Ctrl[4:3], ID_EX_Func[2:0], ID_EX_Func[3], ALUSel);
    
    NBitMUX2x1 mux_2(ID_EX_Imm, ID_EX_RegR2, ID_EX_Ctrl[6], ALUSecondSrc);
    ALU alu(ID_EX_RegR1, ALUSecondSrc, ALUSel, ALUOutput, CarryOutALU, ZeroFlag);
    
    NBitRegister #(110) EX_MEM (clk,rst,1'b1,
    {ID_EX_Ctrl, BranchTarget, ZeroFlag, ALUOutput, ID_EX_RegR2, ID_EX_Rd},
    {EX_MEM_Ctrl, EX_MEM_BranchAddOut, EX_MEM_Zero, EX_MEM_ALU_out, EX_MEM_RegR2, EX_MEM_Rd} );
    
    wire [31:0] MEM_WB_Mem_out, MEM_WB_ALU_out; 
    wire [7:0] MEM_WB_Ctrl;
    wire [4:0] MEM_WB_Rd;
    wire [31:0] MemOut;
    
    wire Anding;
    assign Anding = EX_MEM_Zero & EX_MEM_Ctrl[0];
    
    DataMem dataMem(clk, EX_MEM_Ctrl[1], EX_MEM_Ctrl[5], EX_MEM_ALU_out[7:2], EX_MEM_RegR2, MemOut);

    NBitRegister #(77) MEM_WB (clk,rst,1'b1,
    {EX_MEM_Ctrl, MemOut, EX_MEM_ALU_out, EX_MEM_Rd},
    {MEM_WB_Ctrl,MEM_WB_Mem_out, MEM_WB_ALU_out, 
    MEM_WB_Rd} );
    
    
    wire [31:0] write_data;    
    NBitMUX2x1 mux_3(MEM_WB_Mem_out, MEM_WB_ALU_out, MEM_WB_Ctrl[2], write_data);

//    always @(*) begin
//        case(ledSel)
//            0: leds = instruction[15:0];
//            1: leds = instruction[31:16];
//            2: leds = {2'b00, ALUOp, ALUSel, ZeroFlag, Branch & ZeroFlag, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite};
//            default: leds = 0;
//        endcase
//    end
    
//    wire [31:0] PCUpdated = PC_IF_ID_input + 4;
    
//    always @(*) begin
//        case(ssdSel)
//            0: ssd = PC_IF_ID_input[12:0];
//            1: ssd = PCUpdated[12:0];
//            2: ssd = EX_MEM_BranchAddOut[12:0];
//            3: ssd = PCInput[12:0];
//            4: ssd = read_data_1[12:0];
//            5: ssd = read_data_2[12:0];
//            6: ssd = write_data[12:0]; 
//            7: ssd = ID_EX_Imm[12:0];
//            8: ssd = shifted[12:0];
//            9: ssd = ALUSecondSrc[12:0];
//            10: ssd = MEM_WB_ALU_out[12:0];
//            11: ssd = MemOut[12:0];
//            default: ssd = 0;
//        endcase
//    end
endmodule
