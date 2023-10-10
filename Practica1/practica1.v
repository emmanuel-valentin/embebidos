module practica1 (
	input		[5:0]		a_i,
	input		[5:0]		b_i,
	input		[2:0]		seleccion_i,
// Por defecto son wires
//	output	[11:0]	res_o
	output	[6:0]		disp0,
	output	[6:0]		disp1,
	output	[6:0]		disp2
);

	// Si siempre una variable está dentro de un always
	// hay que ponerle un wire
	reg		[11:0]	res_o;

	always @(a_i, b_i, seleccion_i)
	begin
		case (seleccion_i)
				3'b000:
					res_o = a_i + b_i;
				3'b001:
					res_o = a_i - b_i;
				3'b010:
					res_o = a_i * b_i;
				3'b011:
					res_o = a_i | b_i;
				3'b100:
					res_o = a_i & b_i;
				3'b101:
					res_o = a_i >> b_i;
				3'b110:
					res_o = a_i << b_i;
				3'b111:
					res_o = a_i ^ b_i;
		endcase
	end
	
	// Instancias del display
	
	disp7 display0 (
		.numero_i	(res_o[3:0]),
		.disp_o		(disp0)
	);
	
	disp7 display1 (
		.numero_i	(res_o[7:4]),
		.disp_o		(disp1)
	);
	
	disp7 display2 (
		.numero_i	(res_o[11:8]),
		.disp_o		(disp2)
	);

endmodule 

module practica1_tb(); // Primer paso

	// Segundo paso: input -> reg / output -> wire
	reg		[5:0]		a_i;
	reg		[5:0]		b_i;
	reg		[2:0]		seleccion_i;
	wire		[6:0]		disp0;
	wire		[6:0]		disp1;
	wire		[6:0]		disp2;

	// reg	clk_i;
	
	// Tercer paso: Dar valores iniciales a las señales de entrada
	initial
	begin
		a_i = 6'b0;
		b_i = 6'b0;
		// clk_i = 1'b1;
		seleccion_i = 3'b0;
	end
	
	// Cuarto paso: Hacer una instancia del modulo a probrar
	
	practica1 DUT(
		.a_i (a_i),				
		.b_i (b_i), 
		.seleccion_i (seleccion_i),
		.disp0 (disp0),
		.disp1 (disp1),
		.disp2 (disp2)
	);
	
	// Quinto paso: Cambiar los valores
	
//	always
//	begin
//		#50
//			clk_i = ~clk_i;
//	end
	
	always
	begin
		#100
			a_i = 6'hA;
			b_i = 6'hB;
			seleccion_i = 3'b0;
		#100
			a_i = 6'hA;
			b_i = 6'hB;
			seleccion_i = 3'b1;
		#100
			a_i = 6'hA;
			b_i = 6'hB;
			seleccion_i = 3'b10;
	end
endmodule 