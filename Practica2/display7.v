module display7 (
	input			[3:0]	numero_i,
	output reg 	[6:0] disp_o
);

	always @(numero_i)
	begin
		case (numero_i)
			4'h0:
				disp_o = 7'b0001110; // F
			4'h1:
				disp_o = 7'b0001100; // P
			4'h2:
				disp_o = 7'b0000010; // G
			4'h3:
				disp_o = 7'b0001000; // A
			default:
				disp_o = 7'b1111111; // Todos apagados
		endcase
	end

endmodule 