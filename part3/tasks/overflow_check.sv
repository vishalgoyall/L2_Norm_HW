task overflow_check();
	logic [19:0] out_data_old, out_data_new;

   int i;
   int indata, outdata, validin;
   int ifh, ofh;

   ifh=$fopen("./inputDataPart3", "r");
   ofh=$fopen("./expectedOutputPart3", "r");

	$display("\n//++++++++++++++++++++++++++++++++++++++\n// Starting Overflow Checks \n//++++++++++++++++++++++++++++++++++++++\n");
	// Before first clock edge, initialize
	reset = 1;
	a = 0;
	valid_in = 0;
	reset = 0;
	
	for (i = 0; i < 80; i++) begin
		@(posedge clk);
		$fscanf(ifh,"%h\n", indata);
		$fscanf(ifh,"%h\n", validin);
		$fscanf(ofh,"%h\n", outdata);
		#1;
      		assign valid_in = 1; // fixing valid always 1 to hit overflow faster
		assign a = indata[7:0];

		out_data_new <= (valid_out == 1'b1) ? g : out_data_new;
		out_data_old <= (reset == 1'b1) ? 'b0 : ((valid_out == 1'b1) ? out_data_new : out_data_old);
		$display("old data is %x , new data is %x", out_data_old , out_data_new);
		if (out_data_old > out_data_new) begin
			$warning("output data overflow happened while accumulating squared inputs with data being %x and %x", out_data_old, out_data_new);
		end
	end

endtask
