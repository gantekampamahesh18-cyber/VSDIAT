# Module 4 – Gate Level Simulation (GLS)

## Overview

Module 4 introduces Gate Level Simulation (GLS) and synthesis–simulation mismatch using a 2:1 multiplexer.

Examples used:
- `ternary_operator_mux.v`
- `bad_mux.v`
- `good_mux.v`

---

## 1. Ternary Operator MUX

### `ternary_operator_mux.v`

```verilog
module ternary_operator_mux (input i0, input i1, input sel, output y);
    assign y = sel ? i1 : i0;
endmodule
```

### Operation

| sel | y |
|---|---|
| 0 | i0 |
| 1 | i1 |

This is a simple combinational 2:1 multiplexer.

---

## 2. Bad MUX

### `bad_mux.v`

```verilog
module bad_mux (input i0, input i1, input sel, output reg y);
always @(sel)
begin
    if(sel)
        y <= i1;
    else
        y <= i0;
end
endmodule
```

### Problem

The sensitivity list contains only `sel`.

However, the block also reads `i0` and `i1`. If either data input changes while `sel` remains unchanged, the simulator does not execute the block.

This can cause a synthesis–simulation mismatch.

---

## 3. Good MUX

### `good_mux.v`

```verilog
module good_mux (input i0, input i1, input sel, output reg y);
always @(*)
begin
    if(sel)
        y <= i1;
    else
        y <= i0;
end
endmodule
```

`@(*)` automatically includes all signals read inside the block: `i0`, `i1`, and `sel`.

Therefore the combinational behavior is correctly simulated.

---

## 4. RTL Simulation vs Synthesis

The RTL simulator follows the sensitivity list exactly.

For the bad MUX:

```verilog
always @(sel)
```

a change in `i0` or `i1` alone may not update `y`.

During synthesis, the tool recognizes the intended combinational logic and implements a 2:1 multiplexer.

Therefore RTL simulation can disagree with the synthesized hardware.

This is called a **synthesis–simulation mismatch**.

---

## 5. Gate Level Simulation (GLS)

GLS verifies the synthesized gate-level netlist.

```text
RTL Design
    ↓
RTL Simulation
    ↓
Yosys Synthesis
    ↓
Gate-Level Netlist
    ↓
GLS
    ↓
Compare Waveforms
```

The goal is to confirm that the synthesized implementation behaves as intended.

---

## 6. Yosys Synthesis

Start Yosys:

```bash
yosys
```

Read the RTL:

```text
read_verilog ternary_operator_mux.v
```

Set the top module:

```text
prep -top ternary_operator_mux
```

Optimize:

```text
proc
opt
```

Technology mapping:

```text
techmap
opt
abc
```

View statistics:

```text
stat
```

View the synthesized circuit:

```text
show
```

---

## 7. Write Gate-Level Netlist

```text
write_verilog ternary_operator_mux_net.v
```

The generated file contains the synthesized gate-level implementation.

---

## 8. GLS Simulation

Compile the testbench with the synthesized netlist:

```bash
iverilog ../my_lib/verilog_model/primitives.v ../my_lib/verilog_model/sky130_fd_sc_hd.v ternary_operator_mux_net.v tb_ternary_operator_mux.v

```

Run:

```bash
vvp gls.out
```

Open the waveform:

```bash
gtkwave dump.vcd
```

The exact netlist filename can vary depending on the synthesis flow.

---

## 9. Expected MUX Behavior

For a 2:1 MUX:

```text
sel = 0  →  y = i0
sel = 1  →  y = i1
```

Example:

```text
i0 = 0
i1 = 1

sel = 0 → y = 0
sel = 1 → y = 1
```

The correctly written RTL and GLS should produce matching logical behavior.

---

## 10. Key Learning

### Ternary version

```verilog
assign y = sel ? i1 : i0;
```

Clearly describes combinational MUX logic.

### Bad version

```verilog
always @(sel)
```

Incorrect/incomplete sensitivity list because `i0` and `i1` are also used.

### Good version

```verilog
always @(*)
```

Correctly models combinational logic by including all required inputs in the sensitivity list.

---

## 11. Conclusion

GLS is used to verify the behavior of the synthesized gate-level implementation against the RTL design.

The MUX examples show why correct RTL coding is important. An incomplete sensitivity list can cause simulation behavior to differ from the synthesized hardware.

For combinational logic, `always @(*)` avoids manual sensitivity-list errors.

---

## Files

```text
ternary_operator_mux.v
bad_mux.v
good_mux.v
```

## Tools

- Verilog HDL
- Yosys
- GTKWave


## Module

**Module 4 – Gate Level Simulation (GLS) and Synthesis–Simulation Mismatch**
