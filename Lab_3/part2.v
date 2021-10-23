module mux(LEDR, SW);
    input [9:0] SW;
    output [9:0] LEDR;

    part2 u0(
        .a(SW[7:4]),
        .b(SW[3:0]),
        .c_in(SW[8]),
	.s(LEDR[3:0]),
	.c_out(LEDR[9:6])
        );
    assign LEDR[8] = 0;
    assign LEDR[7] = 0;
    assign LEDR[6] = 0;
endmodule


module part2(a, b, c_in, s, c_out);
	// This is a four-bit ripple-carry adder
	input [3:0] a;
	input [3:0] b;
	input c_in;
	output [3:0] s;
	output [3:0] c_out; 
	
	full_adder u0(
		.a(a[0]),
		.b(b[0]),
		.c_in(c_in),
		.s(s[0]),
		.c_out(c_out[0])
		);
	
	full_adder u1(
		.a(a[1]),
		.b(b[1]),
		.c_in(c_out[0]),
		.s(s[1]),
		.c_out(c_out[1])
		);
	
	full_adder u2(
		.a(a[2]),
		.b(b[2]),
		.c_in(c_out[1]),
		.s(s[2]),
		.c_out(c_out[2])
		);
	
	full_adder u3(
		.a(a[3]),
		.b(b[3]),
		.c_in(c_out[2]),
		.s(s[3]),
		.c_out(c_out[3])
		);

endmodule


module full_adder(a, b, c_in, s, c_out);
	// This will be instantiated four times
	input a;
	input b;
	input c_in;
	output s;
	output c_out;
	assign s = a ^ b ^ c_in; // ^ is XOR
	assign c_out = (a&b) | (a&c_in) | (b&c_in);
endmodule
	
