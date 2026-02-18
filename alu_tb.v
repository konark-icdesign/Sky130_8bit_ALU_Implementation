module alu_tb;

reg [7:0] A;
reg [7:0] B;
reg [2:0] opcode;
wire [7:0] result;
wire carry;

alu uut (
    .A(A),
    .B(B),
    .opcode(opcode),
    .result(result),
    .carry(carry)
);

initial begin
    $display("A\tB\tOP\tRESULT\tCARRY");

    A = 8'd10; B = 8'd5; opcode = 3'b000; #10;
    $display("%d\t%d\tADD\t%d\t%b", A, B, result, carry);

    A = 8'd10; B = 8'd3; opcode = 3'b001; #10;
    $display("%d\t%d\tSUB\t%d\t%b", A, B, result, carry);

    A = 8'b1100; B = 8'b1010; opcode = 3'b010; #10;
    $display("%b\t%b\tAND\t%b\t%b", A, B, result, carry);

    A = 8'b1100; B = 8'b1010; opcode = 3'b011; #10;
    $display("%b\t%b\tOR \t%b\t%b", A, B, result, carry);

    A = 8'b1100; B = 8'b1010; opcode = 3'b100; #10;
    $display("%b\t%b\tXOR\t%b\t%b", A, B, result, carry);

    $finish;
end

endmodule
