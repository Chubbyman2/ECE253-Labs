module part3(ClockIn, Resetn, Start, Letter, DotDashOut);
    input ClockIn, Resetn, Start;
    input [2:0] Letter;
    output reg DotDashOut;
    
    reg temp;
    reg [4:0]n;
    reg [11:0]r;
    reg [11:0] LUT;
    wire Enable;
    reg [10:0] RateDivider;
    assign Enable = (RateDivider == 0)?1:0;
    
    always @(*)begin
        case(Letter)
            3'b000: LUT = 12'b101110000000; // A
            3'b001: LUT = 12'b111010101000; // B
            3'b010: LUT = 12'b111010111010; // C
            3'b011: LUT = 12'b111010100000; // D
            3'b100: LUT = 12'b100000000000; // E
            3'b101: LUT = 12'b101011101000; // F
            3'b110: LUT = 12'b111011101000; // G
            3'b111: LUT = 12'b101010100000; // H
            default: LUT = 0;
        endcase
    end
    
    always @(posedge ClockIn or negedge Resetn)
    begin
	if (Start ==1'b1)
		temp <= 1;
        if(Resetn == 0)
	begin
           	DotDashOut <= 0;
		RateDivider <= 0;
		n <= 0;
		r <= LUT;
		temp <= 0;
	end
        else 
	begin
            RateDivider <= (RateDivider == 0) ? 249 : RateDivider-1;
            if((Enable == 1'b1) & (temp == 1'b1)) 
		begin
		// Shift the morse code sequence bit by bit cuz the output is one bit only
		DotDashOut <= r[11]; 
                n = (n == 11)?0:n + 1;
                r = LUT << n; 
            	end
        end
    end
  endmodule
