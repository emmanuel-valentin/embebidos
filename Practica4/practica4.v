module practica4(
	input clk_i,
	input rst_i,
	output wire [7:0] leds_o 
);

	wire clk_div;
	
	knigth kr (
		.clk_i(clk_div),
		.rst_i(rst_i),
		.leds_o(leds_o) 
	);
	
	freq_div fdiv (
		.clk_i(clk_i),
		.rst_i(rst_i),
		.clk_div(clk_div)
	);

endmodule
