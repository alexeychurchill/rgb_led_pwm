module led_driver(
	input CLK, 
	output LED_R, 
	output LED_G, 
	output LED_B, 
	output VAL_CLK, 
	output PWM_CLK
);
	
	wire val_clk, pwm_clk;
	assign VAL_CLK = val_clk;
	assign PWM_CLK = pwm_clk;
	wire [7:0] led_pwm_val_r, led_pwm_val_g, led_pwm_val_b;
	
	counter16 #(
		.min(8'd0),
		.max(8'd124),
		.init(8'd31)
	) led_cnt_r (
		.e(val_clk), 
		.q(led_pwm_val_r)
	);
	
	counter16 #(
		.min(8'd0),
		.max(8'd124),
		.init(8'd62)
	) led_cnt_g (
		.e(val_clk), 
		.q(led_pwm_val_g)
	);
	
	counter16 #(
		.min(8'd0),
		.max(8'd124),
		.init(8'd93)
	) led_cnt_b (
		.e(val_clk), 
		.q(led_pwm_val_b)
	);
	
	// 200 Hz -> PWM_CLK / 10 -> psc = 9
	psc4 #(
		.div(4'd9)
	) pwm_scl (
		.clk(pwm_clk),
		.q(val_clk)
	);
	
	// 2kHz -> CLK / 25000 -> psc = 25, arr = 100
	tim16 #(
		.psc(16'd24)
	) led_pwm_tim (
		.clk(CLK),
		.en(1'b1),
		.arr(16'd999), 
		.out(pwm_clk),
		.cmp0({ 5'b0, led_pwm_val_r, 3'b0 }), 
		.cmp1({ 5'b0, led_pwm_val_g, 3'b0 }),
		.cmp2({ 5'b0, led_pwm_val_b, 3'b0 }),
		.cmp0_out(LED_R),
		.cmp1_out(LED_G),
		.cmp2_out(LED_B)
	);
	
endmodule
