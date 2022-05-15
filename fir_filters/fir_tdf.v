module fir_tdf(clk,reset,xn,yn);
input [15:0] xn;
input clk,reset;
output wire signed [31:0] yn;

reg signed [31:0] pp [0:15];
integer i;

reg signed [31:0] pp_0, pp_1, pp_2, pp_3, pp_4, pp_5,
pp_6, pp_7, pp_8, pp_9, pp_10, pp_11,
pp_12, pp_13, pp_14, pp_15;
reg signed [31:0] s0,s1,s2,s3,s4,s0_reg,s1_reg,s2_reg,s3_reg,s4_reg;
reg signed [32:0] c0,c1,c2,c3,c4,c0_reg,c1_reg,c2_reg,c3_reg,c4_reg;

always 
 	begin
	
	pp_0={5'b00000,~xn[15],xn[14:0],11'b0};
	pp_1={7'b0000000,xn[15],~xn[14:0],9'b0};
	pp_2={10'b0000000000,~xn[15],xn[14:0],6'b0};
	pp_3={13'b0,~xn[15],xn[14:0],3'b0};
	//
	pp_4={2'b00,~xn[15],xn[14:0],14'b0};
	pp_5={6'b0,xn[15],~xn[14:0],10'b0};
	//
	pp_6={1'b0,~xn[15],xn[14:0],15'b0};
	pp_7={6'b0,xn[15],~xn[14:0],10'b0};
	pp_8={9'b0,xn[15],~xn[14:0],7'b0};
	pp_9={12'b0,xn[15],~xn[14:0],4'b0};
	//
	
	pp_10={2'b0,~xn[15],xn[14:0], 14'b0};
	pp_11={6'b0,xn[15],~xn[14:0], 10'b0};
	// PPs for coefficient h4 with sign extension elimination
	pp_12={5'b0,~xn[15],xn[14:0],11'b0};
	pp_13={7'b0, xn[15],~xn[14:0],9'b0};
	pp_14={10'b0,~xn[15],xn[14:0],6'b0};
	pp_15={13'b0,~xn[15],xn[14:0],3'b0};
	end
reg signed [15:0] xn_reg;
reg signed[31:0] s00,s000,s10,s20,s200,s30,s40,s01,s21,s41;
reg signed[32:0] c00,c000,c10,c20,c200,c30,c40,c01,c21,c41;
reg signed [31:0] CV=32'b01101111011100000001000010010000;
// Add final partial sum and carry using CPA
assign yn=c0_reg+s0_reg;
always @(posedge clk or posedge reset)
	if(reset)
	begin
		xn_reg<=0;
		s0_reg<=0;
		s1_reg<=0;
		s2_reg<=0;
		s3_reg<=0;
		s4_reg<=0;
	end
	else
	begin
		xn_reg<=xn;
		s0_reg<=s0;
		s1_reg<=s1;
		s2_reg<=s2;
		s3_reg<=s3;
		s4_reg<=s4;
	end

always @*
	for(i=0;i<32;i=i+1)
		begin
		{c00[i+1],s00[i]}=pp_0[i]+pp_1[i]+pp_2[i];
		{c000[i+1],s000[i]}=pp_3[i]+s1_reg[i]+c1_reg[i];
		//
		{c10[i+1],s10[i]}=pp_4[i]+pp_5[i]+s2_reg[i];
		//
		{c20[i+1],s20[i]}=pp_6[i]+pp_7[i]+pp_8[i];
		{c200[i+1],s200[i]}=pp_9[i]+s3_reg[i]+c3_reg[i];
		//
		{c30[i+1],s30}=pp_10[i]+pp_11[i]+s4_reg[i];
		//
		{c40[i+1],s40[i]}=pp_13[i]+pp_14[i]+pp_15[i];
		//level 2
		{c01[i+1],s01[i]}=c00[i]+s00[i]+s000[i];
		//
		{c21[i+1],s21[i]}=s20[i]+c20[i]+s200[i];
		//
		{c41[i+1],s41[i]}=c40[i]+s40[i]+pp_12[i];
		//level3
		{c0[i+1],s0[i]}=c01[i]+s01[i]+c000[i];
		{c1[i+1],s1[i]}=c10[i]+s10[i]+c2_reg[i];
		{c2[i+1],s2[i]}=s21[i]+c21[i]+c200[i];
		{c3[i+1],s3[i]}=c30[i]+s30[i]+c4_reg[i];
		{c4[i+1],s4[i]}=c41[i]+s41[i]+CV;
		end
endmodule 
