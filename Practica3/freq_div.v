module freq_div(
	input					clk_i,
	input					rst_i,
	input		[1:0]		freq_i,
	output	reg		clk_div
);

	reg	[25:0] 	count;
	reg	[25:0]	limit;
	
	always @(freq_i)
	begin
		case (freq_i)
			4'h0:
				limit = 26'd49_999_999;
			4'h1:
				limit = 26'd24_999_999;
			4'h2:
				limit = 26'd12_499_999;
			4'h3:
				limit = 26'd6_249_999;
			default:
				limit = 26'd49_999_999;
		endcase
	end
	
	always @(posedge clk_i, negedge rst_i)
	begin
		if (!rst_i)
		begin
			count = 26'b0;
			clk_div = 1'b0;
		end
		else
			if (count == limit) 
			begin
				count = 26'b0;
				clk_div = ~clk_div;
			end
			else
				count = count + 1;
	end

endmodule 