module eightbitcounter(SW, KEY, HEX0, HEX1);
	input [3:0] KEY;	
	input [9:0] SW;
	output [6:0] HEX0;
	output [6:0] HEX1;
	wire [7:0] CounterValue;
	
	part1 v0(KEY[0], SW[1], SW[0], CounterValue);
	hexDecoder v1(CounterValue[0], CounterValue[1], CounterValue[2], CounterValue[3], HEX0[0], HEX0[1], HEX0[2], HEX0[3], HEX0[4], HEX0[5], HEX0[6]);
	hexDecoder v2(CounterValue[4], CounterValue[5], CounterValue[6], CounterValue[7], HEX1[0], HEX1[1], HEX1[2], HEX1[3], HEX1[4], HEX1[5], HEX1[6]);
endmodule


module part1(Clock, Enable, Clear_b, CounterValue);
	input Clock, Enable, Clear_b;

	// CounterValue is the value of the counter comprised of the Q outputs of all the TFF's
	output [7:0] CounterValue;
	wire Enable1, Enable2, Enable3, Enable4, Enable5, Enable6, Enable7;

	TFF u0(Enable, Clock, Clear_b, CounterValue[0]);
	assign Enable1 = Enable & CounterValue[0];

	TFF u1(Enable1, Clock, Clear_b, CounterValue[1]);
	assign Enable2 = Enable1 & CounterValue[1];

	TFF u2(Enable2, Clock, Clear_b, CounterValue[2]);
	assign Enable3 = Enable2 & CounterValue[2];

	TFF u3(Enable3, Clock, Clear_b, CounterValue[3]);
	assign Enable4 = Enable3 & CounterValue[3];

	TFF u4(Enable4, Clock, Clear_b, CounterValue[4]);
	assign Enable5 = Enable4 & CounterValue[4];

	TFF u5(Enable5, Clock, Clear_b, CounterValue[5]);
	assign Enable6 = Enable5 & CounterValue[5];

	TFF u6(Enable6, Clock, Clear_b, CounterValue[6]);
	assign Enable7 = Enable6 & CounterValue[6];

	TFF u7(Enable7, Clock, Clear_b, CounterValue[7]);
endmodule


module TFF(T, Clock, Clear_b, Q); // T Flip Flop
	input T, Clock, Clear_b;
	output reg Q;

	always @(posedge Clock or negedge Clear_b)
	begin
		if (!Clear_b)
			Q <= 0;
		else
			if (T)
				Q <= ~Q;
			else
				Q <= Q;
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
