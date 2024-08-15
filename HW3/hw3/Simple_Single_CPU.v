module Simple_Single_CPU( clk_i, rst_n );

//I/O port
input         clk_i;
input         rst_n;

//Internal Signles


//modules
wire [31:0]pc_in_i,pc_out_o;
Program_Counter PC(
        .clk_i(clk_i),      
	    .rst_n(rst_n),     
	    .pc_in_i(pc_in_i) ,   
	    .pc_out_o(pc_out_o) 
	    );
	
wire [31:0]src1_i,src2_i,sum_o;
assign pc_in_i=sum_o;
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
        .select_i(RegDst_o),
        .data_o(data_o_rtrd)
        );	
wire [31:0]		RSdata_o,RTdata_o;
Reg_File RF(
        .clk_i(clk_i),      
	    .rst_n(rst_n) ,     
        .RSaddr_i(instr_o[25:21]) ,  
        .RTaddr_i(instr_o[20:16]) ,  
        .RDaddr_i(data_o_rtrd) ,  
        .RDdata_i(data_o_mux3)  , 
        .RegWrite_i(RegWrite_o),//control signal
        .RSdata_o(RSdata_o) ,  
        .RTdata_o(RTdata_o)   
        );

wire 	RegWrite_o,ALUSrc_o,RegDst_o;
wire    [2:0]ALUOp_o;
Decoder Decoder(
        .instr_op_i(instr_o[31:26]), 
	    .RegWrite_o(RegWrite_o), 
	    .ALUOp_o(ALUOp_o),   
	    .ALUSrc_o(ALUSrc_o),   
	    .RegDst_o(RegDst_o)   
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
        .data_i(instr_o),
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
wire zero,overflow	;
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

endmodule



