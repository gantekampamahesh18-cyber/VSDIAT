# Module 3 – Sequential Optimizations

## Sequential Constant Optimization

This section contains RTL examples used to study how Yosys performs optimization on sequential logic containing constant values.

The examples covered are:

- `dff_const1`
- `dff_const2`
- `dff_const3`
- `dff_const4`
- `dff_const5`

The RTL designs demonstrate how constants, reset conditions, and flip-flop dependencies can allow synthesis tools to simplify sequential logic.

---

## Directory Structure

```text
Day_3/
└── sequential/
    ├── dff_const1/
    │   └── dff_const1.v
    ├── dff_const2/
    │   └── dff_const2.v
    ├── dff_const3/
    │   └── dff_const3.v
    ├── dff_const4/
    │   └── dff_const4.v
    └── dff_const5/
        └── dff_const5.v
```

---

## 1. dff_const1

### RTL concept

The flip-flop output is assigned a constant value after reset.

```verilog
module dff_const1(input clk, input reset, output reg q);

always @(posedge clk, posedge reset)
begin
    if(reset)
        q <= 1'b0;
    else
        q <= 1'b1;
end

endmodule
```

### Optimization

The output eventually becomes a constant `1` after the active clock operation. Yosys can identify constant behavior and simplify the resulting logic where possible.

---

## 2. dff_const2

### RTL concept

The flip-flop is assigned the same constant value in both reset and normal operation.

```verilog
module dff_const2(input clk, input reset, output reg q);

always @(posedge clk, posedge reset)
begin
    if(reset)
        q <= 1'b1;
    else
        q <= 1'b1;
end

endmodule
```

### Optimization

Since `q` is always assigned `1`, the sequential element is redundant from a functional perspective and can be optimized to a constant.

---

## 3. dff_const3

### RTL concept

The design uses a reset input and constant assignments that allow Yosys to simplify the sequential logic.

### Synthesis observation

The synthesized result demonstrates constant propagation and removal of unnecessary sequential logic.

---

## 4. dff_const4

### RTL code

```verilog
module dff_const4(input clk, input reset, output reg q);
    reg q1;

    always @(posedge clk, posedge reset)
    begin
        if(reset)
        begin
            q  <= 1'b1;
            q1 <= 1'b1;
        end
        else
        begin
            q1 <= 1'b1;
            q  <= q1;
        end
    end

endmodule
```

### Optimization

Both `q1` and `q` are driven toward the constant value `1`.

Yosys can propagate the constant through the sequential logic and remove redundant logic when the behavior allows it.

---

## 5. dff_const5

### RTL code

```verilog
module dff_const5(input clk, input reset, output reg q);
    reg q1;

    always @(posedge clk, posedge reset)
    begin
        if(reset)
        begin
            q  <= 1'b0;
            q1 <= 1'b0;
        end
        else
        begin
            q1 <= 1'b1;
            q  <= q1;
        end
    end

endmodule
```

### Optimization

Unlike a simple constant-output flip-flop, this design contains a dependency between `q1` and `q`.

After reset:

1. `q` and `q1` are `0`.
2. On the next clock edge, `q1` becomes `1`.
3. `q` receives the previous value of `q1`.
4. On the following clock edge, `q` becomes `1`.

Therefore, the sequential behavior must be considered before removing the flip-flops.

---

# Yosys Synthesis

The designs can be synthesized using Yosys.

> The commands below are provided for documentation/reproduction. Simulation and GTKWave are not required for this repository section.

## Step 1 – Open the terminal

Go to the required design directory:

```bash
cd ~/VSDIAT/Day_3/sequential/dff_const4
```

or:

```bash
cd ~/VSDIAT/Day_3/sequential/dff_const5
```

---

## Step 2 – Start Yosys

```bash
yosys
```

---

## Step 3 – Read the Verilog RTL

For `dff_const4`:

```text
read_verilog dff_const4.v
```

For `dff_const5`:

```text
read_verilog dff_const5.v
```

---

## Step 4 – Set the top module

```text
prep -top dff_const4
```

or:

```text
prep -top dff_const5
```

---

## Step 5 – Run optimization

```text
opt_clean
```

For a complete synthesis flow:

```text
proc
opt
memory
opt
techmap
opt
abc
opt
```

---

## Step 6 – View statistics

```text
stat
```

The statistics can be used to observe the number of wires, processes, cells, and flip-flops before/after optimization.

---

# Viewing the Synthesized Design

To generate a graphical representation:

```text
show
```

Yosys opens the synthesized design using Graphviz.

This allows the optimized circuit to be compared with the original RTL.

---

# Optional GTKWave Flow

GTKWave is only required if a testbench and waveform dump are available.

Example:

```bash
gtkwave dump.vcd
```

The waveform can be used to verify the sequential behavior of the design.

For this repository documentation, GTKWave is optional and the RTL/synthesis results are the primary focus.

---

# Key Learning

Sequential optimization demonstrates that synthesis tools do more than simply convert RTL into gates.

Yosys can:

- Propagate constant values
- Remove redundant logic
- Simplify reset logic
- Remove unused registers
- Optimize flip-flop logic
- Preserve required sequential dependencies
- Map optimized RTL to technology-specific cells

The `dff_const` examples show how apparently different RTL descriptions can result in significantly simplified synthesized hardware.

---

## Tools Used

- **Verilog HDL** – RTL description
- **Yosys** – RTL synthesis and optimization
- **Graphviz** – synthesized circuit visualization
- **GTKWave** – optional waveform visualization

---

## Module

**Module 3 – Combinational and Sequential Optimizations**

**Topic:** Sequential Optimization – Constant Propagation and Flip-Flop Optimization
