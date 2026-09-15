module alu_formal(
    input wire [7:0] A,
    input wire [7:0] B,
    input wire [2:0] opcode
);

    wire [7:0] result;
    wire carry;

    alu dut (
        .A(A),
        .B(B),
        .opcode(opcode),
        .result(result),
        .carry(carry)
    );

    always @* begin
        case (opcode)
            3'b000: assert({carry, result} == ({1'b0, A} + {1'b0, B}));
            3'b001: begin
                assert(result == (A - B));
                assert(carry == 1'b0);
            end
            3'b010: begin
                assert(result == (A & B));
                assert(carry == 1'b0);
            end
            3'b011: begin
                assert(result == (A | B));
                assert(carry == 1'b0);
            end
            3'b100: begin
                assert(result == (A ^ B));
                assert(carry == 1'b0);
            end
            default: begin
                assert(result == 8'b0);
                assert(carry == 1'b0);
            end
        endcase
    end

endmodule
