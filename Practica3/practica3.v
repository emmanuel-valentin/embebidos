module practica3 (
	input		clk_i,
	input		rst_i,
	output	red1_o,
	output	red2_o,
	output	green1_o,
	output	green2_o,
	output	yellow1_o,
	output	yellow2_o
);

	wire		clk_div;

	freq_div div(
		.clk_i	(clk_i),
		.clk_div	(clk_div),
		.freq_i (sw_freq)
	);

	semaforo semaforo1 (
		.clk_i(clk_div),
		.red(red1_o),
		.green(green1_o),
		.yellow(yellow1_o)
	);
	
	semaforo semaforo2 (
		.clk_i(clk_div),
		.red(red2_o),
		.green(green2_o),
		.yellow(yellow2_o)
	);

endmodule 