module basic_multiplier(a,b,out);
input [5:0] a,b;
output wire [11:0] out;
integer i;
reg [5:0] partial_p [0:5];
always @*
	for(i=0;i<6;i=i+1)
		partial_p[i]=b & {6{a[i]}};

assign out=partial_p[0]+{partial_p[1],1'b0}+{partial_p[2],2'b0}+{partial_p[3],3'b0}+{partial_p[4],4'b0}+{partial_p[5],5'b0};
endmodule