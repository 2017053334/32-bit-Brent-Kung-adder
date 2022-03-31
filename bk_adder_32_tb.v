// =============================================================================
// Filename: bk_adder_32_tb.v
// -----------------------------------------------------------------------------
// This file exports the testbench for cla_64bit.
// =============================================================================

`timescale 1 ns / 1 ps

module bk_adder_32_tb;

// ----------------------------------
// Interface of the module
// ----------------------------------
reg		[31:0]	a, b;
reg 			cin;
wire 	[31:0]	sum;
wire			cout;

// ----------------------------------
// Instantiate the module
// ----------------------------------
bk_adder_32 uut (
	.a(a),
	.b(b), 
	.cin(cin), 
	.sum(sum),
	.cout(cout)
);

// ----------------------------------
// Input stimulus
// ----------------------------------
initial begin
	// Input stimulus 1: 56+78+0
	a    = 32'd5;
	b    = 32'd7;
	cin  = 1'b0;
	#10;
	$display("%0d + %0d + %0d: sum = %0d, cout = %0d", a, b, cin, sum, cout);

	// Input stimulus 2: 567+435+1
	a    = 32'd567;
	b    = 32'd435;
	cin  = 1'b1;
	#10;
	$display("%0d + %0d + %0d: sum = %0d, cout = %0d", a, b, cin, sum, cout);

	// Input stimulus 3: 38446+9354+0
	a    = 32'd38446;
	b    = 32'd9354;
	cin  = 1'b0;
	#10;
	$display("%0d + %0d + %0d: sum = %0d, cout = %0d", a, b, cin, sum, cout);

	// Input stimulus 4: 8624345+33356752+1
	a    = 32'd8624345;
	b    = 32'd33356752;
	cin  = 1'b1;
	#10;
	$display("%0d + %0d + %0d: sum = %0d, cout = %0d", a, b, cin, sum, cout);

	// Input stimulus 5: 62335808â€?+3884384+0
	a    = 32'd62335808;
	b    = 32'd3884384;
	cin  = 1'b0;
	#10;
	$display("%0d + %0d + %0d: sum = %0d, cout = %0d", a, b, cin, sum, cout);

	$finish;
end

endmodule
