# Day 2 – Hierarchical Synthesis

## Overview
This folder contains the work completed during Day 2 of the VSD RTL Design and Synthesis Workshop.

The objective was to understand hierarchical RTL synthesis using Yosys, including RTL parsing, hierarchy analysis, optimization, technology mapping, and design visualization.

## Design Used

The design contains:
- `multiple_modules` – top-level module
- `sub_module1` – AND logic submodule
- `sub_module2` – OR logic submodule

### Design Hierarchy

```text
multiple_modules
├── sub_module1
└── sub_module2
```

## RTL Simulation

The RTL design was simulated using Icarus Verilog and the waveform was viewed using GTKWave.

Signals verified:
- `a`
- `b`
- `c`
- `net1`
- `y`

The waveform confirmed the expected logical behavior of the design.

## Yosys Synthesis

The RTL was processed through Yosys using the following stages:

1. Verilog RTL parsing
2. Design hierarchy analysis
3. Process conversion
4. RTL optimization
5. Flattening
6. Technology mapping
7. Statistics generation

The hierarchy analysis confirmed:

```text
Top module: multiple_modules
Used module: sub_module1
Used module: sub_module2
```

## Technology Mapping

The Sky130 HD standard-cell library was used for technology mapping.

The synthesized design included:

```text
sky130_fd_sc_hd__and2_0
sky130_fd_sc_hd__or2_0
```

Final synthesis statistics included:

- Number of ports: **4**
- Number of memories: **0**
- Number of processes: **0**
- Number of cells: **4**

The logic cells represent the AND and OR operations in the design.

## Design Visualization

A graphical representation of the hierarchical design was generated using Yosys and xdot.

Upload the original design diagram/image to this folder along with this README.

## Files

| File | Description |
|---|---|
| `multiple_modules.v` | Top-level RTL design |
| `sub_module1.v` | AND submodule |
| `sub_module2.v` | OR submodule |
| `tb_multiple_modules.v` | Testbench |
| `multiple_modules.vcd` | Simulation waveform |
| `multiple_modules_gtkwave.png` | GTKWave waveform screenshot |
| `hierarchical_synth.v` | Synthesized Verilog |
| `README.md` | Day 2 documentation |

## Tools Used

- Verilog HDL
- Icarus Verilog
- GTKWave
- Yosys
- Sky130 HD standard-cell library
- Ubuntu/Linux
- Git and GitHub

## Conclusion

Day 2 demonstrated the flow from RTL design and simulation to hierarchical synthesis and technology mapping. The design hierarchy was successfully analyzed, optimized, mapped to Sky130 standard cells, and visualized.

---

**VSD RTL Design and Synthesis Workshop – Day 2**
