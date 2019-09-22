// Module to take input bytes, square them and add them
// Authors: Vishal Goyal, Prateek Jain
// 

module part2 (
	input clk,
	input reset,
	input [7:0] a,
	input valid_in,
	
	output logic [19:0] f,
	output logic valid_out
);

logic enable_a;
logic enable_f;
logic enable_out;

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//Control Unit
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
assign enable_a = valid_in; // latching inputs as soon as valid_in is high
always_ff @ (posedge clk)
begin : control_block
	if (reset) begin
		enable_f   <= 1'b0;
		enable_out <= 1'b0;
	end else begin
		enable_f   <= enable_a; // registering accum output one cycle after input has been received
		enable_out <= enable_f; // enabling valid out in the next cycle of accum registering
	end
end : control_block
assign valid_out = enable_out;

//Assertions
//1. Sync reset check
     assert property (@(posedge clk) reset |=> (enable_f == 0)) else $error ("Sync reset not applied of flop enable_f");
     assert property (@(posedge clk) reset |=> (enable_out == 0)) else $error ("Sync reset not applied of flop enable_out");
//2. EN to accum to change 1 clock after valid_in signal
     assert property (@(posedge clk) (valid_in && !reset) |-> ##1 enable_f) else $error ("Accumulator not getting updated at correct clock edge");
//3. Valid out to change 2 clocks after valid_in signal
     assert property (@(posedge clk) (valid_in && !reset) |-> ##1 !reset |-> ##1 valid_out) else $error ("Valid out not coming 2 clocks after valid_in");

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// Registering input values in flops
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
logic [7:0] a_reg;


always_ff @ (posedge clk)
begin : input_register
	if (reset) begin
		a_reg <= 8'd0;
	end else if (enable_a) begin
		a_reg <= a;
	end
end : input_register

//Assertions
//1. To check for sync reset
     assert property (@(posedge clk) reset |=> (a_reg == 0)) else $error ("Sync reset not applied on flop a_reg");

//2. To check for data getting updated on valid input only
     assert property 
       (@(posedge clk) ##1 ($past(valid_in) && $past(!reset)) |-> (a_reg == $past(a))) 
     else $error ("Data not getting updated for valid input"); 

//3. To catch if data gets latched on invalid input as well
     assert property 
       (@(posedge clk) ##1 ($past(!valid_in) && $past(!reset)) |-> (a_reg == $past(a_reg) or $isunknown($past(a_reg)))) 
     else $error ("Data getting updated for invalid input"); 

     
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// Square and Addition
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++	
// Squaring and adding registered input values
logic [15:0] a_squared;
logic [19:0] accumulation;

assign a_squared = a_reg * a_reg;
assign accumulation = f + {4'b0,a_squared};

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// Registering accumulated output to be sent on the output port
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
always_ff @ (posedge clk) 
begin : output_register
	if (reset) begin
		f <= 20'd0;
	end else if (enable_f) begin
		f <= accumulation;
	end
end : output_register

//Assertions
//1. To check for sync reset
     assert property (@(posedge clk) reset |=> (f == 0)) else $error ("Sync reset not applied on flop f");

//2. To check for data getting updated on valid input only
     assert property
       (@(posedge clk) ##1 ($past(enable_f) && $past(!reset)) |-> (f == $past(accumulation))) 
     else $error ("Data not getting updated for valid input"); 

//3. To catch if data gets latched on invalid input as well
     assert property 
       (@(posedge clk) ##1 ($past(!enable_f)&& $past(!reset)) |-> (f == $past(f)) or ($isunknown($past(f)))) 
     else $error ("Accum getting updated for invalid input"); 
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

 //Assertion to check against async reset on flops
   always@(posedge reset) begin
   #1 assert ((a_reg == $past(a_reg)) || $isunknown($past(a_reg))) else $error ("Looks like async reset has happened for flop a_reg");
   #1 assert ((enable_f == $past(enable_f)) || $isunknown($past(enable_f))) else $error ("Looks like async reset has happened for flop enable_f");
   #1 assert ((enable_out == $past(enable_out)) || $isunknown($past(enable_out))) else $error ("Looks like async reset has happened for flop enable_out");
   #1 assert ((f == $past(f)) || $isunknown($past(f))) else $error ("Looks like async reset has happened for flop f");
 end

endmodule
