module tb_counter16;
	reg clk = 1'b1;
	reg en = 1'b0;
	
	always
		#1 clk = en ? ~clk : clk;
	
	wire [7:0] q;
	
	counter16 #( .min(8'h7), .max(8'hF), .init(8'hA) ) tested ( .e(clk), .q(q) );
	
	initial begin
		#10 en = 1'b1;
	end
endmodule
