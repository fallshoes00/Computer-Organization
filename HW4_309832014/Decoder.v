module Decoder( instr_op_i, RegWrite_o,	ALUOp_o, ALUSrc_o, RegDst_o, Jump_o, Branch_o, BranchType_o, MemWrite_o, MemRead_o, MemtoReg_o);
     
//I/O ports
input	[6-1:0] instr_op_i;

output			RegWrite_o;
output	[3-1:0] ALUOp_o;
output			ALUSrc_o;
output	[2-1:0]	RegDst_o, MemtoReg_o;
output			Jump_o, Branch_o, BranchType_o, MemWrite_o, MemRead_o;
 
//Internal Signals
wire	[3-1:0] ALUOp_o;
wire			ALUSrc_o;
wire			RegWrite_o;
wire	[2-1:0]	RegDst_o, MemtoReg_o;
wire			Jump_o, Branch_o, BranchType_o, MemWrite_o, MemRead_o;

//Main function
/*your code here*/
assign RegWrite_o = ((instr_op_i==6'b000000) || (instr_op_i==6'b001000) || (instr_op_i==6'b100001) )?1'b1:1'b0;// R-type or lw(100001)
assign ALUOp_o =    (instr_op_i==6'b000000)?3'b010://R-type
                    (instr_op_i==6'b001000)?3'b011://addi
                    //(instr_op_i==6'b000000)?3'b101://lui   OP field  NOT YET COMPLETE
                    ( (instr_op_i==6'b100001) || (instr_op_i==6'b100011) )?3'b000://lw sw
                    (instr_op_i==6'b111011)?3'b001:3'b110; //beq bne
                    //jump is don't care.
                                        
assign ALUSrc_o = (( (instr_op_i==6'b000000) || (instr_op_i==6'b111011) || (instr_op_i==6'b100101))? 1'b0:1'b1); // beq bne, will pick rt , not the extended value. 
assign RegDst_o = ((instr_op_i==6'b000000))?2'b01:2'b00;// same as Lab3, but from 1 bit to 2 bits.

assign MemtoReg_o = (instr_op_i==6'b100001)?2'b01:2'b00; //lw -> other don't care  /    revise for message 
assign Jump_o = (instr_op_i==6'b100010)?1'b1:1'b0; //jump=1 -> pc+4,  jump=0 -> jump   
assign Branch_o = ( (instr_op_i==6'b111011) || (instr_op_i==6'b100101) )?1'b1:1'b0; //beq or bne
assign BranchType_o = ( (instr_op_i==6'b111011) /*|| (instr_op_i==6'b100101)*/ )?1'b0:1'b1 ; //beq ->0,   bne ->1
assign MemWrite_o = (instr_op_i==6'b100011)?1'b1:1'b0; //only sw to be 1 .
assign MemRead_o = (instr_op_i==6'b100001)?1'b1:1'b0; // lw -> 1 

//WE JUST NEED TO IMPLEMENT R-TYPE IN HOMEWORK3!!!    SIGNALS WE NEED TO CONTROL ARE FOLLOWING BELOW
//assign RegWrite_o = ((instr_op_i==6'b000000) || (instr_op_i==6'b001000))?1'b1:1'b0; 
//assign ALUSrc_o = (((instr_op_i==6'b000000))? 1'b0:1'b1);// if   do  r-type   then  ALU add from  rt_rd  and   rs   ,    if   op=addi   select from  i-type
//assign RegDst_o = ((instr_op_i==6'b000000))?1'b1:1'b0;//if  R-type   save result to rd ,        if i-type save to rs        

//if R-type be 001,     if i-type 000.      000 can directly determine ALU operation,   
//001 need to check function field so can determine ALU op
//referenced by CH4 page 38
//assign ALUOp_o  = ((instr_op_i==6'b000000))?3'b001:3'b000 ; 




endmodule
   