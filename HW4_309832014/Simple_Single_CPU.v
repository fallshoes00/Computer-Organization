module Simple_Single_CPU( clk_i, rst_n );

//I/O port
input         clk_i;
input         rst_n;

//Internal Signles
wire [32-1:0] instr, PC_i, PC_o, ReadData1, ReadData2, WriteData;
wire [32-1:0] signextend, zerofilled, ALUinput2, ALUResult, ShifterResult;
wire [5-1:0] WriteReg_addr, Shifter_shamt;
wire [4-1:0] ALU_operation;
wire [3-1:0] ALUOP;
wire [2-1:0] FURslt;
wire [2-1:0] RegDst, MemtoReg;
wire RegWrite, ALUSrc, zero, overflow;
wire Jump, Branch, BranchType, MemWrite, MemRead;
wire [32-1:0] PC_add1, PC_add2, PC_no_jump, PC_t, Mux3_result, DM_ReadData;
wire Jr;
assign Jr = ((instr[31:26] == 6'b000000) && (instr[20:0] == 21'd8)) ? 1 : 0;
//modules
/*your code here*/
wire [31:0]jump_mux_o;
wire [31:0]pc_in_i,pc_out_o;
Program_Counter PC(
        .clk_i(clk_i),      
	    .rst_n(rst_n),     
	    .pc_in_i(jump_mux_o) ,   
	    .pc_out_o(pc_out_o) 
	    );
	
wire [31:0]src1_i,src2_i,sum_o;

assign src1_i = pc_out_o;
assign src2_i = 32'd4;
Adder Adder1(
        .src1_i(src1_i),     
	    .src2_i(32'd4),
	    .sum_o(sum_o)    
	    );
	
wire [31:0]pc_addr_i,instr_o;
assign pc_addr_i = pc_out_o;
Instr_Memory IM(
        .pc_addr_i(pc_addr_i),  
	    .instr_o(instr_o)    
	    );
wire [4:0]data_o_rtrd;
Mux2to1 #(.size(5)) Mux_Write_Reg(
        .data0_i(instr_o[20:16]),
        .data1_i(instr_o[15:11]),
        .select_i(RegDst_o[0]),//revise for messages
        .data_o(data_o_rtrd)
        );	
wire [31:0]		RSdata_o,RTdata_o;
wire 	RegWrite_o;
Reg_File RF(
        .clk_i(clk_i),      
	    .rst_n(rst_n) ,     
        .RSaddr_i(instr_o[25:21]) ,  
        .RTaddr_i(instr_o[20:16]) ,  
        .RDaddr_i(data_o_rtrd) ,  
        .RDdata_i(MemtoReg_mux_o)  , 
        .RegWrite_i(RegWrite_o),//control signal
        .RSdata_o(RSdata_o) ,  
        .RTdata_o(RTdata_o)   
        );

wire 	ALUSrc_o;
wire    [2-1:0]RegDst_o,MemtoReg_o;
wire    [2:0]ALUOp_o;
wire    Jump_o,Branch_o,BranchType_o,MemWrite_o,MemRead_o;
Decoder Decoder(
        .instr_op_i(instr_o[31:26]), 
	    .RegWrite_o(RegWrite_o), 
	    .ALUOp_o(ALUOp_o),   
	    .ALUSrc_o(ALUSrc_o),   
	    .RegDst_o(RegDst_o),
	    .Jump_o(Jump_o), 
	    .Branch_o(Branch_o), 
	    .BranchType_o(BranchType_o), 
	    .MemWrite_o(MemWrite_o), 
	    .MemRead_o(MemRead_o), 
	    .MemtoReg_o(MemtoReg_o) //revise for message
		);
		
wire [3:0]ALU_operation_o;
wire [1:0]FURslt_o;
ALU_Ctrl AC(
        .funct_i(instr_o[5:0]),   
        .ALUOp_i(ALUOp_o),   
        .ALU_operation_o(ALU_operation_o),
		.FURslt_o(FURslt_o)
        );
wire [31:0]	data_o_SE;
Sign_Extend SE(
        .data_i(instr_o[15:0]),
        .data_o(data_o_SE)
        );
wire [31:0]	data_o_ZF;
Zero_Filled ZF(
        .data_i(instr_o[15:0]),
        .data_o(data_o_ZF)
        );
wire [31:0]		data_o_ALUsrc2;
Mux2to1 #(.size(32)) ALU_src2Src(
        .data0_i(RTdata_o),
        .data1_i(data_o_SE),
        .select_i(ALUSrc_o),
        .data_o(data_o_ALUsrc2)
        );	
wire [31:0]result_ALU;
ALU ALU(
		.aluSrc1(RSdata_o),
	    .aluSrc2(data_o_ALUsrc2),
	    .ALU_operation_i(ALU_operation_o),
		.result(result_ALU),
		.zero(zero),
		.overflow(overflow)
	    );
wire 	[31:0]result_shifter;	
Shifter shifter( 
		.result(result_shifter), 
		.leftRight(ALU_operation_o[3]),
		.shamt(instr_o[10:6]),
		.sftSrc(data_o_ALUsrc2) 
		);
wire [31:0]data_o_mux3;		
Mux3to1 #(.size(32)) RDdata_Source(
        .data0_i(result_ALU),
        .data1_i(result_shifter),
		.data2_i(data_o_ZF),
        .select_i(FURslt_o),
        .data_o(data_o_mux3)
        );			

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//NEW 8  MODULE HERE
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
wire [31:0] shift_left_instr_o;
Shifter shift_left2_instr( 
		.result(shift_left_instr_o), 
		.leftRight(1'b1),//shift left
		.shamt(5'b00010),
		.sftSrc({6'b00000,instr_o[25:0]}) 
		);
wire [31:0] mux_jump_src1;
assign mux_jump_src1 = {sum_o[31:28],shift_left_instr_o[27:0] };

wire [31:0] shift_left_sign_o;
Shifter shift_left2_sign_extend( 
		.result(shift_left_sign_o), 
		.leftRight(1'b1),//shift left
		.shamt(5'b00010),
		.sftSrc(data_o_SE) 
		);
wire [31:0] branch_adder_o;		
Adder branch_adder(
        .src1_i(sum_o),     
	    .src2_i(shift_left_sign_o),
	    .sum_o(branch_adder_o)    
	    );

Mux2to1 #(.size(32)) jump_mux(
        .data0_i(PCSrc_mux_o),
        .data1_i(mux_jump_src1),
        .select_i(Jump_o),
        .data_o(jump_mux_o)
        );	
wire PCSrc;
wire [31:0]PCSrc_mux_o;
assign PCSrc = Branch_o & beq_bne_mux_o;        
Mux2to1 #(.size(32)) PCSrc_mux(
        .data0_i(sum_o),
        .data1_i(branch_adder_o),
        .select_i(PCSrc),
        .data_o(PCSrc_mux_o)
        );	
wire beq_bne_mux_o;        
wire zero_bar;
assign zero_bar = ~zero;
Mux2to1 #(.size(1)) beq_bne_mux(
        .data0_i(zero),
        .data1_i(zero_bar),
        .select_i(BranchType_o),
        .data_o(beq_bne_mux_o)
        );	
wire [31:0]DM_data_o;
Data_Memory DM(	.clk_i(clk_i), 
                .addr_i(data_o_mux3), 
                .data_i(RTdata_o), 
                .MemRead_i(MemRead_o), 
                .MemWrite_i(MemWrite_o), 
                .data_o(DM_data_o)
            );

wire [31:0] MemtoReg_mux_o;        
Mux2to1 #(.size(32)) MemtoReg_mux(
        .data0_i(data_o_mux3),
        .data1_i(DM_data_o),
        .select_i(MemtoReg_o[0]), //revise for message
        .data_o(MemtoReg_mux_o)
        );	





endmodule



