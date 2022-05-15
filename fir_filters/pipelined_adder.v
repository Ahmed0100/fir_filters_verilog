module pipelined_adder(clk,reset,a,b,cin,s,cout);
input [3:0] a,b;
input cin,clk,reset;
output reg [3:0] s;
output reg cout;

reg [1:0] a_reg,b_reg;
reg  s0_reg,s1_reg;
reg c2_reg;
reg s0,s1,s2,s3;
reg c1,c2,c3;

always @*
	begin
	//combinantial cloud 1
	{c1,s0}=a[0]+b[0]+cin;
	{c2,s1}=a[1]+b[1]+c1;
	//combinantial cloud2
	{c3,s2}=a_reg[0]+b_reg[0]+c2_reg;
	{cout,s3}=a_reg[1]+b_reg[1]+c3;
	s={s3,s2,s1_reg,s0_reg};
	end
always @(posedge clk or posedge reset)
	if(reset)
		begin 
		s0_reg=0;
		s1_reg=0;
		c2_reg=0;
		a_reg=0;
		b_reg=0;
		end
	else
		begin
		s0_reg<=s0;
		s1_reg<=s1;
		c2_reg<=c2;
		a_reg[1:0]<=a[3:2];
		b_reg[1:0]<=b[3:2];
		end
endmodule 