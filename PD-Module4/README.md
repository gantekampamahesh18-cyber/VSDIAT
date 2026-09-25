# Sky130 Module 4 – Pre-layout Timing Analysis and Importance of Good Clock Trees

![VSDIAT](https://vsdiat.vlsisystemdesign.com/logo-dark.png)

## Anurag Institute Chip Design Program – Physical Design

Module 4 focuses on **timing analysis before and after clock-tree synthesis**, timing-library concepts, delay tables, OpenSTA, synthesis optimization, clock uncertainty, setup and hold timing, TritonCTS, and real-clock timing analysis.

This module connects standard-cell characterization from Module 3 with timing-driven digital implementation.

---

# Module Objectives

- Understand timing modelling using delay tables.
- Understand the relationship between standard-cell timing libraries and synthesis.
- Understand grid information and routing tracks.
- Convert Magic layout information into standard-cell LEF.
- Understand timing libraries and their use in synthesis.
- Understand delay-table concepts and their usage.
- Configure OpenSTA for post-synthesis timing analysis.
- Understand setup time and hold time.
- Understand clock jitter and clock uncertainty.
- Optimize synthesis to reduce timing violations.
- Understand basic timing ECO concepts.
- Understand clock-tree synthesis using TritonCTS.
- Understand clock buffering and H-tree concepts.
- Understand crosstalk and clock-net shielding.
- Run and verify CTS.
- Analyze timing using real clocks after CTS.
- Observe the effect of CTS buffer sizing on setup and hold timing.

---

# Module Structure

Module 4 is divided into four sections:

1. **SKY130_D4_SK1 – Timing Modelling Using Delay Tables**
2. **SKY130_D4_SK2 – Timing Analysis with Ideal Clocks Using OpenSTA**
3. **SKY130_D4_SK3 – Clock Tree Synthesis Using TritonCTS and Signal Integrity**
4. **SKY130_D4_SK4 – Timing Analysis with Real Clocks Using OpenSTA**

---

# SKY130_D4_SK1 – Timing Modelling Using Delay Tables

This section introduces the timing information required to model standard cells and use them during synthesis and timing analysis.

## Labs Covered

### SKY_L1 – Lab Steps to Convert Grid Information to Track Information

Understanding how layout grid information is related to routing-track information used by physical-design tools.

### SKY_L2 – Lab Steps to Convert Magic Layout to Standard Cell LEF

Converting the physical layout representation into an abstract standard-cell LEF representation.

The LEF provides physical information required by downstream physical-design tools.

### SKY_L3 – Introduction to Timing Libraries and Steps to Include New Cell in Synthesis

Introduction to timing libraries and the information required to include a newly designed standard cell in synthesis.

The timing library provides information about the electrical and timing behavior of cells.

### SKY_L4 – Introduction to Delay Tables

Introduction to delay tables used to represent cell timing behavior.

Delay depends on conditions such as:

- Input transition
- Output load
- Cell characteristics

### SKY_L5 – Delay Table Usage – Part 1

Understanding how delay-table information is interpreted and used for timing analysis.

### SKY_L6 – Delay Table Usage – Part 2

Further study of delay-table usage in timing modelling.

### SKY_L7 – Lab Steps to Configure Synthesis Settings to Fix Slack and Include `vsdinv`

Configuring synthesis settings to include the designed inverter cell and improve timing slack.

---

# SKY130_D4_SK2 – Timing Analysis with Ideal Clocks Using OpenSTA

This section introduces static timing analysis using OpenSTA before considering clock-tree delay.

## Labs Covered

### SKY_L1 – Setup Timing Analysis and Introduction to Flip-Flop Setup Times

Introduction to setup timing and the setup-time requirement of sequential elements.

The basic setup relationship is:

```text
Data must arrive
      ↓
before the active clock edge
      ↓
by at least the required setup time
```

### SKY_L2 – Introduction to Clock Jitter and Uncertainty

Understanding clock jitter and uncertainty and their impact on timing analysis.

Clock uncertainty accounts for variations in the effective arrival time of the clock.

### SKY_L3 – Lab Steps to Configure OpenSTA for Post-Synth Timing Analysis

Configuring OpenSTA for post-synthesis timing analysis.

The analysis uses:

- Synthesized netlist
- Timing libraries
- Timing constraints
- Clock definitions

The basic flow is:

```text
RTL
 ↓
Synthesis
 ↓
Synthesized Netlist
 ↓
SDC Constraints
 ↓
Timing Libraries
 ↓
OpenSTA
 ↓
Timing Reports
```

### SKY_L4 – Lab Steps to Optimize Synthesis to Reduce Setup Violations

Using synthesis configuration and optimization techniques to reduce setup timing violations.

The goal is to improve timing slack while maintaining correct functionality.

### SKY_L5 – Lab Steps to Do Basic Timing ECO

Introduction to basic timing Engineering Change Order (ECO) techniques used to modify the implementation to address timing problems.

---

# SKY130_D4_SK3 – Clock Tree Synthesis, TritonCTS and Signal Integrity

This section introduces clock-tree synthesis and the importance of distributing the clock signal properly across sequential elements.

## Labs Covered

### SKY_L1 – Clock Tree Routing and Buffering Using H-Tree Algorithm

Introduction to clock-tree routing and buffering.

The clock network must distribute the clock signal to multiple sequential elements while controlling differences in clock arrival time.

Important concepts include:

- Clock tree
- Clock buffers
- Clock distribution
- Clock skew
- H-tree structure

### SKY_L2 – Crosstalk and Clock Net Shielding

Introduction to signal integrity effects on clock networks.

Topics include:

- Crosstalk
- Coupling
- Clock-net interference
- Shielding

Clock nets are particularly important because timing of sequential elements depends directly on clock arrival.

### SKY_L3 – Lab Steps to Run CTS Using TritonCTS

Running clock-tree synthesis using TritonCTS.

The basic flow is:

```text
Placed Design
     ↓
Clock Network
     ↓
TritonCTS
     ↓
Clock Buffers
     ↓
Clock Tree
```

### SKY_L4 – Lab Steps to Verify CTS Runs

Verification of the CTS result and examination of the resulting clock network.

---

# SKY130_D4_SK4 – Timing Analysis with Real Clocks Using OpenSTA

This section extends timing analysis from ideal clocks to clocks containing the effects of the implemented clock tree.

## Labs Covered

### SKY_L1 – Setup Timing Analysis Using Real Clocks

Analyzing setup timing after the clock network has been physically implemented.

### SKY_L2 – Hold Timing Analysis Using Real Clocks

Analyzing hold timing using the real clock arrival times produced by the clock tree.

### SKY_L3 – Lab Steps to Analyze Timing with Real Clocks Using OpenSTA

Using OpenSTA to analyze timing after CTS.

The analysis considers:

```text
Data Path
    +
Clock Path
    +
Cell Delays
    +
Clock Network
    ↓
Timing Analysis
```

### SKY_L4 – Lab Steps to Execute OpenSTA with Right Timing Libraries and CTS Assignment

Configuring OpenSTA with the appropriate timing libraries and CTS information.

### SKY_L5 – Lab Steps to Observe Impact of Bigger CTS Buffers on Setup and Hold Timing

Studying how changing CTS buffer sizes affects setup and hold timing.

This demonstrates the trade-offs involved in clock-tree optimization.

---

# Timing Analysis Flow

The overall Module 4 timing flow can be represented as:

```text
Standard Cell Characterization
             │
             ▼
       Timing Libraries
             │
             ▼
       Synthesis
             │
             ▼
   Post-Synthesis Netlist
             │
             ▼
     Ideal Clock STA
             │
             ▼
    Setup / Hold Analysis
             │
             ▼
     Synthesis Optimization
             │
             ▼
       Placement
             │
             ▼
          CTS
             │
             ▼
     Real Clock Network
             │
             ▼
       Real Clock STA
             │
             ▼
   Setup / Hold Verification
```

---

# Important Timing Concepts

## Setup Time

Setup time is the minimum amount of time for which data must be stable before the active clock edge at a sequential element.

A setup violation occurs when data does not arrive early enough relative to the capturing clock edge.

---

## Hold Time

Hold time is the minimum amount of time for which data must remain stable after the active clock edge.

A hold violation occurs when data changes too soon after the capturing clock edge.

---

## Clock Jitter

Clock jitter represents variation in the timing of the clock edge.

It contributes to uncertainty in the effective clock arrival time.

---

## Clock Uncertainty

Clock uncertainty represents timing margin associated with clock variations and other uncertainty components used during STA.

---

## Clock Skew

Clock skew is the difference in clock arrival time between two sequential elements.

```text
Clock Source
     │
     ├──────────────► Flip-Flop A
     │                  Clock Arrival A
     │
     └──────────────► Flip-Flop B
                        Clock Arrival B

Clock Skew = Difference between arrival times
```

Clock-tree synthesis attempts to construct a clock network with controlled skew and acceptable timing characteristics.

---

# Timing Libraries

Timing libraries provide cell-level information used by synthesis and static timing analysis.

They can contain information related to:

- Cell timing
- Input transition
- Output load
- Delay
- Timing arcs
- Setup time
- Hold time
- Power-related characteristics

The timing library connects standard-cell characterization to digital timing analysis.

---

# Delay Tables

Delay tables represent cell delay as a function of factors such as:

```text
Input Transition
        +
Output Load
        ↓
Cell Delay
```

The timing engine uses this information to calculate delays through standard cells.

---

# Ideal Clock vs Real Clock

## Ideal Clock

In ideal-clock analysis, the clock is treated as an ideal source without the physical delay introduced by an implemented clock tree.

```text
Clock Source
     │
     ├────────► Sequential Element A
     │
     └────────► Sequential Element B
```

## Real Clock

After CTS, the clock is distributed through an actual network containing clock buffers and routing.

```text
Clock Source
     │
     ▼
Clock Tree
  ├── Buffer ──► FF A
  │
  └── Buffer ──► FF B
```

The resulting clock arrival times are then considered during timing analysis.

---

# OpenSTA Timing Flow

The OpenSTA timing-analysis environment uses the design netlist, timing libraries, and constraints to calculate timing paths.

```text
Synthesized Netlist
        │
        ├──────────────┐
        │              │
        ▼              ▼
Timing Libraries      SDC
        │              │
        └──────┬───────┘
               ▼
             OpenSTA
               │
               ▼
        Timing Reports
```

Important timing quantities include:

- Arrival time
- Required arrival time
- Slack
- Setup violation
- Hold violation
- Clock arrival
- Data-path delay

---

# Slack

Slack represents the timing margin of a path.

Conceptually:

```text
Slack = Required Time - Arrival Time
```

For a setup path:

- Positive slack indicates timing margin.
- Zero slack indicates the path is at the timing boundary.
- Negative slack indicates a setup timing violation.

Timing optimization attempts to eliminate negative slack while satisfying the design constraints.

---

# Clock Tree Synthesis

Clock Tree Synthesis (CTS) creates a clock distribution network from the clock source to the sequential elements.

The CTS process can insert clock buffers to control:

- Clock delay
- Clock skew
- Clock transition
- Clock fanout

TritonCTS is used in the Sky130 physical-design flow to implement the clock network.

---

# Signal Integrity

Clock signals can be affected by neighboring signal nets through capacitive coupling.

Important concepts include:

- Crosstalk
- Coupling
- Noise
- Shielding

Clock-net shielding can be used to reduce coupling from neighboring signal routes.

---

# Timing Optimization

Timing optimization can involve changes at different stages of the flow.

Examples include:

- Cell selection
- Cell sizing
- Buffer insertion
- Synthesis optimization
- Clock-buffer selection
- Routing optimization
- Timing ECO

The objective is to meet timing constraints without compromising the required functionality and implementation constraints.

---

# Module 4 Design Flow

```text
Module 3
Standard Cell Design
        │
        ▼
Timing Characterization
        │
        ▼
Timing Libraries
        │
        ▼
Synthesis
        │
        ▼
Ideal Clock STA
        │
        ▼
Timing Optimization
        │
        ▼
Placement
        │
        ▼
TritonCTS
        │
        ▼
Real Clock Network
        │
        ▼
Real Clock STA
        │
        ▼
Setup / Hold Analysis
```

---

# Key Concepts Learned

- Timing modelling
- Standard-cell LEF
- Timing libraries
- Delay tables
- Input transition
- Output load
- Cell delay
- Post-synthesis STA
- OpenSTA
- Setup time
- Hold time
- Clock jitter
- Clock uncertainty
- Clock skew
- Timing slack
- Timing violations
- Synthesis timing optimization
- Timing ECO
- Clock-tree synthesis
- TritonCTS
- Clock buffering
- H-tree concepts
- Crosstalk
- Clock shielding
- Ideal-clock analysis
- Real-clock analysis
- Setup analysis with real clocks
- Hold analysis with real clocks

---

# Module 4 Outcome

Module 4 establishes the connection between **standard-cell timing characterization and complete timing analysis of a digital design**.

The module progresses from:

**Timing libraries → delay modelling → synthesis → ideal-clock STA → timing optimization → CTS → real-clock STA → setup/hold analysis**

This provides the timing foundation required for the routing and final RTL-to-GDS stages covered in Module 5.

---

# Repository Organization

```text
Module-4/
│
├── README.md
│
├── SKY130_D4_SK1_Timing_Modelling/
│
├── SKY130_D4_SK2_OpenSTA_Ideal_Clocks/
│
├── SKY130_D4_SK3_TritonCTS/
│
└── SKY130_D4_SK4_OpenSTA_Real_Clocks/
```

Screenshots, OpenSTA reports, timing-library files, CTS reports, scripts, and other evidence will be added to their respective sections.

---

## Next Module

**Sky130 Module 5 – Final Steps for RTL2GDS Using TritonRoute and OpenSTA**

Module 5 moves into:

- Routing
- Design Rule Checking
- Power Distribution Network
- Global and detailed routing
- TritonRoute
- Routing verification
- Final physical-design results
