module ALU_Ctrl( funct_i, ALUOp_i, ALU_operation_o, FURslt_o );

//I/O ports 
input      [6-1:0] funct_i;
input      [3-1:0] ALUOp_i;

output     [4-1:0] ALU_operation_o;  
output     [2-1:0] FURslt_o;
     
//Internal Signals
wire		[4-1:0] ALU_operation_o;
wire		[2-1:0] FURslt_o;

//Main function
/*your code here*/
assign ALU_operation_o = //001 implies R-type  in Decoder.v  
                        ( (ALUOp_i==3'b001) && (funct_i==6'b010010) )? 4'b0010 ://010010   ->   ADD     ->0010
                        ( (ALUOp_i==3'b001) && (funct_i==6'b010000) )? 4'b0110 ://010000   ->   SUB     ->0110
                        ( (ALUOp_i==3'b001) && (funct_i==6'b010100) )? 4'b0001 ://010100   ->   AND     ->0001
                        ( (ALUOp_i==3'b001) && (funct_i==6'b010110) )? 4'b0000 ://010110   ->   OR      ->0000
                        ( (ALUOp_i==3'b001) && (funct_i==6'b010101) )? 4'b1101 ://010101   ->   NOR     ->1101
                        ( (ALUOp_i==3'b001) && (funct_i==6'b100000) )? 4'b0111 ://100000   ->   SLT     ->0111
                        //¡õpick MSB to be leftright directly.
                        ( (ALUOp_i==3'b001) && (funct_i==6'b000000) )? 4'b1000 ://000000   ->   SLL  ->0011     if ALU_operation_o=4'0011,  leftRight=1
                        ( (ALUOp_i==3'b001) && (funct_i==6'b000010) )? 4'b0000 ://000010   ->   SRL  ->0100     if ALU_operation_o=4'0100,  leftRight=0
                        ( (ALUOp_i==3'b000))?    4'b0010 :   4'b1111;    //I-type ADDI   ->  0010           ,  else   1111 with no operation  

assign FURslt_o = ( (ALUOp_i==3'b001) && (funct_i==6'b000000)  ) || ((ALUOp_i==3'b001) && (funct_i==6'b000010))?2'b01:2'b00;
                       
endmodule     
