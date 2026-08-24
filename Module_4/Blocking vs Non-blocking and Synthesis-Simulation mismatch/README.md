# Module 4 — Blocking vs Nonblocking & Synthesis–Simulation Mismatch

## 1. Objective

This section demonstrates:

1. Blocking (`=`) assignment in Verilog.
2. Nonblocking (`<=`) assignment and its intended use.
3. How assignment type and statement ordering can create a **synthesis–simulation mismatch**.
4. How Yosys synthesis represents the logic as gates/cells.
5. How the RTL simulation waveform can be compared with the synthesized result.

---

## 2. Blocking Assignment Example

The example used in this experiment is `blocking_caveat.v`.

```verilog
module blocking_caveat (input a, input b, input c, output reg d);
reg x;

always @(*)
begin
    d = x & c;
    x = a | b;
end

endmodule
```

### Important point

The statements are executed **sequentially** in the simulator because blocking assignment (`=`) updates the variable immediately.

Therefore:

```verilog
d = x & c;
x = a | b;
```

means that `d` uses the **previous value of `x`** during simulation. Only after that is `x` updated to `a | b`.

This makes the code sensitive to the order of statements inside the `always` block.

---

## 3. What the Intended Logic Looks Like

The two logical operations are:

```text
x = a OR b
d = x AND c
```

So the intended combinational relationship is:

```text
        a ──┐
            OR ── x ──┐
        b ──┘         AND ── d
                      │
        c ────────────┘
```

Mathematically:

```text
d = (a | b) & c
```

However, because `d` is calculated before `x` is updated in the RTL block, RTL simulation can temporarily use the old value of `x`.

---

## 4. RTL Simulation

The waveform generated for `blocking_caveat` contains:

- `a`
- `b`
- `c`
- `d`

The input signals change with time, while `d` is affected by the ordering of the blocking assignments.

### Observation

The RTL simulation demonstrates why statement ordering matters when blocking assignments are used in combinational logic.

For combinational `always` blocks, a safer coding style is to calculate intermediate signals before using them.

For example:

```verilog
always @(*)
begin
    x = a | b;
    d = x & c;
end
```

or, preferably for simple combinational logic:

```verilog
assign d = (a | b) & c;
```

---

# 5. Blocking vs Nonblocking Assignment

## Blocking Assignment — `=`

Blocking assignment executes immediately.

```verilog
x = a | b;
d = x & c;
```

The second statement sees the newly assigned value of `x`.

### Common use

Blocking assignments are normally used for:

- Combinational logic
- Intermediate calculations inside combinational `always` blocks

---

## Nonblocking Assignment — `<=`

Nonblocking assignment schedules the update for the end of the current simulation time step.

```verilog
x <= a | b;
d <= x & c;
```

Here, `d` sees the **old value of `x`** during that clock/event evaluation.

### Common use

Nonblocking assignments are normally used for:

- Sequential logic
- Flip-flops
- Clocked `always @(posedge clk)` blocks

Example:

```verilog
always @(posedge clk)
begin
    q <= d;
end
```

---

## 6. Quick Comparison

| Feature | Blocking `=` | Nonblocking `<=` |
|---|---|---|
| Update | Immediate | Scheduled |
| Typical use | Combinational logic | Sequential logic |
| Statement order affects simulation | Yes | Usually less dependent on procedural order |
| Common block | `always @(*)` | `always @(posedge clk)` |
| Flip-flop coding | Not recommended | Recommended |

### Rule to remember

**Combinational → Blocking (`=`)**

**Sequential → Nonblocking (`<=`)**

---

# 7. Synthesis–Simulation Mismatch

A **synthesis–simulation mismatch** occurs when the behavior observed during RTL simulation does not match the behavior of the synthesized hardware.

This can happen because:

- Blocking and nonblocking assignments are used incorrectly.
- Statement ordering changes the simulation behavior.
- Incomplete sensitivity lists are used.
- Incomplete assignments infer unintended latches.
- `#delay` statements are used in synthesizable RTL.
- Reset behavior is coded incorrectly.
- Simulation-only constructs are used.
- The RTL description does not accurately represent the intended hardware.

---

## 8. Why `blocking_caveat` Is Important

The `blocking_caveat` example demonstrates a classic procedural-order issue.

Original:

```verilog
always @(*)
begin
    d = x & c;
    x = a | b;
end
```

The simulator executes:

```text
1. Calculate d using current/old x
2. Calculate new x using a and b
```

But the hardware synthesized from the combinational equations does not contain a software-style sequential execution order. It represents the logic relationships between signals.

Therefore, relying on the procedural order of blocking assignments can make RTL simulation misleading.

---

# 9. Recommended Coding Style

For combinational logic, write the intermediate result before using it:

```verilog
always @(*)
begin
    x = a | b;
    d = x & c;
end
```

Or simplify the logic:

```verilog
module blocking_caveat (input a, input b, input c, output d);

assign d = (a | b) & c;

endmodule
```

For sequential logic:

```verilog
always @(posedge clk)
begin
    q <= d;
end
```

Use nonblocking assignments for the flip-flop/state updates.

---

# 10. Yosys Synthesis Observation

After synthesis, Yosys represents the combinational logic using standard cells/gates.

For the logic:

```verilog
d = (a | b) & c;
```

the synthesized structure can be viewed conceptually as:

```text
a ──┐
    OR ──┐
b ──┘    │
         AND ── d
c ───────┘
```

The Yosys-generated schematic therefore shows the actual synthesized hardware structure rather than the procedural order of the Verilog statements.

---

# 11. Simulation vs Synthesis

### RTL simulation

```text
Verilog source
      ↓
RTL simulator
      ↓
Waveform
```

Shows the behavior described by the Verilog procedural statements.

### Synthesis

```text
Verilog source
      ↓
Yosys synthesis
      ↓
Gate/cell netlist
      ↓
Hardware structure
```

Shows the hardware inferred from the RTL.

### Main lesson

The Verilog code is a **hardware description**, not a normal software program. Coding style must accurately describe the hardware that is intended to be synthesized.

---

# 12. Experiment Result

From the `blocking_caveat` experiment:

- Blocking assignment behavior was observed in RTL simulation.
- The waveform shows the effect of procedural statement ordering.
- Yosys synthesis converts the combinational description into hardware cells.
- The example demonstrates why careless use of blocking/nonblocking assignments can cause simulation behavior that does not represent the intended hardware.
- Correct assignment style improves consistency between RTL simulation and synthesized hardware.

---

# 13. Key Takeaways

1. `=` is a **blocking assignment** and updates immediately.
2. `<=` is a **nonblocking assignment** and schedules the update.
3. Use blocking assignments for combinational calculations.
4. Use nonblocking assignments for clocked/sequential logic.
5. Do not depend on statement ordering to model hardware behavior incorrectly.
6. Always compare RTL simulation with synthesized behavior when debugging synthesis issues.
7. The goal is to make **RTL simulation, synthesis, and actual hardware behavior agree**.

---

## Files Used

```text
blocking_caveat.v
```

The experiment also uses the corresponding testbench and generated Yosys schematic/waveform for verification.
