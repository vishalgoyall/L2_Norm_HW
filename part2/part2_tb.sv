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

   initial begin
	//arith_checks(); // Commenting this check out as this is already a part of the next one
	valid_toggle_checks();
	reset_checks();
	#20;
	$finish;
   end

   logic [19:0] out_data_old, out_data_new;
   always @(posedge clk) begin
	   out_data_new <= (valid_out == 1) ? f : out_data_new;
	   out_data_old <= (reset == 1) ? 'b0 : ((valid_out == 1) ? out_data_new : out_data_old);
   end

   //initial begin
   //     overflow_check();
   //end // initial begin overflow test

endmodule // tb_part2_mac
