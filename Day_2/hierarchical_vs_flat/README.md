# Hierarchical vs Flat Synthesis

## Objective

To understand the difference between hierarchical synthesis and flat synthesis using Yosys and the SKY130 standard cell library.

## Hierarchical Synthesis

In hierarchical synthesis, the original module hierarchy is preserved during synthesis.

The design contains:

- `multiple_modules`
- `sub_module1`
- `sub_module2`

The hierarchical synthesis generated SKY130 standard cells such as:

- `sky130_fd_sc_hd__and2_0`
- `sky130_fd_sc_hd__or2_0`

The synthesized netlist is available as:

`hierarchical_synth_post.v`

## Flat Synthesis

For flat synthesis, the design hierarchy is removed using the Yosys `flatten` command.

The synthesis flow was:

1. Read the Verilog RTL.
2. Set the top module.
3. Run process conversion and optimization.
4. Flatten the module hierarchy.
5. Perform optimization.
6. Technology-map the design using the SKY130 standard cell library.
7. Generate the post-synthesis netlist.

The synthesis script is:

`flat_synthesis.ys`

The generated post-synthesis netlist is:

`flat_synth_post.v`

## Technology Library

The SKY130 HD standard cell library was used:

`sky130_fd_sc_hd__tt_025C_1v80.lib`

## Results

| Parameter | Hierarchical | Flat |
|-----------|--------------|------|
| Design hierarchy | Preserved | Flattened |
| Standard-cell mapping | SKY130 | SKY130 |
| AND2 cells | 1 | 1 |
| OR2 cells | 1 | 1 |
| Processes | 0 | 0 |

## Conclusion

Hierarchical synthesis preserves the structure of the RTL design, making the design hierarchy easier to understand and manage.

Flat synthesis removes the hierarchy and creates a flattened representation of the design. This allows the synthesis tool to optimize the complete design across module boundaries.

The experiment demonstrates the difference between hierarchical and flat synthesis using Yosys and the SKY130 standard-cell library.
