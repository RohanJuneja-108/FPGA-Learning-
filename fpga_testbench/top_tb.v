`timescale 1ns/1ns
module tb;

    reg  [1:0] op;
    wire [7:0] y;
    wire       carry;
    wire       zero;

    // Instantiate the Unit Under Test (UUT)
    top uut (
        .op(op),
        .y(y),
        .carry(carry),
        .zero(zero)
    );

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb);

        $monitor("Time=%0t | op=%b | y=%d | carry=%b | zero=%b",
                 $time, op, y, carry, zero);

        // Apply your opcode values and add delay times below
        // ====================================================
        
        // Test 00: Addition (10 + 5 = 15)
        op = 2'b00;
        #10;

        // Test 01: XOR (10 ^ 5 = 15)
        op = 2'b01;
        #10;

        // Test 10: Logical Right Shift (10 >> 1 = 5, carry out LSB = 0)
        op = 2'b10;
        #10;

        // Test 11: Rotate Right (10 [00001010] ror 1 = 5 [00000101])
        op = 2'b11;
        #10;

        $finish;
    end

endmodule