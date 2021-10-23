module eightbitrotatingregister(SW, KEY, LEDR);
	input [9:0] SW;
	input [3:0] KEY;
	output [9:0] LEDR;
	wire clock;
	assign clock = KEY[0];
	wire reset;
	assign reset = SW[9];
	wire ParallelLoadn;
	assign ParallelLoadn = KEY[1];
	wire RotateRight;
	assign RotateRight = KEY[2];
	wire ASRight;
	assign ASRight = KEY[3];
	wire [7:0] Data_IN;
	assign Data_IN[7:0] = SW[7:0];
	wire [7:0] Q;
	part3 u0(clock, reset, ParallelLoadn, RotateRight, ASRight, Data_IN, Q);
	assign LEDR[7:0] = Q[7:0];
endmodule 


module part3(clock, reset, ParallelLoadn, RotateRight, ASRight, Data_IN, Q);
	input clock, reset, ParallelLoadn, RotateRight, ASRight;
	input [7:0] Data_IN;
	output [7:0] Q;
	wire [7:0] rotatedata;
	wire [7:0] data_to_dff;

	// KEY[0] = clock
	// KEY[1] = ParallelLoadn
	// KEY[2] = RotateRight
	// KEY[3] = ASRight
	
// Substructure 1
	mux2to1 m1(
		.x(Q[7]), // Rotate left
		.y(Q[1]), // Rotate right
		.s(RotateRight), // Input new bit to the left
		.m(rotatedata[0]) // Output to mux
	);
	mux2to1 m2(
		.x(Data_IN[0]), // Input data D
		.y(rotatedata[0]), // Output from prev mux
		.s(ParallelLoadn), // Selects input D or rotate
		.m(data_to_dff[0])
	);
	flipflop f0(
		.d(data_to_dff[0]), // Input to FF
		.q(Q[0]), // Output from FF
		.clock(clock),
		.reset(reset)
	);

// Substructure 2
	mux2to1 m3(
		.x(Q[0]), // Rotate left
		.y(Q[2]), // Rotate right
		.s(RotateRight), // Inputs new bit to the left
		.m(rotatedata[1]) // Output to mux
	);
	mux2to1 m4(
		.x(Data_IN[1]), // Input data D
		.y(rotatedata[1]), // Output from prev mux
		.s(ParallelLoadn), // Selects input D or rotate
		.m(data_to_dff[1]) // Output to FF
	);
	flipflop ff1(
		.d(data_to_dff[1]), // Input to FF
		.q(Q[1]), // Output from FF
		.clock(clock),
		.reset(reset)
	);

// Substructure 3
	mux2to1 m5(
		.x(Q[1]),
		.y(Q[3]),
		.s(RotateRight),
		.m(rotatedata[2])
	);
	mux2to1 m6(
		.x(Data_IN[2]),
		.y(rotatedata[2]),
		.s(ParallelLoadn),
		.m(data_to_dff[2])
	);
	flipflop f2(
		.d(data_to_dff[2]),
		.q(Q[2]),
		.clock(clock),
		.reset(reset)
	);
	
// Substructure 4
	mux2to1 m7(
		.x(Q[2]),
		.y(Q[4]),
		.s(RotateRight),
		.m(rotatedata[3])
	);
	mux2to1 m8(
		.x(Data_IN[3]),
		.y(rotatedata[3]),
		.s(ParallelLoadn),
		.m(data_to_dff[3])
	);

	flipflop f3(
		.d(data_to_dff[3]),
		.q(Q[3]),
		.clock(clock),
		.reset(reset)
	);
	
// Substructure 5 
	mux2to1 m9(
		.x(Q[3]), 
		.y(Q[5]),
		.s(RotateRight),
		.m(rotatedata[4])
	);
	mux2to1 m10(
		.x(Data_IN[4]),
		.y(rotatedata[4]),
		.s(ParallelLoadn),
		.m(data_to_dff[4])
	);
	flipflop f4(
		.d(data_to_dff[4]),
		.q(Q[4]),
		.clock(clock),
		.reset(reset)
	);
	
// Substructure 6
	mux2to1 m11(
		.x(Q[4]), 
		.y(Q[6]), 
		.s(RotateRight),
		.m(rotatedata[5])
	);
	mux2to1 m12(
		.x(Data_IN[5]),
		.y(rotatedata[5]),
		.s(ParallelLoadn),
		.m(data_to_dff[5])
	);
	flipflop f5(
		.d(data_to_dff[5]),
		.q(Q[5]),
		.clock(clock),
		.reset(reset) 
	);
	
// Substructure 7
	mux2to1 m13(
		.x(Q[5]),
		.y(Q[7]),
		.s(RotateRight),
		.m(rotatedata[6])
	);
	mux2to1 m14(
		.x(Data_IN[6]), 
		.y(rotatedata[6]),
		.s(ParallelLoadn),
		.m(data_to_dff[6])
	);
	flipflop f6(
		.d(data_to_dff[6]),
		.q(Q[6]),
		.clock(clock),
		.reset(reset)
	);
	
// Substructure 8 
wire ASR, notASR;

	mux2to1 m15(
		.x(Q[6]),
		.y(Q[7]),
		.s(RotateRight),
		.m(ASR)
	);
	mux2to1 m16(
		.x(Q[6]),
		.y(Q[0]),
		.s(RotateRight),
		.m(not_ASR)
	);
	mux2to1 m17(
		.x(not_ASR), 
		.y(ASR), 
		.s(RotateRight & ASRight), 
		.m(rotatedata[7])
	);
	mux2to1 m18(
		.x(Data_IN[7]),
		.y(rotatedata[7]),
		.s(ParallelLoadn),
		.m(data_to_dff[7])
	);
	flipflop f7(
		.d(data_to_dff[7]),
		.q(Q[7]),
		.clock(clock),
		.reset(reset)
	);
endmodule


module mux2to1(y, x, s, m);
	input y, x, s;
	output reg m;
	
	always @(*)
	begin
		case(s)
			0: m = x;
			1: m = y;
		endcase
	end
endmodule


module flipflop(d, q, clock, reset);
	input d, clock, reset;
	output reg q;
	
	always @(posedge clock) 
	begin
		if (reset == 1'b1) // When reset is 1 (note this is tested on every rising clock edge)
			q <= 0;
		else
			q <= d; // Assign d to q at posedge if not reset
	end
endmodule
