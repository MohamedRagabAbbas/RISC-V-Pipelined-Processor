/*******************************************************************
*
* Module: RISCV_pipeline.v
* Project: Milestone 3
* Author: Mohamed Abbas mohamed_Ragab02@aucegypt 
          Omar Bahgat omar_bahgat@aucegypt.edu
* Description: PipeLine
*
* Change history: 
**********************************************************************/

module HazardDetectionUnit(
        wire [4:0] IF_ID_Rs1,
        wire [4:0] IF_ID_Rs2,
        wire [4:0] ID_EX_Rd,
        wire ID_EX_MemRead,
        output reg stall
    );
    
    always @(*) begin 
        if((IF_ID_Rs1 == ID_EX_Rd || IF_ID_Rs2 == ID_EX_Rd) && ID_EX_MemRead && ID_EX_Rd != 0) 
            stall = 0;
        else 
            stall = 1;
    end
endmodule

module Shift(
    input [31:0] A, 
    input [4:0] Shamt, 
    input [1:0] Type, 
    output reg [31:0] ShiftOutput
    );
    always @(*) begin
        case(Type)
         2'b00: ShiftOutput = A >> Shamt;   //SRL
         2'b01: ShiftOutput = A << Shamt;   //SLL
         2'b10: ShiftOutput = A >>> Shamt;  //SRA
        endcase
    end
endmodule




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
    wire[31:0] inst;
    wire[31:0] PCInput;  
    wire[31:0] PC_IF_ID_input;
    wire [31:0] IF_ID_PC, IF_ID_Inst;
    wire Anding;
    wire pc_rst,pc_halt;
    wire stall;
    wire [31:0] EX_MEM_BranchAddOut;
    wire [31:0] EX_MEM_BranchAddOut1;
    wire pc_halt2;
    NBitRegister #(1)h(clk,rst,pc_halt,pc_halt,pc_halt2);
    
    wire halting;
    assign halting = ~(stall == 0 | pc_halt2 == 1);
    
    NBitMUX2x1 mux_1(EX_MEM_BranchAddOut, PC_IF_ID_input + 4, Anding, PCInput);
    NBitRegister nBitRegister(clk,rst |  pc_rst, halting, PCInput, PC_IF_ID_input);
    
    //InstMem instMem(PC_IF_ID_input[7:2], inst);
    //InstMem instMem(PC_IF_ID_input[7:0], inst);
    wire [7:0]addr;
    wire [31:0]memoryOutput;
    wire [31:0]data_in;
    NBitMUX2x1 #(8)addrInstOrData(PC_IF_ID_input[7:0],EX_MEM_ALU_out[7:0],clk,addr);
    SingleMem singleMem(clk,EX_MEM_Ctrl[4],EX_MEM_Func[2:0],EX_MEM_Ctrl[5],addr,data_in,memoryOutput);
    // flush fetching new instruction
    wire [31:0] NOP;
    assign NOP = 32'b0000000_00000_00000_000_00000_0110011;
    //NBitMUX2x1 flushOrContinue(NOP, inst, 0 , instruction);    
    NBitMUX2x1 flushOrContinue(NOP,memoryOutput, 0 , instruction);    
//    assign NOP = 32'b0000000_00000_00000_000_00000_0110011;
//    NBitMUX2x1 flushOrContinue(NOP, inst, Anding | ~halting , instruction);
    
    // Stage 2
    
    NBitRegister #(64) IF_ID (~clk, rst, stall,{PC_IF_ID_input, instruction},{IF_ID_PC,IF_ID_Inst} );
    //NBitRegister #(64) IF_ID (clk, rst, stall,{PC_IF_ID_input, instruction},{IF_ID_PC,IF_ID_Inst} );
    
    
    wire [31:0] ID_EX_PC, ID_EX_RegR1, ID_EX_RegR2, ID_EX_Imm; 
    wire [14:0] ID_EX_Ctrl;
    wire [3:0] ID_EX_Func;
    wire [4:0] ID_EX_Rs1, ID_EX_Rs2, ID_EX_Rd; 
    
    wire [14:0] signals;
    //ControlUnit controlUnit(IF_ID_Inst[4:0], signals[0], signals[1], signals[2], signals[3:4], signals[5], signals[6], signals[7]);
    
    wire [31:0] read_data_1;
    wire [31:0] read_data_2;
    
     // Control Unit
    
    //ControlUnit controlUnit(inst, ALUOp, MemRead, MemWrite, RegWrite, ALUSrc, MemToReg,RegData , Branch, pc_rst, pc_halt);
    
    ControlUnit controlUnit(IF_ID_Inst, signals[3:0], signals[4], signals[5], signals[6], signals[7], signals[8], 
    signals[10:9], signals[12:11],  signals[13], signals[14]);
    
    
    
    assign pc_rst = signals[13];
    assign pc_halt = signals[14];
    
    
    HazardDetectionUnit hazardDetectionUnit(IF_ID_Inst[19:15], IF_ID_Inst[24:20], ID_EX_Rd, ID_EX_Ctrl[4], stall);
        
    wire [14:0] IF_ID_Signals;
    NBitMUX2x1 #(15) nBitMUX2x1(15'b0, signals, ~stall | Anding | pc_halt2 , IF_ID_Signals);
    
    wire [4:0] MEM_WB_Rd;
    wire [31:0] write_data; 
    RegFile regfile(IF_ID_Inst[19:15], IF_ID_Inst[24:20], MEM_WB_Rd, write_data, clk, rst, MEM_WB_Ctrl[6], read_data_1, read_data_2);
    
    wire [31:0] ImmOut;
    ImmGen immGen(IF_ID_Inst, ImmOut);
    
    NBitRegister #(162) ID_EX (clk,rst,1'b1,
    {IF_ID_Signals, IF_ID_PC, read_data_1, read_data_2, ImmOut, 
    {IF_ID_Inst[30], IF_ID_Inst[14:12]}, IF_ID_Inst[19:15], IF_ID_Inst[24:20], IF_ID_Inst[11:7]},
    {ID_EX_Ctrl,ID_EX_PC, ID_EX_RegR1,ID_EX_RegR2, ID_EX_Imm, ID_EX_Func,ID_EX_Rs1,ID_EX_Rs2,ID_EX_Rd} );
     
     
    wire [31:0]  EX_MEM_ALU_out, EX_MEM_RegR2; 
    wire [14:0] EX_MEM_Ctrl;
    wire [4:0] EX_MEM_Rd; 
    wire EX_MEM_Branch;
    
//    wire [31:0] shifted;
//    ShiftLeft shiftLeft(ID_EX_Imm, shifted);
    
    wire[31:0] BranchTarget;
    wire[31:0] ID_EX_PC4;
    //PC_IF_ID_input + 4
    assign BranchTarget = ID_EX_PC + ID_EX_Imm;
    assign ID_EX_PC4 = ID_EX_PC + 4;
    
    wire [31:0] ALUOutput;
    wire CarryOutALU;
    wire ZeroFlag;
    wire [31:0] ALUSecondSrc;
    
    wire [3:0] ALUSel;
    ALUControlUnit ALUcu(ID_EX_Ctrl[3:0], ID_EX_Func[3], ID_EX_Func[2:0], ALUSel);
    
    wire [31:0] forwardedB;
    NBitMUX2x1 mux_2(ID_EX_Imm, forwardedB, ID_EX_Ctrl[7], ALUSecondSrc);
    
    wire [1:0] forwardA, forwardB;
    ForwardingUnit forwardingUnit(ID_EX_Rs1, ID_EX_Rs2, EX_MEM_Rd, MEM_WB_Rd, EX_MEM_Ctrl[6], MEM_WB_Ctrl[6], forwardA, forwardB);
    
    wire [31:0] forwardedA;
    MUX4x1 mux4x1_1(ID_EX_RegR1, write_data, EX_MEM_ALU_out, forwardA, forwardedA);
    
    
    MUX4x1 mux4x1_2(ID_EX_RegR2, write_data, EX_MEM_ALU_out, forwardB, forwardedB); // ALUSecondSrc
    
    wire cf;
    wire zf;
    wire vf;
    wire sf;
    wire [4:0] shamt;
        
    ALU alu(forwardedA, ALUSecondSrc, ALUSel, shamt, ALUOutput, cf, zf, vf, sf);
    
    assign shamt = ALUSecondSrc[4:0];
    
    wire [14:0] newID_EX_Ctrl;
    NBitMUX2x1 makeControlSignalZeros(15'b0, ID_EX_Ctrl, Anding, newID_EX_Ctrl);
    
    

//    wire conditionResult;
//    Conditional_Branches condBranches(ID_EX_Func[2:0], zf, cf, vf, sf, conditionResult);
   // NBitMUX2x1 mux4(PCOutput + ImmOut, PCOutput + 4, ID_EX_Ctrl[11] & conditionResult, PCInput);
    wire EX_MEM_zf, EX_MEM_cf, EX_MEM_vf, EX_MEM_sf;
    wire [31:0] EX_MEM_PC4;
    wire [3:0] EX_MEM_Func;
    NBitRegister #(156) EX_MEM (~clk,rst,1'b1,
    {newID_EX_Ctrl, BranchTarget,ID_EX_PC4, zf,cf,vf,sf, ALUOutput, forwardedB, ID_EX_Rd,ID_EX_Func},
    {EX_MEM_Ctrl, EX_MEM_BranchAddOut1,EX_MEM_PC4,EX_MEM_zf,EX_MEM_cf,EX_MEM_vf,EX_MEM_sf , EX_MEM_ALU_out, data_in, EX_MEM_Rd,EX_MEM_Func} );
//    NBitRegister #(156) EX_MEM (clk,rst,1'b1,
//    {newID_EX_Ctrl, BranchTarget,ID_EX_PC4, zf,cf,vf,sf, ALUOutput, forwardedB, ID_EX_Rd,ID_EX_Func},
//    {EX_MEM_Ctrl, EX_MEM_BranchAddOut1,EX_MEM_PC4,EX_MEM_zf,EX_MEM_cf,EX_MEM_vf,EX_MEM_sf , EX_MEM_ALU_out, w, EX_MEM_Rd,EX_MEM_Func} );
//    NBitRegister #(121) EX_MEM (clk,rst,1'b1,
//        {newID_EX_Ctrl, BranchTarget, conditionResult, ALUOutput, forwardedB, ID_EX_Rd,ID_EX_Func},
//        {EX_MEM_Ctrl, EX_MEM_BranchAddOut, EX_MEM_Branch, EX_MEM_ALU_out, w, EX_MEM_Rd,EX_MEM_Func} );
    
    wire [31:0] MEM_WB_Mem_out, MEM_WB_ALU_out; 
    wire [14:0] MEM_WB_Ctrl;
    wire [31:0] MemOut;
    
    wire [1:0]conditionResult;
    Conditional_Branches condBranches(EX_MEM_Ctrl[12:11],EX_MEM_Func[2:0], EX_MEM_zf, EX_MEM_cf, EX_MEM_vf, EX_MEM_sf, conditionResult);
    
    wire isJALR;
    assign isJALR = (conditionResult==2'b10)? 1:0;
    NBitMUX2x1 JALR(EX_MEM_ALU_out,EX_MEM_BranchAddOut1,isJALR,EX_MEM_BranchAddOut);
    
    assign Anding = (conditionResult != 2'b00)? 1:0;
    
    //DataMem dataMem(clk, EX_MEM_Ctrl[4], EX_MEM_Ctrl[5],EX_MEM_Func[2:0], EX_MEM_ALU_out[7:0], data_in, MemOut);
    //DataMem dataMem(clk, EX_MEM_Ctrl[4], EX_MEM_Ctrl[5], EX_MEM_ALU_out[7:2], w, MemOut);
    
    wire[31:0] MEM_WB_BranchTarget;
    wire[31:0] MEM_WB_PC4;
    
    NBitRegister #(148) MEM_WB (clk,rst,1'b1,
    {EX_MEM_Ctrl, memoryOutput, EX_MEM_ALU_out, EX_MEM_Rd,EX_MEM_BranchAddOut,EX_MEM_PC4},
    {MEM_WB_Ctrl,MEM_WB_Mem_out, MEM_WB_ALU_out, MEM_WB_Rd,MEM_WB_BranchTarget,MEM_WB_PC4} );    
//    NBitRegister #(148) MEM_WB (clk,rst,1'b1,
//    {EX_MEM_Ctrl, MemOut, EX_MEM_ALU_out, EX_MEM_Rd,EX_MEM_BranchAddOut,EX_MEM_PC4},
//    {MEM_WB_Ctrl,MEM_WB_Mem_out, MEM_WB_ALU_out, MEM_WB_Rd,MEM_WB_BranchTarget,MEM_WB_PC4} );
    
    wire [31:0]write_data1;
    NBitMUX2x1 mux_3(MEM_WB_Mem_out, MEM_WB_ALU_out, MEM_WB_Ctrl[8], write_data1);
    
//    wire aaa;
//    assign aaa = MEM_WB_Ctrl[10:9];
     MUX4x1 mux_4by1(MEM_WB_PC4,MEM_WB_BranchTarget,write_data1,MEM_WB_Ctrl[10:9],write_data);

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