
module fir_filter(clk,reset,data_in,data_out);
input clk,reset;
input signed [15:0] data_in; //Q1.15 
output reg signed [15:0] data_out; // Q1.15
//filter coefficients Q1.15
parameter signed [15:0] b0=16'b1100101110011001;
parameter signed [15:0] b1=16'b1110101010001110;
parameter signed [15:0] b2=16'b0011001111011011;
parameter signed [15:0] b3=16'b0110100000001000;
parameter signed [15:0] b4=16'b0110100000001000;
parameter signed [15:0] b5=16'b0011001111011011;
parameter signed [15:0] b6=16'b1110101010001110;
parameter signed [15:0] b7=16'b1101110110111011;


wire signed [39:0]y; // Q8.32 format
reg signed [15:0]x[0:7]; 
always @(posedge clk or posedge reset)
	if(reset)
		begin
		x[0] <=0;
		x[1] <=0;
		x[2] <=0;
		x[3] <=0;
		x[4] <=0;
		x[5] <=0;
		x[6] <=0;
		x[7] <=0;
		data_out<=0;
		end
	else
		begin
		x[0] <= data_in;
		x[1] <= x[0];
		x[2] <= x[1];
		x[3] <= x[2];
		x[4] <= x[3];
		x[5] <= x[4];
		x[6] <= x[5];
		x[7] <= x[6];
		data_out <= y[30:15];
		end
assign y=x[0] * b0 + x[1] * b1 + x[2] * b2 + x[3] * b3 + x[4] * b4 + x[5] * b5 + x[6] * b6 + x[7] * b7;

endmodule 
