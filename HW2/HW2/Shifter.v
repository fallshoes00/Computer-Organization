module Shifter( result, leftRight, shamt, sftSrc  );
    
  output wire[31:0] result;

  input wire leftRight;
  input wire[4:0] shamt;
  input wire[31:0] sftSrc ;
  
  /*your code here*/ 
  // right shift:  leftRight=0,     left shift:  leftRight=1
  //assign result = (leftRight)?{1'b0,sftSrc[31:1]} : {sftSrc[30:0], 1'b0};
  
  //true
  //assign result = (leftRight)? {sftSrc[30:0], 1'b0}: {1'b0,sftSrc[31:1]};
	//m21 m2(.Y(result[31]),  .D0({1'b0,sftSrc[31:1]}), .D1({sftSrc[30:0], 1'b0}),  .S(leftRight));
	
	
	m21 m0(.Y(result[31]),  .D0(1'b0), .D1(sftSrc[30]),  .S(leftRight));
	m21 m1(.Y(result[30]),  .D0(sftSrc[31]), .D1(sftSrc[29]),  .S(leftRight));
	m21 m2(.Y(result[29]),  .D0(sftSrc[30]), .D1(sftSrc[28]),  .S(leftRight));
	m21 m3(.Y(result[28]),  .D0(sftSrc[29]), .D1(sftSrc[27]),  .S(leftRight));
	m21 m4(.Y(result[27]),  .D0(sftSrc[28]), .D1(sftSrc[26]),  .S(leftRight));
	m21 m5(.Y(result[26]),  .D0(sftSrc[27]), .D1(sftSrc[25]),  .S(leftRight));
	m21 m6(.Y(result[25]),  .D0(sftSrc[26]), .D1(sftSrc[24]),  .S(leftRight));
	m21 m7(.Y(result[24]),  .D0(sftSrc[25]), .D1(sftSrc[23]),  .S(leftRight));
	m21 m8(.Y(result[23]),  .D0(sftSrc[24]), .D1(sftSrc[22]),  .S(leftRight));
	m21 m9(.Y(result[22]),  .D0(sftSrc[23]), .D1(sftSrc[21]),  .S(leftRight));
	m21 m10(.Y(result[21]),  .D0(sftSrc[22]), .D1(sftSrc[20]),  .S(leftRight));
	m21 m11(.Y(result[20]),  .D0(sftSrc[21]), .D1(sftSrc[19]),  .S(leftRight));
	m21 m12(.Y(result[19]),  .D0(sftSrc[20]), .D1(sftSrc[18]),  .S(leftRight));
	m21 m13(.Y(result[18]),  .D0(sftSrc[19]), .D1(sftSrc[17]),  .S(leftRight));
	m21 m14(.Y(result[17]),  .D0(sftSrc[18]), .D1(sftSrc[16]),  .S(leftRight));
	m21 m15(.Y(result[16]),  .D0(sftSrc[17]), .D1(sftSrc[15]),  .S(leftRight));
	m21 m16(.Y(result[15]),  .D0(sftSrc[16]), .D1(sftSrc[14]),  .S(leftRight));
	m21 m17(.Y(result[14]),  .D0(sftSrc[15]), .D1(sftSrc[13]),  .S(leftRight));
	m21 m18(.Y(result[13]),  .D0(sftSrc[14]), .D1(sftSrc[12]),  .S(leftRight));
	m21 m19(.Y(result[12]),  .D0(sftSrc[13]), .D1(sftSrc[11]),  .S(leftRight));
	m21 m20(.Y(result[11]),  .D0(sftSrc[12]), .D1(sftSrc[10]),  .S(leftRight));
	m21 m21(.Y(result[10]),  .D0(sftSrc[11]), .D1(sftSrc[9]),  .S(leftRight));
	m21 m22(.Y(result[9]),  .D0(sftSrc[10]), .D1(sftSrc[8]),  .S(leftRight));
	m21 m23(.Y(result[8]),  .D0(sftSrc[9]), .D1(sftSrc[7]),  .S(leftRight));
	m21 m24(.Y(result[7]),  .D0(sftSrc[8]), .D1(sftSrc[6]),  .S(leftRight));
	m21 m25(.Y(result[6]),  .D0(sftSrc[7]), .D1(sftSrc[5]),  .S(leftRight));
	m21 m26(.Y(result[5]),  .D0(sftSrc[6]), .D1(sftSrc[4]),  .S(leftRight));
	m21 m27(.Y(result[4]),  .D0(sftSrc[5]), .D1(sftSrc[3]),  .S(leftRight));
	m21 m28(.Y(result[3]),  .D0(sftSrc[4]), .D1(sftSrc[2]),  .S(leftRight));
	m21 m29(.Y(result[2]),  .D0(sftSrc[3]), .D1(sftSrc[1]),  .S(leftRight));
	m21 m30(.Y(result[1]),  .D0(sftSrc[2]), .D1(sftSrc[0]),  .S(leftRight));
    m21 m31(.Y(result[0]),  .D0(sftSrc[1]), .D1(1'b0),  .S(leftRight));

endmodule

module m21(Y, D0, D1, S);

input D0, D1, S;
output Y;
wire w1, w2, Sbar;

not (not_S, S);
and a1(w1, D1, S);
and a2(w2, D0, not_S);
or (Y, w1, w2);

endmodule
