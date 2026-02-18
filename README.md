# Sky130_8bit_ALU_Implementation
RTL-to-GDSII flow of an 8-bit Synchronous ALU using SkyWater 130nm PDK and OpenLane.
# 8-bit Synchronous ALU

A simple RTL implementation of an 8-bit ALU written in Verilog. I built this as the processing core for a low-power environmental monitoring system, and it's designed to be compatible with the SkyWater 130nm open-source PDK.

This work ties into my research on IoT-based air quality monitoring — published in Taylor & Francis (2024) — where I needed a lightweight, custom compute unit that didn't draw much power.

What's in here

rtl/          → alu.v (the actual hardware logic)
testbench/    → alu_tb.v (simulation + verification)
sim/          → compiled sim binary (alu_sim)

Supported Operations

The ALU takes a 3-bit opcode and operates on two 8-bit inputs:

| Opcode | Op  | Notes |
|--------|-----|-------|
| `000`  | ADD | Produces carry-out on overflow |
| `001`  | SUB | Standard 8-bit subtraction |
| `010`  | AND | Bitwise |
| `011`  | OR  | Bitwise |
| `100`  | XOR | Bitwise |

Verification

Simulated with Icarus Verilog. The testbench covers arithmetic overflow behavior and bitwise logic correctness. A few quick sanity checks from the sim log:

`10 + 5 = 15`, carry = 0 
`10 - 3 = 7` 
AND/OR/XOR tested against `1100` and `1010` inputs 

Waveforms viewed in GTKWave.

Tools

- Verilog (HDL)
- Icarus Verilog (simulation)
- GTKWave (waveform viewer)
- SkyWater 130nm PDK


## License

Apache 2.0
