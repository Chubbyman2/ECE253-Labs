module eightbitcounter_ratedivider(SW, CLOCK_50, HEX0);
	input [9:0] SW;
	input CLOCK_50;
	output [6:0] HEX0;
	wire [1:0] Speed;
	assign Speed[1:0] = SW[1:0];
	wire [3:0] CounterValue;
	part2 u0(CLOCK_50, SW[9], Speed, CounterValue);

	hexdecoder u1(CounterValue[0], CounterValue[1], CounterValue[2], CounterValue[3], HEX0[0], HEX0[1], HEX0[2], HEX0[3], HEX0[4], HEX0[5], HEX0[6]);
endmodule

module part2(ClockIn, Reset, Speed, CounterValue);
	input ClockIn, Reset;
	input [1:0] Speed;
	output reg [3:0] CounterValue;
	reg [31:0] RateDivider;
	wire Enable;
	assign Enable = (RateDivider == 0)?1:0;

	always @(posedge ClockIn)
	begin
		RateDivider <= RateDivider - 1;
		if (Speed == 2'b00)
			RateDivider <= 0;
		else if ((Speed == 2'b01) & ((RateDivider == 0) | (RateDivider > 499)))
			RateDivider <= 499;
		else if ((Speed == 2'b10) & ((RateDivider == 0) | (RateDivider > 999)))
			RateDivider <= 999;
		else if ((Speed == 2'b11) & ((RateDivider == 0) | (RateDivider > 1999)))
			RateDivider <= 1999;
		if (Reset == 1'b1)
			CounterValue <= 4'b0000;
		else if (CounterValue == 4'b1111)
			CounterValue <= 4'b0000;
		else if (Enable == 1'b1) // Increment CounterValue only when Enable is 1
			CounterValue <= CounterValue + 1;
	end
endmodule

	
module hexdecoder(d, c, b, a, s0, s1, s2, s3, s4, s5, s6);
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
