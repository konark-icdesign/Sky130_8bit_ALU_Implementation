`timescale 1ns/1ps

module alu_wave_tb;

reg  [7:0] A;
reg  [7:0] B;
reg  [2:0] opcode;
wire [7:0] result;
wire       carry;

alu uut (
    .A(A),
    .B(B),
    .opcode(opcode),
    .result(result),
    .carry(carry)
);

initial begin
    $dumpfile("build/alu.vcd");
    $dumpvars(0, alu_wave_tb);

    A = 8'd10;  B = 8'd5;   opcode = 3'b000; #10;
    A = 8'd255; B = 8'd1;   opcode = 3'b000; #10;
    A = 8'd10;  B = 8'd3;   opcode = 3'b001; #10;
    A = 8'd3;   B = 8'd10;  opcode = 3'b001; #10;
    A = 8'hCC;  B = 8'hAA;  opcode = 3'b010; #10;
    A = 8'hCC;  B = 8'hAA;  opcode = 3'b011; #10;
    A = 8'hCC;  B = 8'hAA;  opcode = 3'b100; #10;
    A = 8'hFF;  B = 8'hFF;  opcode = 3'b101; #10;

    $finish;
end

endmodule
