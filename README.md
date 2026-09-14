# Sky130 8-bit ALU Implementation

An 8-bit combinational ALU implemented in Verilog and taken through an OpenLane/SkyWater 130 nm physical-design flow.

## What the design does

The ALU accepts two 8-bit operands (`A`, `B`) and a 3-bit opcode.

| Opcode | Operation | Notes |
|---|---|---|
| `000` | ADD | 8-bit addition with carry-out |
| `001` | SUB | 8-bit subtraction |
| `010` | AND | Bitwise AND |
| `011` | OR | Bitwise OR |
| `100` | XOR | Bitwise XOR |

## Repository structure

```text
rtl/          Verilog RTL
  alu.v

testbench/    Simulation testbench
  alu_tb.v

sim/          Simulation output files
```

The repository also contains layout/routing screenshots from the physical-design run.

## RTL design

The core logic is implemented in `rtl/alu.v` using a combinational `case` statement. Addition returns an explicit carry bit; the other implemented operations return an 8-bit result.

## Verification

The current testbench in `testbench/alu_tb.v` exercises:

- addition
- subtraction
- bitwise AND
- bitwise OR
- bitwise XOR

The present testbench is a basic directed testbench. A stronger self-checking testbench with exhaustive/random vectors is planned as a next improvement.

### Run with Icarus Verilog

```bash
git clone https://github.com/konark-icdesign/Sky130_8bit_ALU_Implementation.git
cd Sky130_8bit_ALU_Implementation

iverilog -o sim/alu_sim rtl/alu.v testbench/alu_tb.v
vvp sim/alu_sim
```

## Physical implementation

The design was taken through an OpenLane flow targeting the SkyWater 130 nm open PDK. The repository currently includes visual outputs from placement/routing/layout inspection.

![Final layout](./final%20layout.png)

![Final routing view](./final%20layout%20routing.png)

## Tools used

- Verilog HDL
- Icarus Verilog
- GTKWave
- OpenLane
- Yosys
- OpenROAD
- KLayout
- SkyWater 130 nm PDK

## What I learned

This project was used to connect RTL coding with the broader ASIC implementation flow: functional RTL, simulation, synthesis/implementation, placement/routing, and layout inspection.

## Next improvements

- replace the directed testbench with a self-checking verification environment
- add exhaustive/randomized functional testing
- add reproducible OpenLane configuration files
- publish synthesis, timing, area and utilization reports
- document DRC/LVS results with generated reports instead of screenshots alone
- compare timing/area across different constraints

## License

Apache 2.0
