module Decoder( instr_op_i, RegWrite_o,	ALUOp_o, ALUSrc_o, RegDst_o );
     
//I/O ports
input	[6-1:0] instr_op_i;

output			RegWrite_o;
output	[3-1:0] ALUOp_o;
output			ALUSrc_o;
output			RegDst_o;
 
//Internal Signals
wire	[3-1:0] ALUOp_o;
wire			ALUSrc_o;
wire			RegWrite_o;
wire			RegDst_o;

//Main function
/*your code here*/
//CH4         PAGE.49   
/*assign RegWrite_o = ((instr_op_i==6'b000000) || (instr_op_i==6'b100011))?1'b1:1'b0; // if R-type(00 0000)    or      load(10 0011)      set to 1,           else = 0;
assign ALUOp_o  = ((instr_op_i==6'b000000))?3'b001:3'b000 ; // if R tyre(00 0000)  set   to 1     ,            if ADDI    or else       set to 0            //NON ABSOLUTELY CORRECT //NON ABSOLUTELY CORRECT //NON ABSOLUTELY CORRECT
assign ALUSrc_o = (((instr_op_i==6'b100011) || (instr_op_i==6'b101011))? 1'b1:1'b0);// if   lw  (10 0011)    or sw(101011)         set to 1,           else = 0;
assign RegDst_o = ((instr_op_i==6'b000000))?1'b1:1'b0; // if R-type(00 0000)     set to 1,           else = 0;*/
 
//WE JUST NEED TO IMPLEMENT R-TYPE IN HOMEWORK3!!!    SIGNALS WE NEED TO CONTROL ARE FOLLOWING BELOW
assign RegWrite_o = ((instr_op_i==6'b000000) || (instr_op_i==6'b001000))?1'b1:1'b0; 
assign ALUSrc_o = (((instr_op_i==6'b000000))? 1'b0:1'b1);// if   do  r-type   then  ALU add from  rt_rd  and   rs   ,    if   op=addi   select from  i-type
assign RegDst_o = ((instr_op_i==6'b000000))?1'b1:1'b0;//if  R-type   save result to rd ,        if i-type save to rs        

//if R-type be 001,     if i-type 000.      000 can directly determine ALU operation,   
//001 need to check function field so can determine ALU op
//referenced by CH4 page 38
assign ALUOp_o  = ((instr_op_i==6'b000000))?3'b001:3'b000 ; 
       
endmodule
   