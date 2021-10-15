module counter16 #(
	parameter min = 8'h00, 
	parameter max = 8'hFF, 
	parameter init = min 
) (
	input e, 
	output reg [7:0] q
);
	
	initial q = init;

	wire sw_add = q == min;
	wire sw_sub = q == max;
	
	reg op = 1'b0;
	
	wire op_add = (~op & ~sw_add & ~sw_sub) | (op & sw_add);
	
	always @(negedge e) begin
		op <= sw_add ? 1'b0 : (sw_sub ? 1'b1 : op);
		q <= op_add ? (q + 8'h1) : (q - 8'h1);
	end
endmodule
