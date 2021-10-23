module eightbitreg(SW, KEY, LEDR, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
	input [9:0]SW;
	input [3:0]KEY;
	output [9:0]LEDR;
	output [6:0]HEX0;
	output [6:0]HEX1;
	output [6:0]HEX2;
	output [6:0]HEX3;
	output [6:0]HEX4;
	output [6:0]HEX5;

	wire Clock;
	assign Clock = KEY[0];
	wire [3:0] Data;
	assign Data[3:0] = SW[3:0];
	wire Reset_b;
	assign Reset_b = SW[9];
	wire [2:0] Function;
	assign Function[2:0] = KEY[3:1];
	wire [7:0] ALUout;

	part2 u0(Clock, Reset_b, Data, Function, ALUout);
	
	assign HEX0 = Data;
	assign HEX1 = 0;
	assign HEX2 = 0;
	assign HEX3 = 0;
	
	// Pass ALUout through the Hex Decoder for HEX4 and HEX5
	hexDecoder u1(ALUout[0], ALUout[1], ALUout[2], ALUout[3],HEX4[0],HEX4[1],HEX4[2],HEX4[3],HEX4[4],HEX4[5],HEX4[6]);
	hexDecoder u2(ALUout[4], ALUout[5], ALUout[6], ALUout[7],HEX5[0],HEX5[1],HEX5[2],HEX5[3],HEX5[4],HEX5[5],HEX5[6]);
endmodule


module part2(Clock, Reset_b, Data, Function, ALUout);
	input Clock;
	input Reset_b;
	input [3:0] Data;
	input [2:0] Function;
	output reg [7:0] ALUout;
	reg [7:0] ALU; // Temporarily stores ALU value before being assigned at posedge
	reg [3:0] A;
	reg [3:0] B;
	wire [3:0] s;
	wire c_out;
	wire [7:0] sum;
	fourbitadder v0(
		.a(Data), 
		.b(B), 
		.c_in(1'b0), 
		.s(s), 
		.c_out(c_out)
	);
	
	assign sum = {3'b000, c_out, s};

	always @(posedge Clock)
	begin
		if (Reset_b == 1'b0)
			ALUout <= 8'b00000000; // Resets
		else
			ALUout <= ALU;
	end

	always @(*)
	begin
		A[3:0] = Data[3:0];
		B[3:0] = ALUout[3:0];
		case(Function)
			3'b000:
				ALU = sum;
			3'b001:
				ALU = A + B;
			3'b010:
			begin
			if (ALUout[3] == 1)
				ALU = {4'b1111, B};
			else
				ALU = {4'b0000, B};
			end
			3'b011:
				ALU = {7'b0000000, |{Data, B}};
			3'b100:
				ALU = {7'b0000000, &{Data, B}};
			3'b101:
				ALU = B << A; // Shift B left by A bits, pad B first
			3'b110:
				ALU = A * B; // Multiply via * operator
			3'b111:
				ALU = ALUout;
				
			default:
				ALU = 8'b00000000; 
		endcase
	end	
endmodule	
		

module hexDecoder(d, c, b, a, s0, s1, s2, s3, s4, s5, s6);
	input a, b, c, d;
	output s0, s1, s2, s3, s4, s5, s6;
	assign s0 = (a & b & ~c & d) || (a & ~b & c & d) || (~a & b & ~c & ~d) || (~a & ~b & ~c & d);
	assign s1 = (a & b & ~d) || (a & c & d) || (~a & b & ~c & d) || (b & c & ~d);
	assign s2 = (a & b & c) || (a & b & ~d) || (~a & ~b & c & ~d);
	assign s3 = (a & ~b & c & ~d) || (~a & b & ~c & ~d) || (b & c & d) || (~a & ~b & ~c & d);
	assign s4 = (~a & b & ~c) || (~a & d) || (~b & ~c & d);
	assign s5 = (a & b & ~c & d) || (~a & ~b & c) || (~a & ~b & d) || (~a & c & d);
	assign s6 = (a & b & ~c & ~d) || (~a & b & c & d) || (~a & ~b & ~c);
endmodule


module fourbitadder(a, b, c_in, s, c_out);
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
	input a, b, c_in;
	output s, c_out;
	assign s = a ^ b ^ c_in; // ^ is XOR
	assign c_out = (a&b) | (a&c_in) | (b&c_in);
endmodule