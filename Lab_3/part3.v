/*
module mux(LEDR, SW, KEY, HEX0);
    input [9:0] SW;
    input [2:0] KEY;
    output [9:0] LEDR;
    output [6:0] HEX0;

    part3 u0(
        .A(SW[7:4]),
        .B(SW[3:0]),
        .Function(KEY[2:0]),
	.ALUout(LEDR[7:0])
        );
	 
	 assign HEX0[0] = B;
	 assign HEX0[2] = A;
	 assign HEX0[1] = 0;
	 assign HEX0[3] = 0;
	 assign HEX0[4] = ALUout[3:0];
	 assign HEX0[5] = ALUout[7:4];
endmodule
*/ 

module part3(A, B, Function, ALUout);
	input [3:0] A;
	input [3:0] B;
	input [2:0] Function;
	output reg [7:0] ALUout;

	wire [3:0] s;
	wire c_out;
	wire [7:0] sum;
	part2 u0(A, B, 1'b0, s, c_out);
	assign sum = {3'b000, c_out, s}; // Append 3 0's to make 5-bit an 8-bit
	
	always @(*)
	begin
		case (Function)
			3'b000: ALUout = sum;
			3'b001: ALUout = A + B;
			3'b010: 
			begin
			if (B[3]==1)
				ALUout = {4'b1111, B};
			else
				ALUout = {4'b0000, B};
			end
			3'b011: ALUout = {7'b0000000, |{A, B}};
			3'b100: ALUout = {7'b0000000, &{A, B}};
			3'b101: ALUout = {A, B};
			default: ALUout = 8'b00000000;
		endcase
	end
endmodule


module part2(a, b, c_in, s, c_out);
	// This is a four-bit ripple-carry adder
	input [3:0] a;
	input [3:0] b;
	input c_in;
	output [3:0] s;
	output c_out;
	wire c1, c2, c3;
	
	full_adder u0(
		.a(a[0]),
		.b(b[0]),
		.c_in(c_in),
		.s(s[0]),
		.c_out(c1)
		);
	
	full_adder u1(
		.a(a[1]),
		.b(b[1]),
		.c_in(c1),
		.s(s[1]),
		.c_out(c2)
		);
	
	full_adder u2(
		.a(a[2]),
		.b(b[2]),
		.c_in(c2),
		.s(s[2]),
		.c_out(c3)
		);
	
	full_adder u3(
		.a(a[3]),
		.b(b[3]),
		.c_in(c3),
		.s(s[3]),
		.c_out(c_out)
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
