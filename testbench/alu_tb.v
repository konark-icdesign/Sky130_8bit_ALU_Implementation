`timescale 1ns/1ps

module alu_tb;

reg  [7:0] A;
reg  [7:0] B;
reg  [2:0] opcode;
wire [7:0] result;
wire       carry;

integer a;
integer b;
integer op;
integer tests;
integer errors;
reg [8:0] add_expected;
reg [7:0] expected_result;
reg       expected_carry;

alu uut (
    .A(A),
    .B(B),
    .opcode(opcode),
    .result(result),
    .carry(carry)
);

task check_result;
    input [7:0] exp_result;
    input       exp_carry;
    begin
        #1;
        tests = tests + 1;
        if ((result !== exp_result) || (carry !== exp_carry)) begin
            errors = errors + 1;
            if (errors <= 20) begin
                $display("FAIL: A=%0d B=%0d opcode=%03b result=%0d carry=%0b expected_result=%0d expected_carry=%0b",
                         A, B, opcode, result, carry, exp_result, exp_carry);
            end
        end
    end
endtask

initial begin
    tests = 0;
    errors = 0;
    A = 0;
    B = 0;
    opcode = 0;

    // Exhaustively verify every input pair for all eight opcode values.
    for (op = 0; op < 8; op = op + 1) begin
        for (a = 0; a < 256; a = a + 1) begin
            for (b = 0; b < 256; b = b + 1) begin
                A = a;
                B = b;
                opcode = op;

                expected_result = 8'h00;
                expected_carry = 1'b0;

                case (op)
                    0: begin
                        add_expected = a + b;
                        expected_result = add_expected[7:0];
                        expected_carry = add_expected[8];
                    end
                    1: expected_result = a - b;
                    2: expected_result = a & b;
                    3: expected_result = a | b;
                    4: expected_result = a ^ b;
                    default: begin
                        expected_result = 8'h00;
                        expected_carry = 1'b0;
                    end
                endcase

                check_result(expected_result, expected_carry);
            end
        end
    end

    if (errors == 0) begin
        $display("PASS: %0d ALU input/opcode combinations verified with no mismatches.", tests);
        $finish;
    end else begin
        $fatal(1, "FAIL: %0d mismatches found across %0d tests.", errors, tests);
    end
end

endmodule
