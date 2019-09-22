// Module to take input bytes, square them and add them
// Authors: Vishal Goyal, Prateek Jain
// 

module part3 (
	input clk,
	input reset,
	input [7:0] a,
	input valid_in,
	
	output logic [9:0] g,
	output logic valid_out
);

logic enable_a;
logic enable_f;
logic enable_g;
logic enable_out;

// Control Unit
assign enable_a = valid_in; // latching inputs as soon as valid_in is high
always_ff @ (posedge clk)
begin : control_block
	if (reset) begin
		enable_f   <= 1'b0;
		enable_g   <= 1'b0;
		enable_out <= 1'b0;
	end else begin
		enable_f   <= enable_a; // registering accum output one cycle after input has been received
		enable_g   <= enable_f; // registering square root value one cycle after accum value was registered
		enable_out <= enable_g; // enabling valid out in the next cycle of square root
	end
end : control_block
assign valid_out = enable_out;


// Registering input values in flops
logic [7:0] a_reg;
always_ff @ (posedge clk)
begin : input_register
	if (reset) begin
		a_reg <= 8'd0;
	end else if (enable_a) begin
		a_reg <= a;
	end
end : input_register

// Squaring and adding registered input values
logic [15:0] a_squared;
logic [19:0] accumulation;
logic [19:0] f;

assign a_squared = a_reg * a_reg;
assign accumulation = f + {4'b0,a_squared};

// Registering accumulated output to be sent for square root
always_ff @ (posedge clk) 
begin : f_register
	if (reset) begin
		f <= 20'd0;
	end else if (enable_f) begin
		f <= accumulation;
	end
end : f_register

// Square root of the accum registered value
logic [9:0] f_root;
DW_sqrt #(20) sqrtinstance(.a(f), .root(f_root));

// Registering square root value to be sent to the output port
always_ff @ (posedge clk)
begin : output_register
	if (reset) begin
		g <= 10'd0;
	end else if (enable_g) begin
		g <= f_root;
	end
end : output_register

endmodule
