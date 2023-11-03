module semaforo (
	input				clk_i,
	output reg		red,
	output reg		green,
	output reg		yellow
);

	reg  [1:0]		led_on;
	reg  [5:0]		count;
	
	initial begin
 		count = 6'd0;
		green = 1'b1;
		yellow = 1'b0;
		red = 1'b0;
	end
	
	always @(posedge clk_i)
	begin
		case (led_on)
			1'b00: // La luz verde esta encendida
				if (count == 6'd60)
				begin
					led_on = 1'b01;
					green = 1'b0;
					yellow = 1'b1;
					red = 1'b0;
					count = 6'd0;
				end
				else
					count = count + 1;
			2'b01: // la luz amarilla esta encendida
				if (count == 6'd5)
				begin
					led_on = 1'b11;
					green = 1'b0;
					yellow = 1'b0;
					red = 1'b1;
					count = 6'd0;
				end
				else
					count = count + 1;
			3'b10:
				if (count == 6'd55)
				begin
					led_on = 1'b11;
					green = 1'b1;
					yellow = 1'b0;
					red = 1'b0;
					count = 6'd0;
				end
				else
					count = count + 1;
			default:
				led_on = 1'b00;
		endcase
	end
		
endmodule 