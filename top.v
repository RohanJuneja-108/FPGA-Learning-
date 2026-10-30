module top (
    output reg [7:0] y,
    output reg       carry,
    output reg       zero
);
 wire [2:0] op = 3'b000;
wire [7:0] a = 8'd10;
wire [7:0] b = 8'd5;

    reg [8:0] temp;

    always @(*) begin
        y     = 8'b0;
        carry = 1'b0;
        temp  = 9'b0;

        case (op)
            3'b000: begin // Addition
                temp  = {1'b0, a} + {1'b0, b};
                y     = temp[7:0];
                carry = temp[8];
            end

            3'b001: begin // Division
                if (b != 0)
                    y = a / b;
            end

            3'b010: begin // Left Shift
                y     = a << 1;
                carry = a[7];
            end

            3'b011: begin // Rotate Left
                y = {a[6:0], a[7]};
            end

            3'b100: begin // XOR
                y = a ^ b;
            end

            3'b101: begin // Greater Than
                y = (a > b) ? 8'd1 : 8'd0;
            end

            3'b110: begin // Equality
                y = (a == b) ? 8'd1 : 8'd0;
            end

            3'b111: begin // AND
                y = a & b;
            end

            default: begin
                y     = 8'b0;
                carry = 1'b0;
            end
        endcase

        zero = (y == 8'b0);
    end

endmodule