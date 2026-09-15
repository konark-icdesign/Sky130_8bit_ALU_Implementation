BUILD_DIR := build
RTL := rtl/alu.v
TB := testbench/alu_tb.v
WAVE_TB := testbench/alu_wave_tb.v
SIM := $(BUILD_DIR)/alu_tb
WAVE_SIM := $(BUILD_DIR)/alu_wave_tb

.PHONY: all test wave synth formal clean

all: test

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

test: $(BUILD_DIR)
	iverilog -g2012 -Wall -o $(SIM) $(RTL) $(TB)
	vvp $(SIM)

wave: $(BUILD_DIR)
	iverilog -g2012 -Wall -o $(WAVE_SIM) $(RTL) $(WAVE_TB)
	vvp $(WAVE_SIM)
	gtkwave $(BUILD_DIR)/alu.vcd

synth: $(BUILD_DIR)
	yosys -p "read_verilog $(RTL); hierarchy -check -top alu; synth -top alu; stat" | tee $(BUILD_DIR)/yosys_synth.log

formal: $(BUILD_DIR)
	yosys -s formal/prove.ys | tee $(BUILD_DIR)/yosys_formal.log

clean:
	rm -rf $(BUILD_DIR)
