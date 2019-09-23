//Task to sweep through different timings on valid_en assertion and deassertion
//Creating a random number and trying to delay assertion and deassertion w.r.t. clock edge
//Design assertions will check for any issue

task valid_in_timing_check();
 int assert_dly;
 int deassert_dly;
 int i;
 $display("\n//++++++++++++++++++++++++++++++++++++++\n// Starting Valid In Timing Check\n//++++++++++++++++++++++++++++++++++++++");
 $display("Current TimeStamp is %2d ns",$realtime);
        @(posedge clk) 
                #1 reset = 1'b1;
        @(posedge clk) 
                #1 reset = 1'b0;

        for (i = 0; i < 99; i++) begin
 	       assert_dly   = $urandom_range(9,1);
 	       deassert_dly = $urandom_range(9,1);
 	       //$display("assert valid in = %2d ns after pos edge, deassert valid in = %2d ns after next posedge", assert_dly, deassert_dly);
 	       @(posedge clk) begin  //assertion randomization
		       //$display("Current TimeStamp is %2d ns",$realtime);
 		       # assert_dly valid_in = 1'b1;
 		       a = $urandom_range(256,1);
 	       end
 	       @(posedge clk) begin //deassertion randomization
		       //$display("Current TimeStamp is %2d ns",$realtime);
 		       # deassert_dly valid_in = 1'b0;
 	       end
        end 
 $display("\n//+++++++ DONE +++++++++++++++++++++++++\n");
endtask
