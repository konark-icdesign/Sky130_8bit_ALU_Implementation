# 8-bit ALU RTL, Verification and Synthesis

An 8-bit combinational ALU written in Verilog and used as a compact digital-design project covering RTL, exhaustive functional verification, waveform inspection and synthesis.

The ALU itself is intentionally small so that the complete logic can be verified and inspected end to end. A reproducible Sky130/OpenLane physical-design run is the next stage of the project; this branch does not claim physical-design measurements that are not backed by saved reports.

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

The reference calculation is performed independently in the testbench. The simulation fails if either `result` or `carry` differs from the expected value. The checks cover addition carry-out, subtraction wrap-around, AND, OR, XOR and the reserved opcode behaviour.

The automated run currently reports:

```text
PASS: 524288 ALU input/opcode combinations verified with no mismatches.
```

Run the verification with:

```bash
make test
```

A separate compact testbench generates a useful VCD without dumping the full exhaustive run:

```bash
make wave
```

## Synthesis check

A reproducible Yosys synthesis smoke test is available with:

```bash
make synth
```

The current generic Yosys run completes with zero reported design problems and maps the design to 195 generic logic cells. This is a synthesis sanity check only; the number is not a Sky130 standard-cell area, timing or power result.

GitHub Actions runs both the exhaustive RTL verification and the Yosys synthesis check on pushes and pull requests.

## Physical-design status

The current repository does **not** claim a verified Sky130 RTL-to-GDS result. The original OpenLane configuration, run directory and sign-off reports are not present in the Git history, so exact area, utilization, timing, DRC and LVS results cannot be reproduced from the saved project files.

The next physical-design step is to rerun this exact `alu.v` through OpenLane/Sky130 and commit the configuration together with the generated synthesis/STA reports, DEF/GDS outputs, routing results and DRC/LVS evidence. Until that run is reproduced, the RTL verification and generic synthesis results above are the verified results of this repository.

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

## Tools used in the reproducible flow

- Verilog HDL
- Icarus Verilog
- GTKWave
- Yosys
- GNU Make
- GitHub Actions

## What this project demonstrates

This is not intended to be a complex processor ALU. It demonstrates a disciplined small-block workflow: write combinational RTL, define expected behaviour, verify every input/opcode combination, inspect waveforms, and confirm that the RTL synthesizes cleanly.

The next meaningful extension is the reproducible Sky130/OpenLane implementation described above rather than adding arbitrary ALU features.

## License

Apache 2.0
