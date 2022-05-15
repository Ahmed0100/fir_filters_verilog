module fir_csd_cv(clk,reset,x,y);
input clk,reset;
input reset;
input [15:0] x;
output reg signed [31:0] y;
reg signed [31:0] pp [0:15];
reg signed [15:0] xn,xn_1,xn_2,xn_3,xn_4;
reg signed [31:0] y_reg;
reg signed [31:0] CV=32'b1111011100000001000010010000;
always @(posedge clk or posedge reset)
	if(reset)
		begin
		xn<=0;
		xn_1=0;
		xn_2=0;
		xn_3=0;
		xn_4=0;
		y_reg=0;
		end
	else
		begin 
		xn<=x;
		xn_1=xn;
		xn_2=xn_1;
		xn_3=xn_2;
		xn_4=xn_3;
		y=y_reg;
		end
	
always @*
	begin
	pp[0]={5'b00000,~xn[15],xn[14:0],11'b0};
	pp[1]={7'b0000000,xn[15],~xn[14:0],9'b0};
	pp[2]={10'b0000000000,~xn[15],xn[14:0],6'b0};
	pp[3]={13'b0,~x[15],xn[14:0],3'b0};
	//
	pp[4]={2'b00,~xn_1[15],xn_1[14:0],14'b0};
	pp[5]={6'b0,xn_1[15],~xn_1[14:0],10'b0};
	//
	pp[6]={1'b0,~xn_2[15],xn_2[14:0],15'b0};
	pp[7]={6'b0,xn_2[15],~xn_2[14:0],10'b0};
	pp[8]={9'b0,xn_2[15],~xn_2[14:0],7'b0};
	pp[9]={12'b0,xn_2[15],~xn_2[14:0],4'b0};
//
	
	pp[10]={2'b0,~xn_3[15],xn_3[14:0], 14'b0};
	pp[11]={6'b0,xn_3[15],~xn_3[14:0], 10'b0};
// PPs for coefficient h4 with sign extension elimination
	pp[12]={5'b0,~xn_4[15],xn_4[14:0],11'b0};
	pp[13]={7'b0, xn_4[15],~xn_4[14:0],9'b0};
	pp[14]={10'b0,~xn_4[15],xn_4[14:0],6'b0};
	pp[15]={13'b0,~xn_4[15],xn_4[14:0],3'b0};
	y_reg=pp[0]+pp[1]+pp[2]+pp[3]+pp[4]+pp[5]+pp[6]+pp[7]+pp[8]+pp[9]+pp[10]+pp[11]+pp[12]+pp[13]+pp[14]+pp[15]+CV;
	end
endmodule 