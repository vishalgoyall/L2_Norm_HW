//Following Test is done to check thoroughness of reset along with other input control params like clock and valid_en

 //TEST 	 
 //Back to Back reset check : Reset to be checked for all events where an enable for flop has to be generated
 //Cases : 
 //1. Reset 1 and Valid En 0->1
 //2. Reset 1 and Enable_a 0->1
 //3. Reset 1 and Enable_f 0->1
 //4. Reset 1 and Enable_g 0->1
 //5. Reset 1 and Enable_g 1
 //6. Valid data and Reset 1 for B2B 2 Valid data clocks

task reset_checks;
 int i;
 int j;
$display("\n//++++++++++++++++++++++++++++++++++++++\n// Starting Reset Checks\n//++++++++++++++++++++++++++++++++++++++");
 
 //Design asserts will fail if reset is not working correctly
	 for(i=0; i<6; i++) begin
		 for(j=0; j<i+1; j++) begin
			 @(posedge clk);
			 #1 reset = 1'b0;
			 a = $urandom_range(256,1);
		 end
		 #1 valid_in = 1'b1;
		 reset = 1'b1;
		 if (i==5) begin
			 @(posedge clk);
			 @(posedge clk)
			 # 1 reset = 1'b0;
		 end
	 end
	 
$display("\n//+++++++ DONE +++++++++++++++++++++++++\n");

endtask

