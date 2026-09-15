# 8-bit ALU RTL, Verification and Synthesis

An 8-bit combinational ALU written in Verilog. Kept this one small on purpose so the whole thing can be checked properly instead of only showing a few waveform cases.

The current repo covers RTL, exhaustive simulation, a Yosys synthesis smoke test and now a small formal check. Physical-design numbers are still not claimed because the old OpenLane run/report set is not available.

## ALU functions

| Opcode | Operation | Behaviour |
|---|---|---|
| `000` | ADD | 8-bit sum with carry-out |
| `001` | SUB | 8-bit wrap-around subtraction |
| `010` | AND | Bitwise AND |
| `011` | OR | Bitwise OR |
| `100` | XOR | Bitwise XOR |
| `101`-`111` | Reserved | result and carry go to zero |

The RTL is combinational, no clock or internal state.

## Verification

`testbench/alu_tb.v` exhaustively checks:

```text
256 A values x 256 B values x 8 opcodes = 524,288 cases
```

The testbench calculates the expected result separately and stops on a mismatch.

Current simulation result:

```text
PASS: 524288 ALU input/opcode combinations verified with no mismatches.
```

Run it with:

```bash
make test
```

For a smaller VCD/waveform run:

```bash
make wave
```

## Synthesis

```bash
make synth
```

The generic Yosys smoke run maps the design to 195 generic logic cells. This is only a synthesis sanity check, not Sky130 area/timing/power.

## Formal check

I added a second way of checking the ALU using Yosys SAT.

Instead of looping through vectors in a testbench, `formal/alu_formal.v` states what each opcode is supposed to do and Yosys tries to prove those assertions for all possible 8-bit inputs.

```bash
make formal
```

The properties cover ADD/carry, wrap-around SUB, AND, OR, XOR and the reserved opcodes.

## Physical-design status

The repo does **not** currently claim a reproducible Sky130 RTL-to-GDS result. The original OpenLane config/run/sign-off files are not in the project history, so old area/utilization/DRC/LVS numbers cannot be backed up properly.

If I revisit physical design, the useful next step is to rerun this exact RTL and keep the config plus synthesis, STA, routing, DRC and LVS reports.

## Structure

```text
rtl/
  alu.v

testbench/
  alu_tb.v
  alu_wave_tb.v

formal/
  alu_formal.v
  prove.ys

.github/workflows/
  verilog-ci.yml

Makefile
```

## Tools

- Verilog
- Icarus Verilog
- GTKWave
- Yosys
- GNU Make
- GitHub Actions

## License

Apache 2.0
