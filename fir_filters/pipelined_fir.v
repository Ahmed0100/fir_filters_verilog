
module pipelined_fir(clk,reset,xn,yn);
input clk,reset;
input [15:0] xn;
output wire signed [15:0] yn;
parameter signed [15:0] h0=16'b1001100110111011;
parameter signed [15:0] h1=16'b1010111010101110;
parameter signed [15:0] h2=16'b0101001111011011;
parameter signed [15:0] h3=16'b0100100100101000;
reg signed [31:0] mul_reg [0:3];
reg signed [31:0] add_reg [0:2];
reg signed [31:0] yn_reg;
always @(posedge clk or posedge reset)
	if(reset)
		begin
		mul_reg[0]<=0;
		mul_reg[1]<=0;
		mul_reg[2]<=0;
		mul_reg[3]<=0;
		add_reg[0]<=0;
		add_reg[1]<=0;
		add_reg[2]<=0;
		yn_reg<=0;	
		end
	else
		begin
		add_reg[0]<=mul_reg[0];
		add_reg[1]<=mul_reg[1]+add_reg[0];
		add_reg[2]<=mul_reg[2]+add_reg[1];
		yn_reg<=mul_reg[3]+add_reg[2];
		mul_reg[0]<=xn*h3;
		mul_reg[1]<=xn*h2;
		mul_reg[2]<=xn*h1;
		mul_reg[3]<=xn*h0;
		end
	assign yn=yn_reg[31:16];
endmodule 