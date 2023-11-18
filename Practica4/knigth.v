module knigth (
	input clk_i,
	input rst_i,
	output reg [7:0] leds_o 
);

	reg current_state;
	reg next_state;
	
	reg [7:0] leds_aux = 8'b00000001;

	always @(posedge clk_i, negedge rst_i)
	begin
		if (!rst_i)
		begin
			leds_o = 8'b00000001;
			current_state = 1'b0;
		end
		else
		begin
			current_state = next_state;
			leds_o = leds_aux;
			
			if (current_state == 1'b0)
				leds_aux = leds_aux << 1;
			else
				leds_aux = leds_aux >> 1;
		end
	end
	
	always @(current_state, leds_o)
	begin
		case (current_state)
			1'b0:
				if (leds_aux == 8'b01000000)
					next_state = 1'b1;
				else
				begin
					next_state = current_state;
				end	
			1'b1:
				if (leds_aux == 8'b00000010)
					next_state = 1'b0;
				else
				begin
					next_state = current_state;
				end
		endcase
	end

endmodule 