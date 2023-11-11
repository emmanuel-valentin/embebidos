module practica3 (
	input		clk_i,
	input		rst_i,
	input		sw_green_1,
	input		sw_green_2,
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
		.rst_i	(rst_i),
		.clk_div	(clk_div)
	);

	semaforo #(.initial_state(0)) semaforo1 (
		.clk_i(clk_div),
		.rst_i(rst_i),
		.red(red1_o),
		.sw_green_i(sw_green_1),
		.green(green1_o),
		.yellow(yellow1_o)
	);
	
	semaforo #(.initial_state(2)) semaforo2 (
		.clk_i(clk_div),
		.rst_i(rst_i),
		.sw_green_i(sw_green_2),
		.red(red2_o),
		.green(green2_o),
		.yellow(yellow2_o)
	);

endmodule 

module tb_practica3();

	reg	clk_i;
	reg	rst_i;
	reg	sw_green_1;
	reg	sw_green_2;
	wire	red1_o;
	wire	red2_o;
	wire	green1_o;
	wire	green2_o;
	wire	yellow1_o;
	wire	yellow2_o;
	
	practica3 DUT (
		.clk_i(clk_i),
		.rst_i(rst_i),
		.sw_green_1(sw_green_1),
		.sw_green_2(sw_green_2),
		.red1_o(red1_o),
		.red2_o(red2_o),
		.green1_o(green1_o),
		.green2_o(green2_o),
		.yellow1_o(yellow1_o),
		.yellow2_o(yellow2_o)
	);
	
	initial clk_i = 1'b0;
	
	always #10 clk_i = ~clk_i;
	
	initial
	begin
		rst_i = 1'b0;
		sw_green_1 = 1'b0;
		sw_green_2 = 1'b0;
		#10
		rst_i = 1'b1;
	end
	
	initial #2400 $finish;

endmodule 