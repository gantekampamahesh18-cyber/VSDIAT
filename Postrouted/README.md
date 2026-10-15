# VSDBabySoC — Physical Design and Routed Static Timing Analysis

## Overview

This project documents the physical-design stages and post-route static timing analysis (STA) of **VSDBabySoC** using the **Sky130 HD** standard-cell library.

The report includes floorplanning, placement, routing, extracted interconnect parasitics, and independent timing analysis across 16 Sky130 HD process-voltage-temperature (PVT) library corners. Screenshots and timing observations are included in the accompanying report.

## Design Flow

**Synthesis → Floorplanning → Placement → Routing → Post-route STA**

## Physical Design Stages

### 1. Floorplanning
Floorplanning establishes the core area and initial physical organization of the design. The report shows the OpenROAD `2_floorplan` stage, including the PLL and DAC macro instances. The PLL instance is shown with placement status `LOCKED`.

### 2. Placement
Placement assigns standard cells to legal sites within the floorplan while considering timing, congestion, and wirelength. The report includes an OpenROAD `3_place` view. Placement-stage parasitics are estimates and are not the same as extracted routed parasitics.

### 3. Routing
Routing creates detailed metal interconnect and vias that connect placed cells and macros. The final routed database is used with extracted parasitics for post-route timing analysis.

## Post-route STA Inputs

| Input | Purpose |
|---|---|
| `6_final.odb` | Final routed OpenDB database |
| `6_final.spef` | Extracted interconnect parasitics |
| `5_route.sdc` | Route-stage timing constraints |
| Sky130 HD Liberty `.lib` files | Cell timing models; one library file per independent run |

The report records an **11.000 ns clock** with propagated clock timing.

## Timing Analysis Across 16 Library Corners

Setup timing was analyzed in separate runs, each using one Sky130 HD Liberty library corner. The supplied results include both passing and failing setup corners.

### Key setup observations

- The most severe reported setup result is for `sky130_fd_sc_hd__ss_n40C_1v28`: **WNS = −32.03 ns** and **TNS = −15425.64 ns**.
- `sky130_fd_sc_hd__ss_100C_1v40` also reports a setup violation: **WNS = −3.34 ns** and **TNS = −462.24 ns**.
- Several other reported corners have no negative setup slack in the supplied summary.
- WNS/TNS values of `0.00` mean no negative slack was reported in that summary; they do not mean the worst path slack is zero.

### Example worst setup path

For `ss_n40C_1v28`, the report identifies a register-to-register path in the CPU logic:

- **Startpoint:** `core.CPU_src1_value_a3[14]`
- **Endpoint:** `core.CPU_Xreg_value_a4[10][27]`
- **Data arrival time:** 46.45 ns
- **Data required time:** 14.42 ns
- **Slack:** 14.42 − 46.45 = **−32.03 ns (VIOLATED)**

The path includes multiple combinational cells, resulting in a late data arrival under that slow, low-voltage timing model.

## Hold Timing

The supplied hold reports show positive worst hold-path slack and status **MET** for all 16 corners. For example, the `ss_n40C_1v35` report shows:

- Data arrival time: 4.38 ns
- Data required time: 3.17 ns
- Hold slack: **+1.21 ns (MET)**

Hold WNS/TNS values of zero indicate that no negative hold slack was reported in the summary. Worst hold-path slack should be considered separately.

## Results and Conclusion

The report documents the VSDBabySoC floorplan, placement, routed layout, and post-route STA workflow. The supplied results indicate that hold timing passes for all 16 analyzed corners, while setup violations remain in several slow-slow corners, especially `ss_n40C_1v28`.

**Timing closure should not be claimed from these results.** Before treating the numbers as signoff-quality results, verify that each run used the intended Liberty file, routed ODB, extracted SPEF, route SDC, clocks, and timing-report commands. These are independent single-library comparisons, not a combined MCMM signoff run.

## Report

See the accompanying PDF for screenshots of the floorplan, placement, routed layout, setup timing results, hold timing results, and validation notes.

---

*Tools and technology referenced: OpenROAD, Sky130 HD PDK, Liberty timing libraries, SDC constraints, ODB, SPEF, and static timing analysis.*

