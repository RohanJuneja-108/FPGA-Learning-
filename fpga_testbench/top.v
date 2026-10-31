module top (
    output reg  [7:0] y,
    output reg        carry,
    output reg        zero
);

    // Hardcoded Inputs
   wire  [1:0] op = 2'b00;
    wire [7:0] a = 8'd10;
    wire [7:0] b = 8'd5;

    reg  [8:0] temp;

    always @(*) begin
        // Default assignments to prevent latches
        y     = 8'b0;
        carry = 1'b0;
        temp  = 9'b0;

        case (op)
            2'b00: begin 
                // Perform 8 bit addition of inputs a and b using temp to capture the 9th bit for carry out
                // Assign the lower 8 bits of temp to output y and the 9th bit to carry
		temp = {1'b0, a} + {1'b0,b};
		y = temp[7:0];
		carry  = temp[8];
            end

            2'b01: begin 
                // Perform bitwise exclusive or between inputs a and b and assign the resulting 8 bit value to y
                // Keep carry set to zero since bitwise operations do not generate an arithmetic carry
		y = a^b;
		carry = 1'b0;
            end

            2'b10: begin 
                // Perform a logical right shift on input a by 1 bit and assign the resulting 8 bit value to y
                // Capture the shifted out bit from a into the carry output
		y = a>>1;
		carry = a[0];
            end

            2'b11: begin 
                // Perform a right rotation on input a by 1 bit where the least significant bit wraps around to become the most significant bit
                // Keep carry set to zero for this rotational shift operation
		y = {a[0],a[7:1]};
		carry = 1'b0;
            end

            default: begin
                // Assign safe default values to output y and carry to prevent unwanted latches during undefined states
		y = 8'b0;
		carry = 1'b0;
            end
        endcase

        // Write your logic here to set the zero flag as active high if output y is equal to zero
	zero = (y==8'b0);
    end

endmodule