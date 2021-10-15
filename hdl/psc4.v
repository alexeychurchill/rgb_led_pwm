module psc4 #(
	parameter div = 4'b1
) (
	input clk, 
	output q
);

	reg [3:0] cnt = div;
	
	assign q = cnt == 4'b0;
	
	always @(negedge clk) begin
		cnt <= cnt == 4'b0 ? div : (cnt - 4'b1);
	end

endmodule
