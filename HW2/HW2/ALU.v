module ALU( result, zero, overflow, aluSrc1, aluSrc2, invertA, invertB, operation );
   
  output wire[31:0] result;
  output wire zero;
  output wire overflow;

  input wire[31:0] aluSrc1;
  input wire[31:0] aluSrc2;
  input wire invertA;
  input wire invertB;
  input wire[1:0] operation;
  
  /*your code here*/
  wire[31:0]carryout;
  //ALU_1bit ALU0( .a(aluSrc1[0]), .b(aluSrc2[0]), .carryIn(1'b0), .carryOut(carryout[0]), .result(result[0]), .invertA(invertA), .invertB(invertB), .operation(operation), .less(result[31]));
  ALU_1bit ALU0( .a(aluSrc1[0]), .b(aluSrc2[0]), .carryIn(invertB), .carryOut(carryout[0]), .result(result[0]), .invertA(invertA), .invertB(invertB), .operation(operation), .less(result[31]));
  //ALU_1bit ALU0( .a(aluSrc1[0]), .b(aluSrc2[0]), .carryIn(invertB), .carryOut(carryout[0]), .result(result[0]), .invertA(invertA), .invertB(invertB), .operation(operation), .less(result[31]));
  
  ALU_1bit ALU1( .a(aluSrc1[1]), .b(aluSrc2[1]), .carryIn(carryout[0]), .carryOut(carryout[1]), .result(result[1]), .invertA(invertA), .invertB(invertB), .operation(operation), .less(1'b0));
  ALU_1bit ALU2( .a(aluSrc1[2]), .b(aluSrc2[2]), .carryIn(carryout[1]), .carryOut(carryout[2]), .result(result[2]), .invertA(invertA), .invertB(invertB), .operation(operation), .less(1'b0));
  ALU_1bit ALU3( .a(aluSrc1[3]), .b(aluSrc2[3]), .carryIn(carryout[2]), .carryOut(carryout[3]), .result(result[3]), .invertA(invertA), .invertB(invertB), .operation(operation), .less(1'b0));
  ALU_1bit ALU4( .a(aluSrc1[4]), .b(aluSrc2[4]), .carryIn(carryout[3]), .carryOut(carryout[4]), .result(result[4]), .invertA(invertA), .invertB(invertB), .operation(operation), .less(1'b0));
  ALU_1bit ALU5( .a(aluSrc1[5]), .b(aluSrc2[5]), .carryIn(carryout[4]), .carryOut(carryout[5]), .result(result[5]), .invertA(invertA), .invertB(invertB), .operation(operation), .less(1'b0));
  ALU_1bit ALU6( .a(aluSrc1[6]), .b(aluSrc2[6]), .carryIn(carryout[5]), .carryOut(carryout[6]), .result(result[6]), .invertA(invertA), .invertB(invertB), .operation(operation), .less(1'b0));
  ALU_1bit ALU7( .a(aluSrc1[7]), .b(aluSrc2[7]), .carryIn(carryout[6]), .carryOut(carryout[7]), .result(result[7]), .invertA(invertA), .invertB(invertB), .operation(operation), .less(1'b0));
  ALU_1bit ALU8( .a(aluSrc1[8]), .b(aluSrc2[8]), .carryIn(carryout[7]), .carryOut(carryout[8]), .result(result[8]), .invertA(invertA), .invertB(invertB), .operation(operation), .less(1'b0));
  ALU_1bit ALU9( .a(aluSrc1[9]), .b(aluSrc2[9]), .carryIn(carryout[8]), .carryOut(carryout[9]), .result(result[9]), .invertA(invertA), .invertB(invertB), .operation(operation), .less(1'b0));
  ALU_1bit ALU10( .a(aluSrc1[10]), .b(aluSrc2[10]), .carryIn(carryout[9]), .carryOut(carryout[10]), .result(result[10]), .invertA(invertA), .invertB(invertB), .operation(operation), .less(1'b0));
  ALU_1bit ALU11( .a(aluSrc1[11]), .b(aluSrc2[11]), .carryIn(carryout[10]), .carryOut(carryout[11]), .result(result[11]), .invertA(invertA), .invertB(invertB), .operation(operation), .less(1'b0));
  ALU_1bit ALU12( .a(aluSrc1[12]), .b(aluSrc2[12]), .carryIn(carryout[11]), .carryOut(carryout[12]), .result(result[12]), .invertA(invertA), .invertB(invertB), .operation(operation), .less(1'b0));
  ALU_1bit ALU13( .a(aluSrc1[13]), .b(aluSrc2[13]), .carryIn(carryout[12]), .carryOut(carryout[13]), .result(result[13]), .invertA(invertA), .invertB(invertB), .operation(operation), .less(1'b0));
  ALU_1bit ALU14( .a(aluSrc1[14]), .b(aluSrc2[14]), .carryIn(carryout[13]), .carryOut(carryout[14]), .result(result[14]), .invertA(invertA), .invertB(invertB), .operation(operation), .less(1'b0));
  ALU_1bit ALU15( .a(aluSrc1[15]), .b(aluSrc2[15]), .carryIn(carryout[14]), .carryOut(carryout[15]), .result(result[15]), .invertA(invertA), .invertB(invertB), .operation(operation), .less(1'b0));
  ALU_1bit ALU16( .a(aluSrc1[16]), .b(aluSrc2[16]), .carryIn(carryout[15]), .carryOut(carryout[16]), .result(result[16]), .invertA(invertA), .invertB(invertB), .operation(operation), .less(1'b0));
  ALU_1bit ALU17( .a(aluSrc1[17]), .b(aluSrc2[17]), .carryIn(carryout[16]), .carryOut(carryout[17]), .result(result[17]), .invertA(invertA), .invertB(invertB), .operation(operation), .less(1'b0));
  ALU_1bit ALU18( .a(aluSrc1[18]), .b(aluSrc2[18]), .carryIn(carryout[17]), .carryOut(carryout[18]), .result(result[18]), .invertA(invertA), .invertB(invertB), .operation(operation), .less(1'b0));
  ALU_1bit ALU19( .a(aluSrc1[19]), .b(aluSrc2[19]), .carryIn(carryout[18]), .carryOut(carryout[19]), .result(result[19]), .invertA(invertA), .invertB(invertB), .operation(operation), .less(1'b0));
  ALU_1bit ALU20( .a(aluSrc1[20]), .b(aluSrc2[20]), .carryIn(carryout[19]), .carryOut(carryout[20]), .result(result[20]), .invertA(invertA), .invertB(invertB), .operation(operation), .less(1'b0));
  ALU_1bit ALU21( .a(aluSrc1[21]), .b(aluSrc2[21]), .carryIn(carryout[20]), .carryOut(carryout[21]), .result(result[21]), .invertA(invertA), .invertB(invertB), .operation(operation), .less(1'b0));
  ALU_1bit ALU22( .a(aluSrc1[22]), .b(aluSrc2[22]), .carryIn(carryout[21]), .carryOut(carryout[22]), .result(result[22]), .invertA(invertA), .invertB(invertB), .operation(operation), .less(1'b0));
  ALU_1bit ALU23( .a(aluSrc1[23]), .b(aluSrc2[23]), .carryIn(carryout[22]), .carryOut(carryout[23]), .result(result[23]), .invertA(invertA), .invertB(invertB), .operation(operation), .less(1'b0));
  ALU_1bit ALU24( .a(aluSrc1[24]), .b(aluSrc2[24]), .carryIn(carryout[23]), .carryOut(carryout[24]), .result(result[24]), .invertA(invertA), .invertB(invertB), .operation(operation), .less(1'b0));
  ALU_1bit ALU25( .a(aluSrc1[25]), .b(aluSrc2[25]), .carryIn(carryout[24]), .carryOut(carryout[25]), .result(result[25]), .invertA(invertA), .invertB(invertB), .operation(operation), .less(1'b0));
  ALU_1bit ALU26( .a(aluSrc1[26]), .b(aluSrc2[26]), .carryIn(carryout[25]), .carryOut(carryout[26]), .result(result[26]), .invertA(invertA), .invertB(invertB), .operation(operation), .less(1'b0));
  ALU_1bit ALU27( .a(aluSrc1[27]), .b(aluSrc2[27]), .carryIn(carryout[26]), .carryOut(carryout[27]), .result(result[27]), .invertA(invertA), .invertB(invertB), .operation(operation), .less(1'b0));
  ALU_1bit ALU28( .a(aluSrc1[28]), .b(aluSrc2[28]), .carryIn(carryout[27]), .carryOut(carryout[28]), .result(result[28]), .invertA(invertA), .invertB(invertB), .operation(operation), .less(1'b0));
  ALU_1bit ALU29( .a(aluSrc1[29]), .b(aluSrc2[29]), .carryIn(carryout[28]), .carryOut(carryout[29]), .result(result[29]), .invertA(invertA), .invertB(invertB), .operation(operation), .less(1'b0));
  ALU_1bit ALU30( .a(aluSrc1[30]), .b(aluSrc2[30]), .carryIn(carryout[29]), .carryOut(carryout[30]), .result(result[30]), .invertA(invertA), .invertB(invertB), .operation(operation), .less(1'b0));
  
  ALU_1bit ALU31( .a(aluSrc1[31]), .b(aluSrc2[31]), .carryIn(carryout[30]), .carryOut(carryout[31]), .result(result[31]), .invertA(invertA), .invertB(invertB), .operation(operation), .less(1'b0));
  //overflow detection
  xor xor1(overflow, carryout[30],carryout[31]);//https://ithelp.ithome.com.tw/articles/10160050
  
  //zero output?
  nor32 nor32_1(.in(result), .out(zero));
  wire not31;
  not n31(not31, result[31]);
endmodule
module nor32(in,out);
      input wire[31:0] in;
      output wire out;
      wire w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,w11,w12,w13,w14,w15,w16;
      wire ww1,ww2,ww3,ww4,ww5,ww6,ww7,ww8;
      wire www1,www2,www3,www4;
      wire wwww1,wwww2;
      wire wwwww1;
      or o1(w1,in[0],in[1]);or o2(w2,in[2],in[3]);or o3(w3,in[4],in[5]);or o4(w4,in[6],in[7]);or o5(w5,in[8],in[9]);
      or o6(w6,in[10],in[11]);or o7(w7,in[12],in[13]);or o8(w8,in[14],in[15]);or o9(w9,in[16],in[17]);or o10(w10,in[18],in[19]);
      or o11(w11,in[20],in[21]);or o12(w12,in[22],in[23]);or o13(w13,in[24],in[25]);or o14(w14,in[26],in[27]);or o15(w15,in[28],in[29]);
      or o16(w16,in[30],in[31]);
      
      or oo1(ww1, w1,w2); or oo2(ww2, w3,w4); or oo3(ww3, w5,w6); or oo4(ww4, w7,w8); or oo5(ww5, w9,w10); or oo6(ww6, w11,w12); or oo7(ww7, w13,w14); or oo8(ww8, w15,w6);
      or ooo1(www1, ww1,ww2);or ooo2(www2, ww3,ww4);  or ooo3(www3, ww5,ww6);   or ooo4(www4, ww7,ww8);
      or oooo1(wwww1, www1,www2);or oooo2(wwww2, www3,www4);
      or ooooo1(wwwww1, wwww1,wwww2);         
      
      not n1(out,wwwww1);
endmodule