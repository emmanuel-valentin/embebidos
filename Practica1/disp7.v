module disp7 (
	input			[3:0]	numero_i,
	output reg 	[6:0] disp_o
);

	always @(numero_i)
	begin
		case (numero_i)
			4'h0:
				disp_o = 7'b1000000;
			4'h1:
				disp_o = 7'b1111001;
			4'h2:
				disp_o = 7'b0100100;
			4'h3:
				disp_o = 7'b0110000;
			4'h4:
				disp_o = 7'b0011001;
			4'h5:
				disp_o = 7'b0010010;
			4'h6:
				disp_o = 7'b0000010;
			4'h7:
				disp_o = 7'b1111000;
			4'h8:
				disp_o = 7'b0000000;
			4'h9:
				disp_o = 7'b0011000;
			4'ha:
				disp_o = 7'b0001000;
			4'hb:
				disp_o = 7'b0000011;
			4'hc:
				disp_o = 7'b1000110;
			4'hd:
				disp_o = 7'b0100001;
			4'he:
				disp_o = 7'b0000110;
			4'hf:
				disp_o = 7'b0001110;
		endcase
	end

endmodule 