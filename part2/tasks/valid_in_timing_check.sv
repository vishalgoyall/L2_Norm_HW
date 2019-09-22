//Task to sweep through different timings on valid_en assertion and deassertion
//Creating a random number and trying to delay assertion and deassertion w.r.t. clock edge
//Design assertions will check for any issue

task valid_in_timing_checks();
       for (int i = 0; i < 99; i++) begin
	       @(posedge clk) begin  //assertion randomization
		       #($urandom_range(95,5)*100ps) valid_in = 1'b1;
		       valid_data = $urandom_range(256,1);
	       end
	       @(posedge clk) begin //deassertion randomization
		       #($urandom_range(95,5)*100ps) valid_in = 1'b0;
	       end
       end 
endtask
