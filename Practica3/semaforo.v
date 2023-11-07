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
	
	// localparam opposite_count = 3'd5;
	
	// Contador hasta 120
	always @(posedge clk_i, negedge rst_i)
	begin
		if (!rst_i)
		begin
			// opposite_count = 3'd0;
			count = 7'd0;
		end
		else
			if (count == 7'd120)
				count = 7'd0;
			else
				count = count + 1;
	end
	
	// Asigna el estado siguiente dependiendo del valor de count y luego se lo asigna al estado actual
	// Si actualizada el estado actual de manera directa, me daba error.
	always @(count)
	begin
		if (count == 7'd60)
			next_state= 2'd1;
		else if (count == 7'd65)
			next_state = 2'd2;
		else if (count == 7'd120)
			next_state = 2'd0;
		else
			next_state = initial_state;
			
		current_state = next_state;
	end
	
	// Led a encender dependiendo del estado actual
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