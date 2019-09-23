//Valid_In will be kept 0 and data will be toggled to see if any of the assertions fail for the design.

task invalid_data_check (); 
int i;
 $display("\n//++++++++++++++++++++++++++++++++++++++\n// Starting Invalid data Timing Check\n//++++++++++++++++++++++++++++++++++++++");
 $display("Current TimeStamp is %2d ns",$realtime); 
        @(posedge clk) 
                #1 reset = 1'b1;

	for(i = 0; i < 30; i++) begin
		@(posedge clk) begin
			#1 
			reset = 1'b0;
			valid_in = 1'b0;
			a = $urandom_range(256,1);
		end
	end
	@ (posedge clk) assert (f == 0) $display("Invalid Data not being processed by design"); else $error("Invalid data being processed by design!!");

 $display("\n//+++++++ DONE +++++++++++++++++++++++++\n");

endtask
