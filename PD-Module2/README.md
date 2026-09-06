# Module 2 — Good Floorplan vs Bad Floorplan & Introduction to Library Cells

This repository documents **Sky130 Module 2** of the Physical Design training program.  
The module focuses on **floorplanning, placement, power planning, library binding, placement optimization, cell design, library characterization, and timing characterization** using the open-source RTL-to-GDS flow.


# Module Overview

**Sky130 Module 2** introduces the physical-design concepts that occur after synthesis and before the final routed layout.

The major objective is to understand how a synthesized netlist is converted into a physically meaningful implementation by deciding:

- Chip/core dimensions
- Standard-cell utilization
- Aspect ratio
- Placement of pre-placed cells
- Decoupling capacitor placement
- Power distribution
- I/O pin locations
- Placement blockages
- Standard-cell placement
- Library binding
- Placement optimization
- Congestion-aware placement
- Cell design and layout
- Library characterization
- Timing parameters such as transition time and propagation delay

## Chip Floorplanning Considerations

## 1. Floorplanning

Floorplanning is the physical-design stage in which the overall dimensions of the chip/core are decided and major blocks, cells and interfaces are given physical locations.

A simplified physical-design sequence is:

```text
RTL
 |
 v
Synthesis
 |
 v
Gate-Level Netlist
 |
 v
Floorplanning
 |
 v
Placement
 |
 v
CTS
 |
 v
Routing
 |
 v
Physical Verification
 |
 v
GDSII
```

Floorplanning provides the physical foundation for all later stages.

---

## 2. Core and Die Dimensions

The **die** represents the complete chip area, while the **core** contains the main area in which the standard cells and other internal logic are placed.

During floorplanning, the width and height of the core/die are selected according to:

- Number of cells
- Required utilization
- Aspect ratio
- Routing requirements
- I/O requirements
- Power distribution
- Placement congestion
- Blockages and macro locations

---

## 3. Utilization Factor

The utilization factor indicates how much of the available core area is occupied by placed standard-cell area.

### Formula

```text
Utilization Factor =
Area occupied by cells
----------------------
Total available core area
```

### Example

If:

```text
Cell area = 60 units²
Core area = 100 units²
```

then:

```text
Utilization = 60 / 100
            = 0.60
            = 60%
```

A very high utilization can cause:

- Routing congestion
- Difficulty in placement
- Timing degradation
- Less room for optimization

A very low utilization can increase:

- Chip area
- Wire length
- Power distribution area
- Overall cost

Therefore, an appropriate utilization target is important.

---

## 4. Aspect Ratio

The aspect ratio determines the shape of the core.

### Formula

```text
Aspect Ratio = Height / Width
```

For example:

```text
Height = 100 units
Width  = 200 units

Aspect Ratio = 100 / 200
             = 0.5
```

The aspect ratio affects:

- Placement quality
- Routing length
- Congestion
- Power-grid planning
- Overall die shape

---

# 5. Pre-Placed Cells

Some cells or blocks must be assigned fixed physical locations before the normal standard-cell placement process.

These are called **pre-placed cells/blocks**.

Examples include:

- Macros
- Memory blocks
- Analog blocks
- Special interface blocks
- Fixed physical structures

Pre-placement is important because these blocks strongly influence:

- Available placement area
- Routing channels
- Congestion
- Power-grid planning

---

# 6. Decoupling Capacitors

A **decoupling capacitor (decap)** is used to improve local power integrity.

During switching, logic cells can demand a large instantaneous current. Due to resistance and inductance in the power network, the local supply voltage can temporarily drop.

A decap provides a local source of charge and helps reduce supply-voltage fluctuations.

### Basic concept

```text
VDD
 |
 +------ Decap ------+
 |                   |
Logic Cell          GND
```

### Why decaps are useful

They help:

- Reduce local voltage fluctuations
- Supply transient current
- Improve power integrity
- Reduce the impact of supply noise

Decap cells are generally placed near regions where switching activity and power demand require better local supply stability.

---

# 7. Power Planning

Power planning creates the power-delivery network needed to distribute:

- VDD
- VSS/GND

to the cells across the chip.

A simplified hierarchy is:

```text
Power Source
     |
     v
Power Ring
     |
     v
Power Straps
     |
     v
Standard-Cell Rails
     |
     v
Individual Cells
```

The power network must be designed so that voltage drop and current-density problems remain within acceptable limits.

---

# 8. Pin Placement

I/O pins are placed around the die/core boundary according to:

- Connectivity
- Timing requirements
- Routing resources
- Signal direction
- Power/ground requirements
- Physical constraints

Good pin placement can reduce:

- Wire length
- Routing congestion
- Delay
- Crosstalk

Poor pin placement can create long routes and routing hotspots.

---

# 9. Placement Blockages

Placement blockages prevent cells from being placed in selected physical regions.

They can be used around:

- Macros
- Reserved routing areas
- Power structures
- Special circuits
- High-congestion regions

### Concept

```text
+---------------------------+
| Standard-cell area        |
|                           |
|   +-------------------+   |
|   | Placement         |   |
|   | Blockage          |   |
|   +-------------------+   |
|                           |
+---------------------------+
```

Blockages help the placement tool avoid physically unsuitable regions.

---

# Library Binding and Placement

# 10. Netlist Binding With Physical Cells

After synthesis, the design exists as a logical gate-level netlist.

The placement stage needs physical representations of these cells.

The logical cells are therefore associated/bound with their corresponding physical standard-cell implementations from the technology library.

```text
Logical Netlist
      |
      v
Library Cell Binding
      |
      v
Physical Standard Cells
      |
      v
Placement
```

A standard-cell library provides information such as:

- Cell functionality
- Physical dimensions
- Pin locations
- Timing information
- Power information
- Design-rule information

---

# 11.  Placement Optimization

Placement is not simply about fitting cells inside the core.

The placement engine attempts to optimize several objectives, including:

- Wire length
- Timing
- Congestion
- Cell density
- Capacitance
- Power

### Estimated Wire Length

Shorter connections generally help reduce:

- Wire resistance
- Wire capacitance
- Delay
- Dynamic power

Therefore, placement tools try to keep strongly connected cells physically close when possible.

---

# 12. Final Placement Optimization

After initial placement, optimization is performed to improve the physical implementation.

Typical objectives include:

- Reducing congestion
- Improving timing
- Reducing wire length
- Improving cell density
- Fixing placement-related violations

The final placement should provide a good starting point for clock-tree synthesis and routing.

---

# Cell Design and Characterization Flows

# 13. Need for Standard-Cell Libraries

Digital designs are constructed from reusable standard cells such as:

- Inverters
- NAND gates
- NOR gates
- AND/OR cells
- Buffers
- Flip-flops
- Latches
- Tie cells
- Filler cells
- Decoupling cells

Each cell requires accurate electrical and physical models so that EDA tools can estimate:

- Delay
- Slew/transition
- Power
- Noise
- Area

---


# General Timing Characterization Parameters

# 14. Timing Threshold Definitions

Timing characterization requires defined voltage thresholds for measuring transitions.

The provided timing-characterization example uses:

| Parameter | Threshold |
|---|---:|
| `slew_low_rise_thr` | 20% |
| `slew_high_rise_thr` | 80% |
| `slew_low_fall_thr` | 20% |
| `slew_high_fall_thr` | 80% |
| `in_rise_thr` | 50% |
| `in_fall_thr` | 50% |
| `out_rise_thr` | 50% |
| `out_fall_thr` | 50% |

For a supply voltage of approximately **1.8 V**:

```text
20% of VDD ≈ 0.36 V
80% of VDD ≈ 1.44 V
50% of VDD ≈ 0.90 V
```

The timing waveform example shows the 20% and 80% thresholds at approximately **0.36 V and 1.44 V**.

---

# 15. Transition Time

Transition time represents how quickly a signal changes between two voltage thresholds.

For a rising output:

```text
Transition time =
Time at 80% VDD - Time at 20% VDD
```

For a falling output:

```text
Transition time =
Time at 20% VDD - Time at 80% VDD
```

Using 20% and 80% thresholds avoids measuring extremely close to the supply rails.


# 16. Propagation Delay

Propagation delay represents the time difference between a specified input transition and the corresponding output transition.

With 50% input and output thresholds:

```text
Propagation delay =
Output 50% crossing time
-
Input 50% crossing time
```

The delay is measured separately for:

- Rising input → rising output
- Falling input → falling output

Depending on the cell, additional timing arcs may exist.

---


### Conceptual comparison

```text
GOOD FLOORPLAN                    BAD FLOORPLAN

+----------------------+          +----------------------+
| I/O   Logic   I/O    |          | I/O            I/O   |
|                      |          |      XXXXXXXX        |
|  Logic   Macro       |          | XXXXX  Macro XXXXX   |
|          +-----+     |          | XXXXX        XXXXX   |
|  Logic   |     |     |          |   XXXXXXX XXXXX      |
|          +-----+     |          |      Congestion      |
| I/O   Logic   I/O    |          | I/O            I/O   |
+----------------------+          +----------------------+
```

The objective is not merely to minimize area. The floorplan must also support **timing, routing, power integrity and manufacturability**.

---

# OpenLANE Floorplan Flow

The module includes practical steps for running and reviewing floorplanning using OpenLANE.

A typical flow is:

```text
Design Setup
     |
     v
Configuration
     |
     v
Synthesis
     |
     v
Floorplan
     |
     v
Placement
     |
     v
Floorplan Review
     |
     v
Magic Layout Review
```

## Typical OpenLANE Work Sequence

1. Enter the OpenLANE environment.
2. Select the target design.
3. Load the design configuration.
4. Start the OpenLANE flow.
5. Run synthesis/floorplanning as required.
6. Inspect generated reports.
7. Review the floorplan.
8. Open the layout in Magic.
9. Check dimensions, rows, pins and placement.

> **Note:** Exact commands can depend on the OpenLANE/OpenROAD version and the course setup. Use the commands supplied with the specific VSDIAT environment for the installed version.

---

