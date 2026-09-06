# Module 1 --- OpenLane ASIC Physical Design Flow

## Overview

Module 1 introduces the ASIC Physical Design flow using **OpenLane** and
the **SkyWater SKY130 PDK**. It covers the RTL-to-GDSII flow, synthesis,
Static Timing Analysis (STA), physical implementation, Design for Test
(DFT), antenna-rule handling, design exploration, and regression
testing.

## Learning Objectives

-   Understand the complete OpenLane RTL-to-GDSII flow.
-   Understand RTL synthesis using Yosys and ABC.
-   Read basic Static Timing Analysis reports.
-   Understand floorplanning, placement, CTS, optimization and routing.
-   Understand DFT concepts such as scan insertion and ATPG.
-   Understand antenna-rule violations and their solutions.
-   Understand design exploration parameters and trade-offs.
-   Understand regression testing and physical verification.

## OpenLane ASIC Flow

``` text
RTL → Synthesis (Yosys + ABC) → STA (OpenSTA) → Floorplanning
→ Placement → CTS → Optimization → Global Routing
→ Detailed Routing (TritonRoute) → RC Extraction → STA
→ Physical Verification (Magic + Netgen) → GDSII
```

The **SKY130 PDK** supplies technology information, standard-cell
libraries and design rules.

## RTL Synthesis

RTL synthesis converts the RTL description into a gate-level netlist.

-   **Yosys** performs synthesis.
-   **ABC** performs logic optimization and technology mapping.
-   The result uses technology-specific standard cells such as gates,
    multiplexers and flip-flops.

## Static Timing Analysis (STA)

STA checks timing paths without exhaustive functional simulation.

``` text
Launch Flip-Flop → Combinational Logic → Capture Flip-Flop
```

Timing reports may contain:

-   Startpoint
-   Endpoint
-   Path type
-   Fanout
-   Capacitance
-   Slew
-   Cell delay
-   Net delay
-   Arrival time

A path reported as `Path Type: max` is a maximum-delay path and is
important for determining the timing limit of the design.

## Physical Design Stages

### Floorplanning

Defines the core/die organization, I/O placement and cell utilization.

Important parameter:

Higher utilization can reduce area but leaves less routing space.

### Placement

Assigns physical locations to standard cells while attempting to reduce
wire length, congestion and timing problems.

### Clock Tree Synthesis (CTS)

Builds the clock distribution network and controls clock skew, insertion
delay and slew.

``` text
Clock Source
     |
  Clock Tree
  /   |    FF1  FF2  FF3
```

### Optimization

Improves timing, congestion, slew, fanout and other physical-design
metrics.

### Global Routing

Determines approximate routing paths and helps identify congestion.

### Detailed Routing

Creates actual metal and via connections while following technology
rules. OpenLane uses **TritonRoute** for detailed routing.

## RC Extraction and Final STA

After routing, parasitic resistance and capacitance are extracted.

``` text
R = Resistance
C = Capacitance
```

These parasitics affect signal delay, so the extracted information is
used for another timing analysis with OpenSTA.

## Physical Verification

OpenLane uses tools such as:

-   **Magic** for layout/physical verification.
-   **Netgen** for LVS/netlist comparison.

## Design for Test (DFT)

Important DFT topics:

-   Scan insertion
-   Automatic Test Pattern Generation (ATPG)
-   Test-pattern compaction
-   Fault coverage
-   Fault simulation

### Scan Chain

``` text
SIN → FF1 → FF2 → FF3 → FF4 → SOUT
```
## Design Exploration

OpenLane can run different implementation configurations and compare
their results.

Important parameters:

  Parameter             Meaning
  --------------------- ---------------------------
  `FP_CORE_UTIL`        Target core utilization
  `ROUTING_STRATEGY`    Routing strategy
  `GLB_RT_ADJUSTMENT`   Global-routing adjustment
  `TR_VIOS`             TritonRoute violations
  `CELL_COUNT`          Number of standard cells
  `RUNTIME`             Execution time

Example exploration results from the module:

  ---------------------------------------------------------------------------------------
  Design      Runtime Cell Count    TR Vios   FP_CORE_UTIL    Routing   GLB_RT_ADJUSTMENT
                                                             Strategy 
  -------- ---------- ---------- ---------- -------------- ---------- -------------------
  aes         1h29m8s      22932          1             40          1                0.05

  aes        1h34m31s      22932          2             30          1                0.05

  aes        1h41m14s      22932          9             40          1                0.05

  aes        1h47m14s      22932          1             45          1                0.05
  ---------------------------------------------------------------------------------------

Design exploration studies trade-offs among area, timing, congestion,
routing quality and runtime.

## Regression Testing

The design-exploration utility can also be used for regression testing
and continuous integration. The module describes running OpenLane on
approximately **70 designs** and comparing results with known-good
results.

Typical metrics include runtime, cell count, routing violations and
timing.

Example results:

  Design            Runtime   Cell Count   TR Vios
  -------------- ---------- ------------ ---------
  jpeg_encoder      3h16m7s        73624         0
  striVe_soc        3h14m0s        73271         0
  aes256           1h35m51s        64435         0
  genericfir        1h2m36s        48849         0
  aes128            1h7m50s        44658         0
  TEA               2h11m8s        44026         0
  rc6_core         1h43m44s        35304         0
  double_sqrt      1h14m18s        29252         0
  iir5sfix          1h14m5s        24950         0
  y_huff           0h54m48s        16826         0
  sha3             0h21m18s        16372         0
  ocs_blitter      0h17m48s        10997         0
  sub86            0h12m35s         7655         0
  CPU               0h11m7s         7342         0
  cordic           0h10m13s         7210         0

`TR Vios = 0` indicates that the reported run completed without
TritonRoute violations.

## SKY130 Standard Cells

Timing reports may contain cells such as:

``` text
sky130_fd_sc_hd__dfxtp_2
sky130_fd_sc_hd__o22ai_2
sky130_fd_sc_hd__a221o_2
sky130_fd_sc_hd__or4_2
sky130_fd_sc_hd__or3_2
sky130_fd_sc_hd__or2_2
```

For example, `sky130_fd_sc_hd__or2_2` is a SKY130 high-density
standard-cell variant implementing a 2-input OR function with a
particular drive-strength variant.

## Practical OpenLane Environment

A typical OpenLane working directory can contain:

``` text
openlane/
├── designs/
├── scripts/
├── configuration/
├── flow.tcl
├── regression_results/
└── README.md
```

A typical practical workflow is:

``` text
Enter OpenLane environment
        ↓
Select design
        ↓
Run flow
        ↓
Inspect reports
        ├── Synthesis
        ├── STA
        ├── Floorplan
        ├── Placement
        ├── CTS
        ├── Routing
        ├── Antenna
        └── DRC/LVS
        ↓
Inspect final results
```

Use the exact commands supplied for the installed OpenLane version and
course environment because command-line options can differ between
releases.

## References

-   OpenLane documentation and training material.
-   SkyWater SKY130 PDK documentation.
-   OpenROAD physical-design documentation.
-   Yosys synthesis documentation.
-   OpenSTA timing-analysis documentation.
-   Magic VLSI documentation.
-   Netgen LVS documentation.

