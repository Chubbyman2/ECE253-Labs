module mux(LEDR, SW);
    input [9:0] SW;
    output [9:0] LEDR;

    part1 u0(
        .MuxSelect(SW[9:7]),
        .Input(SW[6:0]),
        .Out(LEDR[0])
        );
endmodule


module part1(MuxSelect, Input, Out);
    input [2:0] MuxSelect;
    input [6:0] Input;
    output reg Out; // Declare the output signal for the always block
		
    always@(*) // Declare always block
    begin
        case(MuxSelect) // Start case statement
           3'b000:Out = Input[0]; // case 0
           3'b001:Out = Input[1]; // case 1
           3'b010:Out = Input[2]; // case 2
           3'b011:Out = Input[3]; // case 3
           3'b100:Out = Input[4]; // case 4
           3'b101:Out = Input[5]; // case 5
           3'b110:Out = Input[6]; // case 6
           default: Out = 1'b0 ; // 1 bit 0
        endcase
    end
endmodule