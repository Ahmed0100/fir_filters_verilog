module CSA(a,b,cin,cout,sum);
input [15:0] a,b;
input cin;
output wire [15:0] sum;
output wire cout;
wire [15:4] sum_L1_0,sum_L1_1;
wire c4,c8_0,c8_1,c12_0,c12_1,c16_0,c16_1;
wire c16_c12_0,c16_c12_1;
wire [3:0] sum_L2_c12_0,sum_L2_c12_1;
//Hierarchical Carry select adder ...Level 1
assign {c4,sum[3:0]}=a[3:0]+b[3:0]+cin;
assign {c8_0,sum_L1_0[7:4]}=a[7:4]+b[7:4]+0;
assign {c8_1,sum_L1_1[7:4]}=a[7:4]+b[7:4]+1;
assign {c12_0,sum_L1_0[11:8]}=a[11:8]+b[11:9]+0;
assign {c12_1,sum_L1_1[11:8]}=a[11:8]+b[11:9]+1;
assign {c16_0,sum_L1_0[15:12]}=a[15:12]+b[15:12]+0;
assign {c16_1,sum_L1_1[15:12]}=a[15:12]+b[15:12]+1;
//level 2
assign c8= c4? c8_1:c8_1;
assign sum[7:4]=c4 ? sum_L1_1:sum_L1_0;

assign c16_c12_0= c12_0 ? c16_1:c16_0;
assign sum_L2_c12_0= c12_0 ? sum_L1_1[15:12]:sum_L1_0[15:12];
assign c16_c12_1= c12_1 ? c16_1:c16_0;
assign sum_L2_c12_1= c12_1 ? sum_L1_1[15:12]:sum_L1_0[15:12];
//Level3 
assign cout = c8 ? c16_c12_1:c16_c12_0;
assign sum[15:8]= c8 ? {sum_L2_c12_1,sum_L1_1[11:8]}:{sum_L2_c12_0,sum_L1_0[11:8]}; 
endmodule 