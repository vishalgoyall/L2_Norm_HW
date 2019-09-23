// Project 1 : Part 2 testbench
// Authors : Prateek Jain and Vishal Goyal

module tb_part2();

   logic clk, reset, valid_in, valid_out, overflow;
   logic [7:0] a;
   logic [19:0] f;

   part2 dut(.clk(clk), .reset(reset), .a(a), .valid_in(valid_in), .f(f), .valid_out(valid_out));

   initial clk = 0;
   always #5 clk = ~clk;

   // PLACE HOLDER FOR ALL TASK FILES
   `include "./tasks/reset_checks.sv"
   `include "./tasks/valid_toggle_checks.sv"
   `include "./tasks/valid_in_timing_check.sv"
   `include "./tasks/invalid_data_check.sv"
   `include "./tasks/overflow_check.sv"

   initial begin
        // Before first clock edge, initialize
        reset = 1;
        a = 0;
        valid_in = 0;

        //Remove Reset 
        @(posedge clk);
        #1; 
        reset = 0; 

        //Call Reset Checks task 
	reset_checks();

	//Call task to check for arithmetic sanity with valid and non valid data streams
	valid_toggle_checks();

	//Call task for sweeping valid in for different timings
        valid_in_timing_check();

	//Call task where only data stream is toggled but valid in is kept 0
        invalid_data_check();

	//Call task to cause overflow
        overflow_check();
	#20;
	$finish;
   end

endmodule // tb_part2_mac
