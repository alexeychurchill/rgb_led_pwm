module tb_psc4;

	reg clk = 1'b1;
	always
		#1 clk = ~clk;
		
	wire q;
	psc4 #( .div(4'd9) ) testee ( .clk(clk), .q(q) );
	
endmodule
