task overflow_check();
	logic [19:0] out_data_old, out_data_new;

	@(posedge clk) begin
		out_data_new <= (valid_out == 1'b1) ? f : out_data_new;
		out_data_old <= (reset == 1'b1) ? 'b0 : ((valid_out == 1'b1) ? out_data_new : out_data_old);
		if (out_data_old > out_data_new) begin
			$warning("output data overflow happened while accumulating squared inputs with data being %x and %x", out_data_old, out_data_new);
		end
	end

endtask
