module pipelined_adder_test;

reg clk,reset,cin;
reg [3:0] a,b;
wire [3:0] s;
wire cout;

pipelined_adder u1(clk,reset,a,b,cin,s,cout);
initial 
	begin
	a=5;
	b=5;
	cin=0;
	reset=1;
	clk=0;
	#20
	reset=0;
	end
always 
#10 clk=!clk;
endmodule 