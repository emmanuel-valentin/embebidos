module freq_div(
	input					clk_i,
	input					rst_i,
	output	reg		clk_div
);

	reg	[31:0] 	count;
	
	always @(posedge clk_i, negedge rst_i)
	begin
		if (!rst_i)
		begin
			count = 32'd0;
			clk_div = 1'b0;
		end
		else
			if (count == 32'd6_999_999)
			begin
				count = 32'd0;
				clk_div = ~clk_div;
			end
			else
				count = count + 1;
	end

endmodule 