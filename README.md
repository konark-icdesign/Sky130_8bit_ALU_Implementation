# Sky130 8-bit ALU Implementation

An 8-bit combinational ALU written in Verilog and used as a small RTL-to-physical-design learning project with the SkyWater 130 nm ecosystem.

The ALU logic itself is intentionally simple. The main purpose of the project is to connect functional RTL, verification, synthesis and physical-layout work in one small design that is easy to inspect end to end.

## ALU functions

The design accepts two 8-bit operands (`A`, `B`) and a 3-bit opcode.

| Opcode | Operation | Behaviour |
|---|---|---|
| `000` | ADD | 8-bit sum with carry-out |
| `001` | SUB | 8-bit wrap-around subtraction |
| `010` | AND | Bitwise AND |
| `011` | OR | Bitwise OR |
| `100` | XOR | Bitwise XOR |
| `101`-`111` | Reserved | Output and carry return to zero |

The RTL is combinational; there is no clock or internal state in `rtl/alu.v`.

## Verification

`testbench/alu_tb.v` is self-checking and exhaustively tests every pair of 8-bit inputs across all eight opcode values:

```text
256 A values x 256 B values x 8 opcodes = 524,288 checks
```

The reference calculation is performed in the testbench and the simulation fails if either `result` or `carry` differs from the expected value. This includes addition carry-out, subtraction wrap-around, the three bitwise operations and the reserved opcode behaviour.

The automated run currently reports:

```text
PASS: 524288 ALU input/opcode combinations verified with no mismatches.
```

Run the verification with:

```bash
make test
```

A smaller waveform-oriented testbench is kept separately so a useful VCD can be generated without dumping the entire exhaustive run:

```bash
make wave
```

## Synthesis check

A reproducible Yosys synthesis smoke test is available with:

```bash
make synth
```

The current generic Yosys run completes with zero reported design problems and maps the ALU to 195 generic logic cells. That cell count is useful only as a reproducible synthesis sanity check; it is **not** a Sky130 standard-cell area or timing result.

GitHub Actions runs both the exhaustive RTL verification and the Yosys synthesis check on pushes and pull requests.

## Sky130 physical implementation

I also used this ALU as a small physical-design exercise with OpenLane and the SkyWater 130 nm open PDK. The repository preserves screenshots from the placement/routing/layout work, including the final layout and routed view:

![Final layout](./final%20layout.png)

![Final routing view](./final%20layout%20routing.png)

Additional historical views are kept in the repository root.

The original OpenLane run directory, configuration and generated sign-off reports are not currently preserved in this repository. Because of that, this README does **not** claim exact utilization, timing, area, DRC or LVS numbers from the earlier run. A future reproducible OpenLane rerun can add those measurements with the corresponding reports.

## Repository structure

```text
rtl/
  alu.v                    # combinational ALU RTL

testbench/
  alu_tb.v                 # exhaustive self-checking verification
  alu_wave_tb.v            # compact waveform test

.github/workflows/
  verilog-ci.yml           # automated verification + Yosys smoke test

Makefile                   # test / wave / synth targets
```

## Tools used

- Verilog HDL
- Icarus Verilog
- GTKWave
- Yosys
- OpenLane
- OpenROAD
- KLayout
- SkyWater 130 nm PDK

## What this project demonstrates

This is not intended to be a complex processor ALU. It is a compact block used to practice the digital ASIC flow: write RTL, verify the logic, synthesize it, then study how the design is represented as placed and routed standard-cell logic in a physical layout.

The next meaningful extension is a fully reproducible Sky130/OpenLane rerun with the configuration, synthesis/STA reports, area/utilization data, routing results and DRC/LVS evidence committed alongside the layout views.

## License

Apache 2.0
