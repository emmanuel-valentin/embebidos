module semaforo #(parameter initial_state = 2'd0) 
(
	input				clk_i,
	input				rst_i,
	// TODO: Implementar el push button para dar paso al peaton
	input				sw_green_i,
	output reg		red,
	output reg		green,
	output reg		yellow
);

	reg	[1:0]	current_state;
	reg	[1:0]	next_state;
	reg	[6:0]	count;
	reg	[6:0]	start;
	reg   [1:0] prev_count;
	
	initial
	begin
		if (initial_state == 2'd0)
			start = 7'd0;
		if (initial_state == 2'd1)
			start = 7'd55;
		else if (initial_state == 2'd2)
			start = 7'd60;
	end
	
	always @(posedge clk_i, negedge rst_i)
	begin
		if (!rst_i)
			current_state = initial_state;
		else
			current_state = next_state;
	end
	
	always @(posedge clk_i, negedge rst_i)
	begin
		if (!rst_i)
			count = start;
		else
		begin
			if (count == 7'd119)
				count = 7'd0;
			count = count + 1;
		end
	end
	
	// Indica el estado siguiente del semaforo con respecto al estado actual y el valor actual del contador
	// 00 (0) -> verde, 01 (1) -> amarillo, 10 (2) -> rojo
	always @(current_state, count, sw_green_i)
	begin
		case (current_state)
			2'd0:
				if (count >= 7'd54)
					next_state = 2'd1;
				else if (!sw_green_i == 1'b1)
				begin
					prev_count = count;
					next_state = 7'd3;
				end
				else
					next_state = current_state;
			2'd1:
				if (count >= 7'd59)
					next_state = 2'd2;
				else
					next_state = current_state;
			2'd2:
				if (count >= 7'd119)
					next_state = 2'd0;
				else
					next_state = current_state;
			2'd3:
			begin
				if (count == prev_count + 5)
					next_state = 2'd0;
				else
					next_state = current_state;
			end
			default:
				next_state = initial_state;
		endcase
	end
	
	// Indica los leds que deben de encender y los que no basados en el estado actual
	// 00 (0) -> verde, 01 (1) -> amarillo, 10 (2) -> rojo
	always @(current_state)
	begin
		case (current_state)
			2'd0:
			begin
				green = 1'b1;
				yellow = 1'b0;
				red = 1'b0;
			end
			2'd1:
			begin
				green = 1'b0;
				yellow = 1'b1;
				red = 1'b0;
			end
			2'd2, 2'd3:
			begin
				green = 1'b0;
				yellow = 1'b0;
				red = 1'b1;
			end
			default:
			begin
				green = 1'b0;
				yellow = 1'b0;
				red = 1'b0;
			end
		endcase
	end

 endmodule 


//module tb_semaforo();
//
//	reg				clk_i;
//	reg				rst_i;
//	reg				sw_green_i;
//	wire				red;
//	wire				green;
//	wire				yellow;
//	
//	
//	semaforo #(.initial_state(2'd2)) DUT (
//		.clk_i(clk_i),
//		.rst_i(rst_i),
//		.red(red),
//		.green(green),
//		.yellow(yellow)
//	);
//	
//	initial clk_i = 1'b0;
//	always #10 clk_i = ~clk_i;
//	
//	initial
//	begin
//		rst_i = 1'b0;
//		sw_green_i = 1'b0;
//		#10
//		rst_i = 1'b1;
//	end
//
//	initial #2400 $finish;
//endmodule 