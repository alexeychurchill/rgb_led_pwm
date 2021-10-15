module tim16 #(
	parameter psc = 16'h0
) (
	input clk, 
	input en, 
	input [15:0] arr, 
	input [15:0] cmp0, 
	input [15:0] cmp1,
	input [15:0] cmp2, 
	input [15:0] cmp3,
	output out, 
	output cmp0_out,
	output cmp1_out,
	output cmp2_out,
	output cmp3_out
);
	
	reg [15:0] psc_cnt = psc;
	wire inc_cnt = psc_cnt == 16'h0;
	
	reg prl_empty = 1'b1;
	
	reg [15:0] prl_arr = 16'h0;	
	reg [15:0] cnt = 16'h0;
	wire rst_cnt = cnt == (prl_empty ? arr : prl_arr);

	assign out = rst_cnt;

	reg [15:0] prl_cmp0 = 16'b0;
	reg [15:0] prl_cmp1 = 16'b0;
	reg [15:0] prl_cmp2 = 16'b0;
	reg [15:0] prl_cmp3 = 16'b0;
	
	assign cmp0_out = en & (cnt <= (prl_empty ? cmp0 : prl_cmp0));
	assign cmp1_out = en & (cnt <= (prl_empty ? cmp1 : prl_cmp1));
	assign cmp2_out = en & (cnt <= (prl_empty ? cmp2 : prl_cmp2));
	assign cmp3_out = en & (cnt <= (prl_empty ? cmp3 : prl_cmp3));
	
	always @(negedge clk) begin
		if (en & prl_empty) begin
			prl_arr <= arr;
			prl_cmp0 <= cmp0;
			prl_cmp1 <= cmp1;
			prl_cmp2 <= cmp2;
			prl_cmp3 <= cmp3;
			prl_empty <= 1'b0;
		end
		
		if (en & inc_cnt & rst_cnt) begin
			prl_cmp0 <= cmp0;
			prl_cmp1 <= cmp1;
			prl_cmp2 <= cmp2;
			prl_cmp3 <= cmp3;
			prl_arr <= arr;
		end
	
		if (en & inc_cnt) begin
			cnt <= rst_cnt ? 16'h0 : cnt + 16'h1;
		end
		
		if (en) begin
			psc_cnt <= inc_cnt ? psc : psc_cnt - 16'h1;
		end
	end
	
endmodule
