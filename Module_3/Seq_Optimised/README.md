# Module 3 – Sequential Optimizations

## Counter Optimization – `counter_opt`

This example demonstrates sequential logic optimization using a 3-bit counter.

The original RTL generates the output directly from the least-significant counter bit. The optimized/reference RTL instead detects a specific counter value.

---

## 1. Normal Design

### RTL Code

```verilog
module counter_opt (input clk, input reset, output q);

reg [2:0] count;

assign q = count[0];

always @(posedge clk, posedge reset)
begin
    if (reset)
        count <= 3'b000;
    else
        count <= count + 1;
end

endmodule
```

### Operation

The counter is 3 bits wide:

```text
count[2:0]
```

The normal design connects the output directly to:

```verilog
assign q = count[0];
```

Therefore, `q` follows the least-significant bit of the counter.

---

## 2. Optimized Design

### RTL Code

```verilog
module counter_opt (input clk, input reset, output q);

reg [2:0] count;

assign q = (count[2:0] == 3'b100);

always @(posedge clk, posedge reset)
begin
    if (reset)
        count <= 3'b000;
    else
        count <= count + 1;
end

endmodule
```

### Optimization

The output is changed to a comparison with a specific counter value:

```verilog
assign q = (count[2:0] == 3'b100);
```

Thus:

| `count[2:0]` | `q` |
|---|---|
| `000` | 0 |
| `001` | 0 |
| `010` | 0 |
| `011` | 0 |
| `100` | 1 |
| `101` | 0 |
| `110` | 0 |
| `111` | 0 |

The output becomes HIGH only when the counter reaches binary `100`.

---

# Yosys Synthesis

## Step 1 – Go to the design directory

```bash
cd ~/VSDIAT/Day_3/sequential/counter_opt
```

## Step 2 – Start Yosys

```bash
yosys
```

## Step 3 – Read the RTL

```text
read_verilog counter_opt.v
```

## Step 4 – Set the top module

```text
prep -top counter_opt
```

## Step 5 – Run optimization

```text
proc
opt
opt_clean
```

For technology mapping:

```text
techmap
opt
abc
opt_clean
```

## Step 6 – View statistics

```text
stat
```

The statistics show the cells and sequential elements remaining after synthesis and optimization.

---

# View the Synthesized Circuit

Use:

```text
show
```

Yosys will generate the synthesized circuit view.

The synthesized design can be compared with the original RTL to observe how the sequential logic is represented after optimization.

---

# GTKWave

GTKWave can be used when a testbench and VCD waveform are available.

Example:

```bash
gtkwave dump.vcd
```

For this exercise, the waveform is optional. The main purpose is to study the RTL and synthesis optimization.

---

# Key Observation

This example demonstrates how the behavior of sequential logic depends on how the counter state is used.

### Normal version

```verilog
assign q = count[0];
```

The output depends only on the least-significant bit.

### Optimized/reference version

```verilog
assign q = (count[2:0] == 3'b100);
```

The output is asserted only for the specific counter state `100`.

The synthesized circuit therefore reflects the logic required to detect that counter value.

---

## Tools Used

- Verilog HDL
- Yosys
- Graphviz
- GTKWave (optional)

---

## Module 3

**Combinational and Sequential Optimizations**

### Topic

**Sequential Optimization – Counter Logic**
