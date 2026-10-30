`timescale 1ns/1ns
module tb;

    reg  [2:0] op;
    wire [7:0] y;

    top uut (
        .op(op),
        .y(y)
    );

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb);

        $monitor("Time=%0t | op=%b | y=%d | y_binary=%b",
                  $time, op, y, y);

        op = 3'b000; #10;
        op = 3'b001; #10;
        op = 3'b010; #10;
        op = 3'b011; #10;
        op = 3'b100; #10;
        op = 3'b101; #10;
        op = 3'b110; #10;
        op = 3'b111; #10;

        $finish;
    end

endmodule