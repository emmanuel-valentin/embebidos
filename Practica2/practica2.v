module practica2(
	input		[1:0]		sw,
	input		[1:0]		sw_freq,
	input					clk_i,
	input					rst_i,
	output	[6:0]		disp0,
	output	[6:0]		disp1,
	output	[6:0]		disp2,
	output	[6:0]		disp3,
	output	[6:0]		disp4,
	output	[6:0]		disp5,
	output	[6:0]		disp6,
	output	[6:0]		disp7
);

	wire					clk_div;
	reg 		[31:0]	msg_o;
	
	initial begin
		msg_o = 32'b00000001001000111111111111111111;
	end
	
	always @(posedge clk_div)
	begin
		case (sw)
			2'b01:
				msg_o = {msg_o[27:0], msg_o[31:28]};
			2'b10:
				msg_o = {msg_o[3:0], msg_o[31:4]};
			default:
				msg_o = msg_o;
		endcase
	end

	freq_div div(
		.clk_i	(clk_i),
		.rst_i	(rst_i),
		.clk_div	(clk_div),
		.freq_i (sw_freq),
	);

	display7 display7 (
		.numero_i(msg_o[31:28]),
		.disp_o(disp7)
	);
	
	display7 display6 (
		.numero_i(msg_o[27:24]),
		.disp_o(disp6)
	);
	
	display7 display5 (
		.numero_i(msg_o[23:20]),
		.disp_o(disp5)
	);
	
	display7 display4 (
		.numero_i(msg_o[19:16]),
		.disp_o(disp4)
	);
	
	display7 display3 (
		.numero_i(msg_o[15:12]),
		.disp_o(disp3)
	);
	
	display7 display2 (
		.numero_i(msg_o[11:8]),
		.disp_o(disp2)
	);
	
	display7 display1 (
		.numero_i(msg_o[7:4]),
		.disp_o(disp1)
	);
	
	display7 display0 (
		.numero_i(msg_o[3:0]),
		.disp_o(disp0)
	);

endmodule 