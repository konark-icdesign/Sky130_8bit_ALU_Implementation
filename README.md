Sky130_8bit_ALU_Implementation
RTL-to-GDSII flow of an 8-bit Synchronous ALU using SkyWater 130nm PDK and OpenLane.

8-bit Synchronous ALU

Physical Implementation (Sky130)
This design was taken through the complete OpenLane RTL-to-GDSII flow.
![Layout GDSII View](./layout/alu_chip_layout.png)

Figure 1: Final GDSII Layout showing standard cells and routing in SkyWater 130nm.*
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

How to Run the Simulation
To verify the design using Icarus Verilog, follow these steps:

1. Clone the repository
   bash
   git clone [https://github.com/YOUR_USERNAME/Sky130_8bit_ALU.git](https://github.com/konark-icdesign/Sky130_8bit_ALU.git)
   cd Sky130_8bit_ALU
Compile the RTL and Testbench

Bash
iverilog -o sim/alu_sim rtl/alu.v testbench/alu_tb.v
Run the Simulation

Bash
vvp sim/alu_sim
View Waveforms (Optional)

Bash
gtkwave sim/dump.vcd

2. The "Future Roadmap" (Shows Ambition)**
Professors love students who think ahead. Add this small section at the very end. It tells them, *"I'm not done learning."*

markdown
Future Work
Pipelining:** Implement a 2-stage pipeline to increase throughput to 200MHz.
Power Analysis:** Perform IR drop analysis using OpenLane's voltage tools.
Multiplier Integration:** Merge with my Serial-Parallel Multiplier (SPM) project.


Physical Implementation (Sky130)
The 8-bit ALU was implemented using the OpenLane RTL-to-GDSII flow. The views below demonstrate the floorplanning, placement, and routing density.


<img src="./layout.png" width="400"> | <img src="./final layout routing.png" width="400"> 

Standard Cell Placement
<img src="./final layout.png" width="800"> 
Zoomed-in view of the logic gate placement.

Note: 
The design achieves a core utilization of roughly 40% with zero DRC/LVS violations.

License

Apache 2.0
