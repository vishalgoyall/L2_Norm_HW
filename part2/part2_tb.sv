// This is a very small testbench for you to check that you have the right
// idea for the input/output timing.

// 
// 

module tb_part2();

   logic clk, reset, valid_in, valid_out, overflow;
   logic [7:0] a;
   logic [19:0] f;

   part2 dut(.clk(clk), .reset(reset), .a(a), .valid_in(valid_in), .f(f), .valid_out(valid_out));

   initial clk = 0;
   always #5 clk = ~clk;

   // PLACE HOLDER FOR ALL TASK FILES
   `include "./tasks/reset_checks.sv"
   `include "./tasks/arith_checks.sv"
   `include "./tasks/valid_toggle_checks.sv"
   `include "./tasks/overflow_check.sv"

   initial begin
	//arith_checks(); // Commenting this check out as this is already a part of the next one
	valid_toggle_checks();
	reset_checks();
        overflow_check();
	#20;
	$finish;
   end

endmodule // tb_part2_mac
