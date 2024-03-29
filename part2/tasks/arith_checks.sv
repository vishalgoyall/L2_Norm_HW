//TEST 1c
//Arithmetic Checks: Give multiple valid data and check for arithmetic correctness for simulated vs expected output
task arith_checks;

   int i;
   int indata, outdata;
   int ifh, ofh;

   ifh=$fopen("./inputDataPart2", "r");
   ofh=$fopen("./expectedOutputPart2", "r");

	$display("\n//++++++++++++++++++++++++++++++++++++++\n// Starting Arithmetic Checks with valid_in tied to 1\n//++++++++++++++++++++++++++++++++++++++");
      // Before first clock edge, initialize
      reset = 1;
      a = 0;
      valid_in = 0;

      @(posedge clk);
      #1; // After 1 posedge
      reset = 0; a = 10; valid_in = 0;
      
      for (i = 0; i < 100; i++) begin
	      @(posedge clk);
	      $fscanf(ifh,"%h\n", indata);
	      $fscanf(ofh,"%h\n", outdata);
	      #1;
      	       valid_in = 1;
	       a = indata[7:0];

	      assert (f == outdata[19:0]) 
	      	      $display("actual output %x and expected output %x match", f, outdata); 
	      else
		      $error("mismatch in actual output data %x and expected output data %x", f, outdata);
      end

endtask

