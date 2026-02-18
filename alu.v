module alu (
    input  [7:0] A,
    input  [7:0] B,
    input  [2:0] opcode,
    output reg [7:0] result,
    output reg carry
);

always @(*) begin
    carry = 0;
    case (opcode)
        3'b000: begin
            {carry, result} = A + B;
        end

        3'b001: begin
            result = A - B;
        end

        3'b010: begin
            result = A & B;
        end

        3'b011: begin
            result = A | B;
        end

        3'b100: begin
            result = A ^ B;
        end

        default: begin
            result = 8'b00000000;
        end
    endcase
end

endmodule
