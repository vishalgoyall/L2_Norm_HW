//Task to sweep through different timings on valid_en assertion and deassertion
//Creating a random number and trying to delay assertion and deassertion w.r.t. clock edge
//Design assertions will check for any issue

task valid_in_timing_check();
 int assert_dly;
 int deassert_dly;
 int rand_sel;
 int i;
 parameter timing_check_count = 1000;
 $display("\n//++++++++++++++++++++++++++++++++++++++\n// Starting Valid In Timing Check\n//++++++++++++++++++++++++++++++++++++++");
 $display("Current TimeStamp is %2d ns",$realtime);
        @(posedge clk) 
                #1 reset = 1'b1;
        @(posedge clk) 
                #1 reset = 1'b0;

        for (i = 0; i < timing_check_count; i++) begin
 	       assert_dly   = $urandom_range(9,1);
 	       deassert_dly = $urandom_range(9,1);
	       rand_sel     = $urandom_range(1,0);
 	       //$display("assert valid in = %2d ns after pos edge, deassert valid in = %2d ns after next posedge", assert_dly, deassert_dly);
 	       @(posedge clk) begin  //assertion randomization
 		       # assert_dly valid_in = 1'b1;
 		       a = $urandom_range(256,1);
 	       end
	       if (rand_sel == 0) begin                     //you can deassert in same cycle or next cycle based on assertion dly
		       if (assert_dly >= 1 && assert_dly <= 8) begin   //deassert in same cycle as assertion 
                           deassert_dly = $urandom_range(9-assert_dly,1); 
 		           # deassert_dly valid_in = 1'b0;
			   end 
		       else begin                                    //or deassert in next cycle
	        	       @(posedge clk) 
 		               # deassert_dly valid_in = 1'b0;
	               end
	       end 
	       else begin                                    //or deassert in next cycle
		       @(posedge clk) begin 
 		       # deassert_dly valid_in = 1'b0;
	               end
               end
        end 
 $display("\n//+++++++ DONE +++++++++++++++++++++++++\n");
endtask
