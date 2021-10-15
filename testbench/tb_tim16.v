module tb_tim16;
	reg clk = 1'b0;
	
	always
		#1 clk = ~clk;
	
	reg en = 1'b0;
	reg [15:0] arr_in = 16'hF; 
	reg [15:0] cmp0_in = 16'h3;
	reg [15:0] cmp1_in = 16'h7;
	reg [15:0] cmp2_in = 16'hB;
	reg [15:0] cmp3_in = 16'hF;
	wire out, cmp0_out, cmp1_out, cmp2_out, cmp3_out;
	
	tim16 #( 
		.psc(16'hF) 
	) tested (  
		.clk(clk), 
		.en(en), 
		.arr(arr_in), 
		.out(out), 
		
		.cmp0(cmp0_in), 
		.cmp0_out(cmp0_out), 
		
		.cmp1(cmp1_in), 
		.cmp1_out(cmp1_out), 
		
		.cmp2(cmp2_in), 
		.cmp2_out(cmp2_out), 
		
		.cmp3(cmp3_in), 
		.cmp3_out(cmp3_out)
	);
	
	initial begin
		#10 en = 1'b1;
		#64 arr_in = 16'h7F;
		#115 cmp0_in = 16'hF;
		#0 cmp1_in = 16'hB;
		#0 cmp2_in = 16'h7;
		#0 cmp3_in = 16'h3;
	end
endmodule
