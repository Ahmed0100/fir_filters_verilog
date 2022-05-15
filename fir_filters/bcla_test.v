module basic_multiplier_test;
reg [5:0] a,b;
wire [11:0] out;

basic_multiplier u1(a,b,out);
initial
	begin
	a=5;
	b=5;
	
	end
endmodule 
