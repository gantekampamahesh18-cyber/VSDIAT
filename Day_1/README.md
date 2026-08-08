# Experiment 1: 2-Bit Synchronous Counter

## Objective

To design and verify a 2-bit synchronous counter using Verilog HDL and understand the basic RTL-to-Netlist flow using Yosys.

The experiment covers:

- Verilog RTL design
- Testbench creation
- Functional simulation
- Waveform analysis using GTKWave
- RTL synthesis using Yosys
- Gate-level netlist generation
- Verification of the synthesized design

---

## Design Description

The design is a 2-bit synchronous counter with the following signals:

| Signal | Type | Width | Description |
|--------|------|-------|-------------|
| `clk` | Input | 1 bit | Clock signal |
| `reset` | Input | 1 bit | Asynchronous reset |
| `cnt` | Output | 2 bits | Counter output |
| `comp` | Internal | 1 bit | Terminal-count detection |

The counter operates synchronously with the rising edge of the clock.

### Counter Sequence

The counter follows the sequence:

```text
00 → 01 → 10 → 00 → 01 → 10 → ...
