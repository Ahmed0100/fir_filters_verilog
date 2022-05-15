 module FIR_DA(clk,reset,xn_b,counter,yn);
input clk,reset;
input  xn_b;
input [3:0] counter;
output reg [32:0] yn;

reg [15:0] xn_0,xn_1,xn_2,xn_3;

wire [3:0] addr;
reg [16:0] rom_out;
wire valid;
wire [32:0] sum;
assign addr={xn_3[0],xn_2[0],xn_1[0],xn_0[0]};

always @(addr)
	case(addr)
		4'd0: rom_out=17'b00000000000000000;
		4'd1: rom_out=17'b00000001000100100; // h0
		4'd2: rom_out=17'b00011110111011100; // h1
		4'd3: rom_out=17'b00100000000000000; // h0+h1
		4'd4: rom_out=17'b00011110111011100; // h2
		4'd5: rom_out=17'b00100000000000000; // h2+h0
		4'd6: rom_out=17'b00111101110111000; // h2+h1
		4'd7: rom_out=17'b00111110111011100; // h2+h1+h0
		4'd8: rom_out=17'b00000001000100100; // h3
		4'd9: rom_out=17'b00000010001001000; // h3+h0
		4'd10:rom_out=17'b00100000000000000; // h3+h1
		4'd11: rom_out=17'b00100001000100100; // h3+h1+h0
		4'd12: rom_out=17'b00100000000000000; // h3+h2
		4'd13: rom_out=17'b00100001000100100; // h3+h2+h0
		4'd14: rom_out=17'b00111110111011100; // h3+h2+h1
		4'd15: rom_out=17'b01000000000000000; // h3+h2+h1+h0
		default: rom_out=17'bx;
	endcase
assign valid=~(|counter);
assign msb=(&counter);
assign sum={(rom_out^{17{msb}}),16'b0}+{16'b0,msb,16'b0};
reg [32:0] acc;


always @(posedge clk or posedge reset)
	if(reset)
		begin 
		xn_0<=0;
		xn_1<=0;
		xn_2<=0;
		xn_3<=0;
		acc<=0;
		end
	else
		begin 
		xn_0<={xn_b,xn_0[15:1]};
		xn_1<={xn_0[0],xn_1[15:1]};
		xn_2<={xn_1[0],xn_2[15:1]};
		xn_3<={xn_2[0],xn_3[15:1]};
		if(&counter)
			begin
			yn<=sum;
			acc<=0;
			end
		else
		
			acc=sum;
		end
endmodule 