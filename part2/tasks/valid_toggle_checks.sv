//TEST 1c
//Arithmetic Checks: Give multiple valid data and check for arithmetic correctness for simulated vs expected output
task valid_toggle_checks;

   int i;
   int indata, outdata, validin;
   int ifh, ofh;

   ifh=$fopen("./inputDataPart2", "r");
   ofh=$fopen("./expectedOutputPart2", "r");

	$display("\n//++++++++++++++++++++++++++++++++++++++\n// Starting Arithmetic Checks with random valid_in\n//++++++++++++++++++++++++++++++++++++++\n");
	$display("Current TimeStamp is %2d ns",$realtime);
      // Before first clock edge, initialize
      @(posedge clk);
      #1;
      reset = 1;
      a = 0;
      valid_in = 0;
      error_count = 0;

      @(posedge clk);
      #1; // After 1 posedge
      reset = 0; a = 10; valid_in = 0;
      
      for (i = 0; i < 10050; i++) begin
	      @(posedge clk);
	      $fscanf(ifh,"%h\n", indata);
	      $fscanf(ifh,"%h\n", validin);
	      $fscanf(ofh,"%h\n", outdata);
	      #1;
      	       valid_in = validin[0];
	       a = indata[7:0];

	      assert (f == outdata[19:0]) 
	      else begin
		      $error("mismatch in actual output data %x and expected output data %x", f, outdata);
			error_count++;
		end
      end

 $display("\n// Errors found in valid toggle test = %5d\n", error_count);
 $display("\n//+++++++ DONE +++++++++++++++++++++++++\n");
endtask
