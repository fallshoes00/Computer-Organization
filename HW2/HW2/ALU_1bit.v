module ALU_1bit( result, carryOut, a, b, invertA, invertB, operation, carryIn, less ); 
  
  output wire result;
  output wire carryOut;
  
  input wire a;
  input wire b;
  input wire invertA;
  input wire invertB;
  input wire[1:0] operation;
  input wire carryIn;
  input wire less;
  
  /*your code here*/ 
  wire a_out, b_out;
  /*assign a_out = (invertA)?~a:a;
  assign b_out = (invertB)?~b:b;
  assign result = (operation==2'b00)?or_ab:
                (operation==2'b01)?and_ab:
                (operation==2'b10)?add_ab:
                (operation==2'b11)?less:less;*/
  
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  wire not_a,not_b;
  not n1(not_a,a);
  not n2(not_b,b);
  m21 m_a_out(.Y(a_out), .D0(a), .D1(not_a), .S(invertA));
  m21 m_b_out(.Y(b_out), .D0(b), .D1(not_b), .S(invertB));
  
  
  wire or_ab, and_ab;
  or or1(or_ab, a_out, b_out);
  and and1(and_ab, a_out, b_out);
  
  
  
  
  wire add_ab;
  Full_adder fa1(.sum(add_ab), .carryOut(carryOut), .carryIn(carryIn), .input1(a_out), .input2(b_out));
  mux4to1 m41(.out(result),  .in1(or_ab), .in2(and_ab), .in3(add_ab), .in4(less), .op(operation));
//  mux4to1 m41(.out(result),  .in1(or_ab), .in2(and_ab), .in3(add_ab), .in4(less), .op(operation));

endmodule

module mux4to1(out, in1,in2, in3, in4,op);

output out;
input in1,in2,in3,in4;
input [1:0]op;
wire op1_bar, op0_bar, T1, T2, T3, T4;

not n1(op1_bar, op[1]);
not n2(op0_bar, op[0]);
and a1(T1, in1, op1_bar, op0_bar);//s0b   s1b
and a2(T2, in2, op1_bar, op[0]);// s0b  s1
and a3(T3, in3, op[1], op0_bar);//s0  s1b
and a4(T4, in4, op[1], op[0]);// s0  s1
or o1(out, T1, T2, T3, T4);

endmodule
