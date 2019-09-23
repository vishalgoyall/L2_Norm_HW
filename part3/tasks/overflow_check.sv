task overflow_check();
	logic [9:0] out_data_old;
	logic [9:0] out_data_new;

   int i;

	$display("\n//++++++++++++++++++++++++++++++++++++++\n// Starting Overflow Checks \n//++++++++++++++++++++++++++++++++++++++\n");
	// Before first clock edge, initialize
	reset = 1;
	a = 0;
	valid_in = 0;
	out_data_old = 0;
	out_data_new = 0;
	reset = 0;
	
	for (i = 0; i < 30; i++) begin
		@(posedge clk);
		#1;
      		assign valid_in = 1;
		assign a = 8'hff;

		out_data_new <= (valid_out == 1'b1) ? g : out_data_new;
		out_data_old <= (reset == 1'b1) ? 'b0 : ((valid_out == 1'b1) ? out_data_new : out_data_old);
		$display("old data is %x , new data is %x", out_data_old , out_data_new);
		if (out_data_old > out_data_new) begin
			$warning("output data overflow happened while accumulating squared inputs with output data being %x and %x", out_data_old, out_data_new);
		end
	end

endtask
