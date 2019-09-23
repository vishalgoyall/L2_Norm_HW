//Following Test is done to check thoroughness of reset along with other input control params like clock and valid_en

task reset_checks;
$display("\n//++++++++++++++++++++++++++++++++++++++\n// Starting Reset Checks\n//++++++++++++++++++++++++++++++++++++++");
$display("Current TimeStamp is %2d ns",$realtime); 
 //TEST 	 
 //Back to Back reset check : Reset to be checked for all possible values of Valid IN along with reset signal
 //Sequence will be  Valid EN = 1 -> Reset ->  Valid EN = 1 -> Reset & Valid EN = 0 -> Valid En = 0 -> Reset & Valid En = 1 -> Valid EN = 1  
 //Design asserts will fail if reset is not working correctly
 @(posedge clk)
 #1
 valid_in = 1'b1;
 a = 8'd3;
 @(posedge clk)
 #1
 valid_in = 1'b1;
 a = 8'd5;
 reset = 1'b1;
 @(posedge clk)
 #1
 valid_in = 1'b1;
 a = 8'd9;
 reset = 1'b0;
 @(posedge clk)
 #1
 valid_in = 1'b0;
 a = 8'd6;
 reset = 1'b1;
 @(posedge clk)
 #1
 reset = 1'b0;
 @(posedge clk)
 #1
 reset = 1'b1;
 valid_in = 1'b1;
 a = 8'd4;
 @(posedge clk)
 #1
 reset = 1'b0;
 valid_in = 1'b1;
 @(posedge clk)
 #1
 valid_in = 1'b1;
 a = 8'd10;
$display("\n//+++++++ DONE +++++++++++++++++++++++++\n");

endtask

