![VSDIAT](https://vsdiat.vlsisystemdesign.com/logo-dark.png)

# Sky130 Module 5 – Final Steps for RTL2GDS using TritonRoute and OpenSTA

## VSDIAT – ASIC / VLSI Core Training

Module 5 focuses on the final stages of the **RTL-to-GDSII flow**, with emphasis on **detailed routing, Design Rule Checking (DRC), Power Distribution Network (PDN), and TritonRoute**.

---

## 🎯 Objectives

The main objectives of this module are to:

- Understand the basics of **maze routing**.
- Study **Lee's routing algorithm**.
- Understand the purpose of **Design Rule Check (DRC)**.
- Build and understand the **Power Distribution Network (PDN)**.
- Understand how power straps connect to standard-cell power rails.
- Learn the basics of **global routing and detailed routing**.
- Configure **TritonRoute** for detailed routing.
- Understand important TritonRoute routing features.
- Understand routing-guide processing and connectivity handling.
- Understand routing topology generation and post-route files.
- Connect routing concepts with the complete **RTL-to-GDSII physical-design flow**.

---

# 📌 SKY130_D5_SK1 – Routing and Design Rule Check (DRC)

This section introduces the fundamental concepts behind routing and physical verification.

## 🔹 SKY_L1 – Introduction to Maze Routing – Lee's Algorithm

This lesson introduces **maze routing** and the **Lee routing algorithm**.

### Key Topics

- Maze-routing concept
- Routing between source and destination points
- Grid-based routing
- Expansion of routing paths
- Finding a connected path through the routing grid
- Understanding routing as a constrained path-finding problem

**Lee's algorithm** provides a systematic approach for finding a route between two points while maintaining connectivity through the routing grid.

### Why It Matters in ASIC Design

Routing converts logical connectivity into physical metal interconnects. Understanding maze routing provides the foundation for understanding how automated routers determine physical wire paths.

---

## 🔹 SKY_L2 – Lee's Algorithm Conclusion

This lesson concludes the study of Lee's algorithm and connects the algorithmic concept to practical routing.

### Important Concepts

- Path exploration
- Connectivity
- Routing grids
- Obstacles and routing constraints
- Route generation
- Relationship between routing algorithms and physical implementation

These concepts form the basis for understanding automated **global and detailed routing tools**.

---

## 🔹 SKY_L3 – Design Rule Check

**Design Rule Check (DRC)** verifies whether the physical layout satisfies the manufacturing rules defined by the technology.

### Important Concepts

- Minimum spacing
- Minimum width
- Layer-specific rules
- Via-related rules
- Metal geometry constraints
- Manufacturing-related layout restrictions

### Why DRC Matters

A layout can be logically correct while still violating manufacturing constraints. DRC checks the physical geometry against the technology design rules before fabrication.

Therefore, DRC is an important **physical-verification step** in the ASIC flow.

---

# ⚡ SKY130_D5_SK2 – Power Distribution Network and Routing

This section introduces power distribution and the transition from power planning to signal routing.

## 🔹 SKY_L1 – Build Power Distribution Network

The **Power Distribution Network (PDN)** distributes power and ground throughout the chip.

### Important Concepts

- Power and ground networks
- Power straps
- Power rings
- Standard-cell power connections
- Distribution of supply voltage across the design
- Physical power delivery

### Why PDN Matters

Every standard cell requires stable power and ground connections. The PDN provides the physical infrastructure required to distribute these supplies across the chip.

A properly constructed PDN is essential for reliable physical implementation.

---

## 🔹 SKY_L2 – From Power Straps to Standard-Cell Power

This lesson explains how higher-level power structures connect to the power rails of standard cells.

### Power Distribution Hierarchy

```text
Power Sources
      ↓
Power Distribution Network
      ↓
Power Straps / Rings
      ↓
Standard-Cell Power Rails
      ↓
Individual Standard Cells
```

### Important Concepts

- Power straps
- Standard-cell VDD/VSS rails
- Power connectivity
- Physical power distribution
- Interaction between PDN and standard-cell placement

---

## 🔹 SKY_L3 – Basics of Global and Detailed Routing and Configure TritonRoute

Routing is generally divided into two major stages.

### 🌐 Global Routing

Global routing determines approximate routing paths and routing resources.

It considers:

- Connectivity
- Routing regions
- Routing capacity
- Congestion
- Approximate paths

### 🛠️ Detailed Routing

Detailed routing converts global-routing information into actual physical wire and via geometries while satisfying detailed routing constraints.

It considers:

- Exact wire locations
- Metal layers
- Via placement
- Design rules
- Connectivity
- Routing constraints

### TritonRoute

**TritonRoute** is used for detailed routing in the RTL-to-GDSII physical-design flow.

The routing stage connects the placed cells according to the design netlist and produces the physical routed representation of the design.

---

# 🚦 SKY130_D5_SK3 – TritonRoute Features

This section studies important features and mechanisms used by TritonRoute during detailed routing.

## 🔹 SKY_L1 – TritonRoute Feature 1: Honors Pre-Processed Route Guides

TritonRoute uses routing-guide information generated during the routing flow.

### Important Concepts

- Route guides
- Pre-processed routing information
- Routing constraints
- Guide-based detailed routing

Route guides provide information that helps the detailed router determine where connections should be routed.

---

## 🔹 SKY_L2 – Features 2 & 3: Inter-Guide Connectivity and Intra-/Inter-Layer Routing

This lesson covers routing connectivity across guides and routing across different metal layers.

### Inter-Guide Connectivity

The router must maintain connectivity between different routing-guide regions so that the final routed net remains electrically connected.

### Intra-Layer Routing

Routing within the same metal layer must satisfy:

- Connectivity requirements
- Geometrical constraints
- Design rules

### Inter-Layer Routing

Connections between different metal layers require **vias**.

```text
Metal Layer
     ↓
    Via
     ↓
Another Metal Layer
```

These mechanisms allow complex nets to be routed across multiple routing layers.

---

## 🔹 SKY_L3 – TritonRoute Method to Handle Connectivity

This lesson focuses on how TritonRoute maintains electrical connectivity while converting routing information into physical routes.

### Important Concepts

- Net connectivity
- Guide connectivity
- Routing topology
- Layer transitions
- Via insertion
- Connectivity verification

The router must ensure that the final physical route represents the intended logical net connectivity.

---

## 🔹 SKY_L4 – Routing Topology Algorithm and Final Files List Post-Route

The final lesson examines routing topology and the files generated after routing.

### Important Concepts

- Routing topology
- Detailed route generation
- Post-route physical data
- Routed DEF
- Routing reports
- Physical verification data

A typical post-route implementation contains physical data representing the routed design and supporting reports used for verification and further analysis.

---

# 🔄 Routing Flow

The major physical-design sequence covered by this module can be summarized as:

```text
Placed Design
      ↓
Power Distribution Network
      ↓
Global Routing
      ↓
Route Guides
      ↓
Detailed Routing
      ↓
TritonRoute
      ↓
DRC / Physical Verification
      ↓
Post-Route Design
```

---

# 📚 Important Concepts

## Maze Routing

Maze routing treats routing as a **path-finding problem** through a constrained routing grid.

## Lee's Algorithm

Lee's algorithm systematically explores a routing grid to find a connected path between source and destination.

## Global Routing

Global routing determines approximate routing paths and resource usage.

## Detailed Routing

Detailed routing creates the actual physical wires and vias while satisfying routing constraints and design rules.

## PDN

The **Power Distribution Network** provides physical VDD and VSS distribution throughout the design.

## DRC

**Design Rule Check** verifies physical layout geometry against the technology's manufacturing rules.

## Route Guides

Route guides provide routing information that helps the detailed router construct physical routes.

## TritonRoute

TritonRoute performs detailed routing and generates the routed physical representation of the design.

---

# 🔗 Relationship to the RTL-to-GDSII Flow

Module 5 represents the final physical implementation stages of the RTL-to-GDSII process.

```text
RTL
 ↓
Synthesis
 ↓
Floorplan
 ↓
Power Planning
 ↓
Placement
 ↓
Clock Tree Synthesis
 ↓
Global Routing
 ↓
Detailed Routing
 ↓
DRC / Physical Verification
 ↓
GDSII
```

The earlier modules establish the design, timing, standard-cell, and physical-design foundations required to reach this stage.

---

# ✅ Module Outcome

After completing Module 5, the learner should understand:

- The purpose of maze routing.
- The basic operation of Lee's routing algorithm.
- Why DRC is required.
- The purpose and structure of a PDN.
- How power straps connect to standard-cell power rails.
- The difference between global routing and detailed routing.
- The role of TritonRoute.
- How route guides assist detailed routing.
- How inter-guide and inter-layer connectivity are handled.
- The role of vias in layer transitions.
- How routing topology is generated.
- What types of physical files and reports are produced after routing.

---

# 📁 Repository Organization

Recommended repository structure:

```text
VSDIAT-Chip-Design/
│
├── Module-1/
├── Module-2/
│
├── Module-3/
│   └── README.md
│
├── Module-4/
│   └── README.md
│
├── Module-5/
│   ├── README.md
│   ├── SKY130_D5_SK1_Routing_and_DRC/
│   ├── SKY130_D5_SK2_PDN_and_Routing/
│   └── SKY130_D5_SK3_TritonRoute_Features/
│
├── docs/
└── README.md
```

The module folders can contain:

- Laboratory notes
- Terminal outputs
- Screenshots
- Reports
- Routing results
- Physical-verification evidence
- Other supporting material

---

# ☑️ Module 5 Completion Checklist

- [ ] SKY130_D5_SK1 completed
- [ ] Lee's algorithm studied
- [ ] Maze routing understood
- [ ] DRC concept understood
- [ ] SKY130_D5_SK2 completed
- [ ] PDN concept understood
- [ ] Power straps to standard-cell rails understood
- [ ] Global routing studied
- [ ] Detailed routing studied
- [ ] TritonRoute configuration studied
- [ ] SKY130_D5_SK3 completed
- [ ] Route guides studied
- [ ] Inter-guide connectivity studied
- [ ] Intra-layer routing studied
- [ ] Inter-layer routing studied
- [ ] TritonRoute connectivity handling studied
- [ ] Routing topology studied
- [ ] Post-route files identified

---

# 🧠 Skills Developed

### Physical Design
Routing, PDN, DRC, and physical verification.

### Routing
Maze routing, Lee's algorithm, global routing, and detailed routing.

### Tools
TritonRoute and RTL-to-GDSII routing flow.

### ASIC Concepts
Power distribution, routing constraints, design rules, connectivity, vias, and post-route physical data.

---

# 🏁 Conclusion

Module 5 completes the routing-focused portion of the **VSDIAT physical-design training** by connecting power distribution, global routing, detailed routing, TritonRoute, and DRC into the final stages of the RTL-to-GDSII flow.

The concepts from this module provide the foundation for understanding how a placed and clocked design is converted into a **physically routed implementation suitable for final physical verification**.

---

## 📌 Module 5 Summary

| Topic | Key Focus |
|---|---|
| Maze Routing | Path finding through routing grids |
| Lee's Algorithm | Systematic routing algorithm |
| DRC | Manufacturing-rule verification |
| PDN | VDD/VSS power distribution |
| Global Routing | Approximate routing paths |
| Detailed Routing | Exact wires and vias |
| Route Guides | Routing guidance |
| TritonRoute | Detailed routing |
| Connectivity | Maintaining electrical connections |
| Routing Topology | Physical route structure |
| Post-Route Data | Routed DEF and reports |
| RTL-to-GDSII | Complete physical-design flow |

---

**VSDIAT – ASIC / VLSI Core Training**  
**Module 5: Final Steps for RTL2GDS using TritonRoute and OpenSTA**
