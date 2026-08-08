# Day 1 - RTL Design, Simulation and Synthesis

## Experiment: 2-Bit Counter

### Objective

To design and verify a 2-bit synchronous counter using Verilog HDL
and understand the basic RTL-to-netlist flow.

---

## Design Description

The counter has:

- Clock input
- Reset input
- 2-bit counter output
- Terminal-count detection

The counter follows the sequence:

```text
00 -> 01 -> 10 -> 00 -> ...
