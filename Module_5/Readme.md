Module 5 – Optimization in Synthesis and RTL Design Practices
=============================================================

1\. Introduction
----------------

Synthesis optimization is the process of converting RTL (Register Transfer Level) code into an efficient hardware representation while preserving the intended functionality.

During synthesis, tools such as Yosys analyze the Verilog code, simplify logic expressions, optimize Boolean functions, and generate a gate-level netlist.

In this module, the concepts learned in Modules 1–4 are reviewed to understand how RTL coding styles influence synthesized hardware.

2\. Objectives
--------------

*   Understand the role of synthesis optimization.
    
*   Study how RTL descriptions are converted into hardware.
    
*   Understand combinational and sequential logic optimization.
    
*   Examine hierarchical synthesis and standard-cell mapping.
    
*   Understand the importance of correct Verilog coding styles.
    
*   Relate RTL simulation results to synthesized hardware.
    

3\. Review of Previous Modules
------------------------------

The experiments performed in the previous modules provide the foundation for understanding synthesis optimization.

ModuleExperimentMain ConceptModule 12-bit CounterSequential logic and synthesisModule 2Multiple ModulesHierarchical synthesisModule 3D Flip-FlopsSynchronous and asynchronous controlsModule 4MUX and Blocking Assignment ExamplesGLS and synthesis-simulation mismatch

4\. Understanding Synthesis Optimization
----------------------------------------

Synthesis converts Verilog RTL into a hardware netlist.

### General Synthesis Flow

Verilog RTL↓RTL Elaboration↓Process Conversion↓Logic Optimization↓Technology Mapping↓Gate-Level Netlist

The resulting netlist represents the hardware structure inferred from the RTL description.

5\. Counter RTL Analysis – Module 1
-----------------------------------

The Module 1 experiment uses a 2-bit counter with an asynchronous active-high reset.

### Counter Operation

Clock EventCounter OutputReset active00First clock01Second clock10Third clock00

The counter follows the sequence:

00 → 01 → 10 → 00

### Synthesis Observation

The Yosys-generated netlist represents the counter using two state bits and combinational next-state logic.

The terminal-count condition is:

comp = (cnt == 2'b10)

The synthesis process simplifies the next-state logic into Boolean expressions.

This experiment demonstrates how a behavioral RTL description is converted into a hardware representation.

6\. Hierarchical Synthesis – Module 2
-------------------------------------

The Module 2 experiment demonstrates the use of multiple Verilog modules.

### RTL Structure

*   sub\_module1 performs an AND operation.
    
*   sub\_module2 performs an OR operation.
    
*   multiple\_modules connects both submodules.
    

### Boolean Expression

Y = (A & B) | C

### Technology Mapping

The Yosys-generated netlist maps the logic operations to Sky130 standard cells:

*   AND operation: sky130\_fd\_sc\_hd\_\_and2\_0
    
*   OR operation: sky130\_fd\_sc\_hd\_\_or2\_0
    

This demonstrates how hierarchical RTL modules are represented and mapped into standard-cell structures.

7\. Sequential Logic – Module 3
-------------------------------

Module 3 introduces different types of reset and set behavior in sequential circuits.

### Asynchronous Set D Flip-Flop

The dff\_async\_set module uses:

*   Positive-edge-triggered clock.
    
*   Asynchronous active-high set.
    
*   Nonblocking assignments.
    

When async\_set is asserted, the output becomes 1 independently of the clock edge.

### Synchronous Reset D Flip-Flop

The dff\_sync\_reset module uses:

*   Positive-edge-triggered clock.
    
*   Synchronous active-high reset.
    
*   Nonblocking assignments.
    

The output becomes 0 when reset is asserted at the active clock edge.

### Key Learning

The experiment demonstrates the difference between synchronous and asynchronous control signals in sequential logic.

8\. Blocking and Nonblocking Assignments – Module 4
---------------------------------------------------

Verilog provides two important assignment types.

### Blocking Assignment

\=

*   Executes immediately within a procedural block.
    
*   Commonly used for combinational calculations.
    
*   Statement ordering affects procedural simulation behavior.
    

### Nonblocking Assignment

<=

*   Schedules an update for the end of the current simulation time step.
    
*   Commonly used for clocked sequential logic.
    
*   Helps model simultaneous register updates.
    

Correct assignment style improves consistency between RTL simulation and synthesized hardware.

9\. Combinational Logic and MUX Design
--------------------------------------

Module 4 also demonstrates different ways of describing a 2:1 multiplexer.

### MUX Operation

SelectOutput0i01i1

### Ternary Operator

assign y = sel ? i1 : i0;

The ternary operator clearly describes combinational MUX logic.

### Sensitivity List

An incomplete sensitivity list can cause simulation behavior to differ from the intended combinational logic.

Using:

always @(\*)

automatically includes all signals read by the procedural block in the sensitivity list.

This avoids manually listing individual inputs.

10\. RTL Simulation and Gate-Level Simulation
---------------------------------------------

RTL simulation and gate-level simulation serve different purposes.

### RTL Simulation

Verilog RTL↓RTL Simulator↓Waveform

It verifies the behavior described by the RTL code.

### Gate-Level Simulation

Synthesized Netlist↓Gate-Level Simulator↓Waveform

It verifies the behavior of the synthesized gate-level implementation.

Comparing the two helps identify possible synthesis-simulation mismatches.

11\. Role of Yosys in Synthesis
-------------------------------

Yosys is an open-source RTL synthesis tool.

It performs several operations:

*   Reads Verilog RTL files.
    
*   Elaborates the design.
    
*   Converts procedural blocks into internal representations.
    
*   Performs logic optimization.
    
*   Maps logic into target technology cells.
    
*   Generates synthesized netlists.
    

The previous experiments demonstrate the use of Yosys to inspect the synthesized hardware structure.

12\. Important Synthesis Optimization Concepts
----------------------------------------------

The following concepts are important when understanding synthesis optimization:

**1\. Boolean Logic Simplification**

Simplifies logical expressions while preserving their functionality.

**2\. Constant Propagation**

Uses known constant values to simplify logic.

**3\. Dead Logic Elimination**

Removes logic that does not contribute to observable outputs.

**4\. Common Subexpression Optimization**

Identifies and shares repeated logic expressions where appropriate.

**5\. Technology Mapping**

Maps optimized logic into available standard cells from the target technology library.

**6\. Sequential Logic Optimization**

Analyzes registers, reset conditions, and sequential logic to produce an appropriate hardware implementation.

These are general synthesis concepts. They are discussed here for understanding and are not claimed as separately measured optimization results from the previous experiments.

13\. Key Takeaways
------------------

*   RTL describes the intended hardware functionality.
    
*   Synthesis converts RTL into a gate-level netlist.
    
*   Yosys performs logic optimization and technology mapping.
    
*   Hierarchical RTL can be represented using interconnected submodules.
    
*   Correct blocking and nonblocking assignment usage is important.
    
*   Combinational logic should use complete sensitivity handling.
    
*   Synchronous and asynchronous controls behave differently.
    
*   RTL simulation and gate-level simulation help verify hardware behavior.
    
*   Standard-cell libraries determine the available technology-mapping cells.
    
*   Correct RTL coding is essential for reliable synthesis results.
    

14\. Conclusion
---------------

The fifth module consolidates the concepts learned throughout the first four modules of the VSDIAT journey.

The counter experiment demonstrates sequential logic synthesis, while the hierarchical design demonstrates logic mapping into Sky130 standard cells. The D flip-flop experiments explain synchronous and asynchronous controls, and the Module 4 experiments highlight the importance of correct RTL coding practices.

Together, these experiments provide an understanding of how Verilog RTL is interpreted, optimized, and converted into hardware structures using Yosys.

The main learning is that RTL coding must accurately represent the intended hardware so that simulation and synthesis produce consistent functional behavior.

15\. Tools and Technologies
---------------------------

*   Verilog HDL
    
*   Yosys
    
*   Icarus Verilog
    
*   GTKWave
    
*   Sky130 PDK
    
*   Linux Environment
    

16\. Files Referenced
---------------------

The concepts in this module are based on the existing experiments from Modules 1–4.

*   good\_counter.v
    
*   good\_counter\_netlist.v
    
*   tb\_good\_counter.v
    
*   tb\_good\_counter.vcd
    
*   multiple\_modules.v
    
*   tb\_multiple\_modules.v
    
*   Yosys-generated hierarchical and mapped netlists
    
*   dff\_async\_set.v
    
*   dff\_sync\_reset.v
    
*   blocking\_caveat.v
    
*   ternary\_operator\_mux.v
    
*   bad\_mux.v
    
*   good\_mux.v
    

_Note: Module 5 is a documentation-based study of synthesis optimization concepts. It does not introduce a separate hardware project or claim additional experiments._
