module barrel_shifter(x,s,,a_l,out);
input [15:0] x;
input signed [4:0] s,a_l;
output wire [15:0] out;
wire [30:0] y0;
wire [22:0] y1;
wire [18:0] y2;
wire [16:0] y3;
wire [15:0] sgn;

assign sgn= a_l? {15{x[15]}}: 15'b0;
assign y0=s[4] ? {x[14:0],16'b0}: {sgn,x};
assign y1=s[3] ? y0[30:8]: y0[22:0];
assign y2=s[2] ? y1[22:4]: y1[18:0];
assign y3=s[1] ? y2[18:2]: y2[16:0];
assign out=s[0] ? y3[16:1] : y3[15:0];

endmodule 
