# BabySoC -- RTL Design, Synthesis and Post-Synthesis Simulation

A complete RTL-to-gate-level verification project using **Verilog HDL**,
**Icarus Verilog**, **GTKWave**, and the **SkyWater SKY130 PDK**.

## 1. Project Overview

BabySoC demonstrates a practical digital IC design flow:

``` text
Verilog RTL
    ↓
RTL Simulation
    ↓
Functional Verification
    ↓
Logic Synthesis
    ↓
Gate-Level Netlist
    ↓
Post-Synthesis Simulation
    ↓
Waveform Analysis
```

The project covers:

-   Verilog RTL design and testbench verification
-   RTL simulation with Icarus Verilog
-   VCD waveform generation and GTKWave analysis
-   RTL synthesis and gate-level netlist generation
-   SKY130 standard-cell functional models
-   Post-synthesis simulation
-   Debugging Verilog/preprocessor issues
-   Git/GitHub project submission

## 2. Objectives

1.  Verify the BabySoC RTL before synthesis.
2.  Synthesize the RTL into a gate-level netlist.
3.  Simulate the synthesized netlist with SKY130 standard-cell models.
4.  Compare RTL and post-synthesis behavior.
5.  Generate and inspect simulation waveforms.
6.  Practice an industry-style RTL-to-gate-level workflow.

## 3. Tools and Technologies

  Tool                             Purpose
  -------------------------------- --------------------------------
  Verilog HDL                      RTL and testbench
  Icarus Verilog (`iverilog`)      Compilation
  VVP (`vvp`)                      Running simulations
  GTKWave                          Waveform analysis
  SKY130 PDK                       130 nm open-source technology
  SkyWater standard-cell library   Gate-level cell models
  Git/GitHub                       Version control and submission
  Linux/Ubuntu                     Development environment


## 4 . Prerequisites

Check the required tools:

``` bash
iverilog -V
vvp -V
gtkwave --version
git --version
```

The SKY130 PDK/workshop repository must also be available.

## 5. Clone and Enter the Repository

``` bash
git clone "https://github.com/manili/VSDBabySoC/tree/main/src/lib"
cd BabySoC
git status
```

For the simulation environment used in this project:

``` bash
cd ~/baby_soc/BabySoC_Simulation
```

## 6. RTL Simulation

Compile the RTL testbench:

``` bash
iverilog -o rtl_sim.out -I src/include -I src/module src/module/testbench.v
```

Run it:

``` bash
vvp rtl_sim.out
```

If a VCD file is generated:

``` bash
gtkwave post_synth_sim.vcd
```

During RTL verification, check the clock, reset, inputs, outputs, state
transitions, and unexpected `X`/`Z` values.

## 7. Synthesis

Synthesis converts RTL into a gate-level implementation using cells from
the target technology:

``` text
RTL → Synthesis → Optimized Gate-Level Netlist → SKY130 Cells

``` text
babysoc_netlist.v
babysoc_netlist2.v
babysoc_netlist3.v

## 8. SKY130 Standard-Cell Verilog Model

Post-synthesis simulation requires the SKY130 standard-cell Verilog
model:

``` text
my_lib/verilog_model/sky130_fd_sc_hd.v
```

The simulation command therefore includes:

``` bash
-I /home/vsduser/VLSI/sky130RTLDesignAndSynthesisWorkshop/my_lib/verilog_model
```

## 9. Post-Synthesis Simulation

### Step 1 -- Enter the simulation directory

``` bash
cd ~/baby_soc/BabySoC_Simulation
```

### Step 2 -- Compile

``` bash
iverilog -o post_synth_sim.out -DPOST_SYNTH_SIM -DFUNCTIONAL  -I src/include -I src/module -I /home/vsduser/VLSI/sky130RTLDesignAndSynthesisWorkshop/my_lib/verilog_model src/module/testbench.v
```

### Meaning of the important options

-   `-o post_synth_sim.out` -- output simulation executable.
-   `-DPOST_SYNTH_SIM` -- selects post-synthesis simulation
    configuration.
-   `-DFUNCTIONAL` -- selects functional standard-cell behavior.
-   `-I ...` -- adds Verilog include/search paths.
-   `src/module/testbench.v` -- testbench/top-level simulation source.

### Step 3 -- Run

``` bash
vvp post_synth_sim.out
```

If compilation and execution return to the shell prompt without an
error, the simulation command completed successfully.

## 10. Waveform Analysis

If the testbench contains `$dumpfile` and `$dumpvars`, a VCD file will
be generated, for example:

``` verilog
$dumpfile("post_synth_sim.vcd");
$dumpvars(0, testbench);
```

Open it with:

``` bash
gtkwave post_synth_sim.vcd
```

Inspect:

-   Clock
-   Reset
-   Inputs
-   Outputs
-   Internal signals where available
-   State transitions
-   Timing/propagation behavior

## 11. RTL vs Post-Synthesis Simulation

### RTL

``` text
Testbench
   ↓
RTL Design
   ↓
Functional Output
```

### Post-Synthesis

``` text
Testbench
   ↓
Gate-Level Netlist
   ↓
SKY130 Standard-Cell Models
   ↓
Functional Output
```

For the same test vectors, the post-synthesis design should preserve the
intended RTL functionality.


## 12. Verification Checklist

-   [ ] RTL source files present
-   [ ] Testbench present
-   [ ] RTL compilation successful
-   [ ] RTL simulation successful
-   [ ] RTL waveform checked
-   [ ] Synthesis completed
-   [ ] Gate-level netlist generated
-   [ ] SKY130 standard-cell model available
-   [ ] Post-synthesis compilation successful
-   [ ] `vvp post_synth_sim.out` executed successfully
-   [ ] Post-synthesis waveform checked
-   [ ] README.md included
## 13. Quick Command Reference


### Post-synthesis

``` bash
cd ~/baby_soc/BabySoC_Simulation

iverilog -o post_synth_sim.out -DPOST_SYNTH_SIM -DFUNCTIONAL -I src/include -I src/module -I /home/vsduser/VLSI/sky130RTLDesignAndSynthesisWorkshop/my_lib/verilog_model src/module/testbench.v

vvp post_synth_sim.out
```

### Waveform

``` bash
gtkwave <waveform_file>.vcd
```

### Git

``` bash
git status
git add .
git commit -m "Add BabySoC project"
git push origin main
```

## 20. Expected Outcome

A successful project flow is:

``` text
             BabySoC RTL
                  │
                  ▼
          RTL Simulation
                  │
             Verification
                  │
                  ▼
              Synthesis
                  │
                  ▼
        Gate-Level Netlist
                  │
                  ▼
        SKY130 Cell Models
                  │
                  ▼
      Post-Synthesis Simulation
                  │
                  ▼
          GTKWave Analysis
```

The final result demonstrates that the synthesized BabySoC
implementation can be compiled and simulated with the selected SKY130
functional cell models and the project testbench.

## 14. Conclusion

BabySoC provides hands-on experience with an RTL-to-gate-level digital
design flow. It combines Verilog RTL design, testbench verification,
simulation, synthesis, gate-level netlist generation, SKY130
standard-cell modeling, post-synthesis simulation, waveform analysis,
debugging, and GitHub-based submission.

This workflow provides a foundation for further VLSI implementation
stages such as physical design and complete RTL-to-GDSII flow.

## Author

**BabySoC -- RTL Design, Synthesis and Simulation Project**

Developed as part of a VLSI RTL Design and Synthesis learning workflow
using the SKY130 open-source technology ecosystem.
