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
	
	// Realiza el conteo hasta 120 (55 + 5 + 60) y establece el current_state a initial_state
	always @(posedge clk_i, negedge rst_i)
	begin
		if (!rst_i)
		begin
			next_state = initial_state;

			if (next_state == 2'd0)
				count = 7'd0;
			if (next_state == 2'd1)
				count = 7'd60;
			else if (next_state == 2'd2)
				count = 7'd65;
		end
		else
			if (count == 7'd119)
				count = 7'd0;
			else
				count = count + 1;
				
		current_state = next_state;
	end
	
	// Indica el estado siguiente del semaforo con respecto al estado actual y el valor actual del contador
	// 00 (0) -> verde, 01 (1) -> amarillo, 10 (2) -> rojo
	always @(current_state, count)
	begin
		if (current_state == 2'd0 && count == 7'd59)
			next_state = 2'd1;
		else if (current_state == 2'd1 && count == 7'd64)
			next_state = 2'd2;
		else if (current_state == 2'd2 && count == 7'd119)
			next_state = 2'd0;
		else
			next_state = current_state;
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
			2'd2:
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


module tb_semaforo();

	reg				clk_i;
	reg				rst_i;
	reg				sw_green_i;
	wire				red;
	wire				green;
	wire				yellow;
	
	
	semaforo #(.initial_state(2'd2)) DUT (
		.clk_i(clk_i),
		.rst_i(rst_i),
		.red(red),
		.green(green),
		.yellow(yellow)
	);
	
	initial clk_i = 1'b0;
	always #10 clk_i = ~clk_i;
	
	initial
	begin
		rst_i = 1'b0;
		sw_green_i = 1'b0;
		#10
		rst_i = 1'b1;
	end

	initial #2400 $finish;
endmodule 