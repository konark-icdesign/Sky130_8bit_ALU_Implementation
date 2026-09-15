Formal check for the small ALU.

`alu_formal.v` states the expected result for each opcode. `prove.ys` runs the assertions through Yosys SAT.

Run:

```bash
make formal
```

This is separate from the 524,288-case simulation test. The testbench enumerates cases; the SAT run proves the same combinational behaviour symbolically.
