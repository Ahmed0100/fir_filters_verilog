module bcla #(parameter n=16)(a,b,cin,s,cout);
input [n-1:0] a,b;
input cin;
output reg [n-1:0] s;
output reg cout;
reg [n-1:0] p,g,P,G;
reg [n:0] c;
integer i;
always @*
	for(i=0;i<n; i=i+1)
		begin
		p[i]=a[i] ^ b[i];
		g[i]=a[i] & b[i] ;
	end

always @*
	begin
	P[0]=p[0];
	G[0]=g[0];
	for(i=1; i<n ; i=i+1)
		begin
		P[i]=p[i] & P[i-1];
		G[i]=g[i] | (p[i] &G[i-1]);
		end
	end
always @*
	begin
	c[0]=cin;
	for(i=0;i<n ;i=i+1)
		begin
		c[i+1]=G[i] | (c[i] & P[i]);
		s[i]= p[i] ^ c[i];
		end
	cout=c[n];
	end
endmodule 