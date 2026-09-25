# Sky130 Module 3 – Design Library Cell Using Magic Layout and ngspice Characterization

![VSDIAT](https://vsdiat.vlsisystemdesign.com/logo-dark.png)

## Anurag Institute Chip Design Program – Physical Design

This module covers CMOS inverter simulation, CMOS fabrication-process understanding, physical layout, Sky130 technology files, DRC, SPICE extraction, and standard-cell characterization using **ngspice**, **Magic**, and the **Sky130 PDK**.

---

## Module Objectives

- Understand CMOS inverter operation.
- Create and analyze SPICE decks.
- Perform DC and transient simulations using ngspice.
- Understand the CMOS inverter switching threshold (`Vm`).
- Study static and dynamic CMOS inverter behavior.
- Understand the CMOS fabrication process step by step.
- Relate fabrication steps to physical layout layers.
- Learn basic Sky130 layout layers.
- Create and inspect CMOS inverter layouts using Magic.
- Understand Sky130 technology files and DRC rules.
- Extract a SPICE netlist from physical layout.
- Understand the relationship between layout, extracted netlist, and circuit simulation.
- Understand the basic standard-cell design and characterization flow.

---

# Module Structure

Module 3 is divided into three sections:

1. **SKY130_D3_SK1 – CMOS Inverter ngspice Simulations**
2. **SKY130_D3_SK2 – Inception of Layout – CMOS Fabrication Process**
3. **SKY130_D3_SK3 – Sky130 Tech File Labs**

---

# SKY130_D3_SK1 – CMOS Inverter ngspice Simulations

This section introduces CMOS inverter simulation using SPICE and ngspice.

## Labs Covered

### SKY_L0 – IO Placer Revisions

Understanding the revisions related to IO placement and the standard-cell design environment.

### SKY_L1 – SPICE Deck Creation for CMOS Inverters

Creation of a SPICE simulation deck containing the required PMOS, NMOS, input source, power supply, output node, technology/model information, and simulation commands.

### SKY_L2 – SPICE Simulation Lab for CMOS Inverters

Running the CMOS inverter simulation using ngspice and observing the circuit response.

```text
Input Voltage
     ↓
CMOS Transistor Operation
     ↓
Output Voltage
```

### SKY_L3 – Switching Threshold `Vm`

Study of the CMOS inverter switching threshold using the DC transfer characteristic.

### SKY_L4 – Static and Dynamic Simulation of CMOS Inverters

Study of:

- Static/DC behavior
- Dynamic/transient behavior

### SKY_L5 – Lab Steps to Git Clone `vsdstdcelldesign`

Cloning and setting up the standard-cell design environment used for subsequent layout and characterization work.

---

# SKY130_D3_SK2 – Inception of Layout – CMOS Fabrication Process

This section explains the CMOS fabrication process step by step and connects the fabrication process to the physical layout of a CMOS inverter.

The CMOS inverter contains both PMOS and NMOS devices. The fabrication process creates the semiconductor regions, gate structures, source/drain regions, local interconnects, and metal interconnections required to implement these devices.

## Fabrication Sequence

### 01 – Create Active Regions

The first stage is the creation and definition of the active regions where transistor devices will be formed.

```text
Silicon substrate
       ↓
Active region definition
       ↓
Transistor formation area
```

### 02 – Formation of N-Well and P-Well

The required wells are formed to provide the appropriate semiconductor regions for CMOS devices.

```text
PMOS → N-Well region
NMOS → P-Well / substrate region
```

### 03 – Formation of Gate Terminal

The gate structure is formed over the active region. The gate controls the conductivity of the MOS transistor.

For the CMOS inverter, the PMOS and NMOS gates are connected to the same input signal.

```text
             IN
              │
        ┌─────┴─────┐
        │           │
       PMOS        NMOS
        │           │
        └─────┬─────┘
              │
             OUT
```

### 04 – Lightly Doped Drain (LDD) Formation

Lightly doped regions are formed around the source and drain regions. The LDD structure is part of the process used to control electric-field effects near the drain region.

### 05 – Source–Drain Formation

The source and drain regions are formed using the appropriate doping process.

```text
PMOS
 ├── Source → VDD
 ├── Gate   → IN
 └── Drain  → OUT

NMOS
 ├── Drain  → OUT
 ├── Gate   → IN
 └── Source → GND
```

### 06 – Local Interconnect Formation

Local interconnect structures are formed to connect transistor terminals.

The physical layout establishes connections between the PMOS, NMOS, input, output, VDD, and GND.

```text
VDD
 │
PMOS
 │
OUT
 │
NMOS
 │
GND
```

### 07 – Higher-Level Metal Formation

Higher-level metal layers are used for signal and power routing between cells and to external connections.

### 08 – Sky130 Basic Layers Layout and LEF

The Sky130 technology defines the physical layers used by layout tools, including active/diffusion, wells, polysilicon, local interconnect, contacts, and metal layers.

**LEF (Library Exchange Format)** represents abstract physical information about a standard cell for use in physical design tools.

### 09 – Create Standard Cell Layout and Extract SPICE Netlist

The physical layout is created and checked, then extracted into a SPICE-compatible representation.

```text
CMOS schematic
      ↓
Physical layout
      ↓
Magic extraction
      ↓
Extracted SPICE netlist
      ↓
ngspice simulation
```

---

# SKY130_D3_SK3 – Sky130 Tech File Labs

This section focuses on Sky130 technology files, Magic, technology rules, DRC, and inverter characterization.

## Labs Covered

### SKY_L1 – Lab Steps to Create Final SPICE Deck Using Sky130 Tech

Creating the final SPICE deck using Sky130 technology information.

### SKY_L2 – Lab Steps to Characterize Inverter Using Sky130 Model Files

Using Sky130 model files to characterize the CMOS inverter.

### SKY_L3 – Lab Introduction to Magic Tool Options and DRC Rules

Introduction to Magic and the design-rule-checking environment.

### SKY_L4 – Lab Introduction to Sky130 PDK and Steps to Download Labs

Introduction to the Sky130 PDK and required lab environment.

### SKY_L5 – Lab Introduction to Magic and Steps to Load Sky130 Tech-Rules

Loading Sky130 technology information into Magic so that the layout can be interpreted and checked using the appropriate technology rules.

### SKY_L6 – Lab Exercise to Fix `poly.9` Error in Sky130 Tech-Files

Study and correction of a Sky130 technology-file DRC issue involving the `poly.9` rule.

### SKY_L7 – Lab Exercise to Implement Poly Resistor Spacing to Diff and Taps

Study of spacing requirements involving poly, diffusion, and taps.

### SKY_L8 – Lab Challenge Exercise to Describe DRC Error as Geometrical Construct

Understanding DRC violations as physical geometrical relationships rather than simply software error messages.

### SKY_L9 – Lab Challenge to Find Missing or Incorrect Rules and Fix Them

Analysis of technology rules to identify missing or incorrect rules and understand their effect on physical verification.

---

# CMOS Inverter Design Flow

```text
CMOS Inverter Concept
        │
        ▼
SPICE Deck Creation
        │
        ▼
ngspice Simulation
        │
        ▼
DC / Transient Analysis
        │
        ▼
Switching Threshold (Vm)
        │
        ▼
CMOS Fabrication Understanding
        │
        ▼
Physical Layout
        │
        ▼
Magic
        │
        ▼
Sky130 DRC
        │
        ▼
SPICE Extraction
        │
        ▼
Extracted Netlist
        │
        ▼
Characterization
        │
        ▼
Standard Cell
```

---

# CMOS Inverter Logic

The basic CMOS inverter implements the NOT operation.

| Input | PMOS | NMOS | Output |
|------:|------|------|--------|
| 0 | ON | OFF | 1 |
| 1 | OFF | ON | 0 |

Therefore:

```text
OUT = NOT(IN)
```

---

# Connection Between Simulation and Layout

The CMOS inverter is studied at multiple abstraction levels:

```text
Transistor Level
       │
       ▼
SPICE Model
       │
       ▼
Electrical Simulation
       │
       ▼
Physical Layout
       │
       ▼
Extracted Circuit
       │
       ▼
Standard Cell
```

This connects electrical behavior with physical implementation.

---

# Tools and Technologies

- **ngspice**
- **Magic**
- **Sky130 PDK**
- **SPICE**
- **Sky130 technology files**
- **LEF**
- **DRC**
- **SPICE extraction**

---

# Key Concepts Learned

- CMOS inverter operation
- PMOS and NMOS complementary operation
- SPICE deck construction
- ngspice simulation
- DC transfer characteristics
- Switching threshold voltage
- Static CMOS behavior
- Dynamic CMOS behavior
- CMOS fabrication sequence
- Active regions
- N-well and P-well
- Gate formation
- LDD formation
- Source/drain formation
- Local interconnect
- Metal layers
- Physical layout
- Sky130 technology layers
- LEF
- Magic
- DRC
- SPICE extraction
- Standard-cell design
- Cell characterization

---

# Module 3 Outcome

Module 3 establishes the connection between:

**Transistor-level circuit design → electrical simulation → semiconductor fabrication → physical layout → extraction → standard-cell characterization**

This forms an important foundation for the timing analysis, synthesis, clock-tree, routing, and RTL-to-GDS flow covered in later Sky130 modules.

---

# Repository Organization

```text
Module-3/
│
├── README.md
│
├── SKY130_D3_SK1_CMOS_Inverter_ngspice/
│
├── SKY130_D3_SK2_CMOS_Fabrication_Process/
│
└── SKY130_D3_SK3_Sky130_Tech_Files/
```

Screenshots, simulation outputs, layout files, reports, and other evidence will be added to their respective sections.

---

