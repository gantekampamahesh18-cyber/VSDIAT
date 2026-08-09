# Flip-Flops – Day 2

## Overview

This directory contains Verilog HDL implementations of different D Flip-Flop (DFF) configurations with synchronous and asynchronous control signals.

The objective is to understand how reset and set signals affect D Flip-Flop behavior and how different RTL coding styles represent sequential logic.

## Implemented Flip-Flop Designs

### 1. Asynchronous Reset

Directory:

```text
dff_async_reset/
└── dff_async_reset.v
```

The asynchronous reset forces the output `Q` to `0` immediately when the reset is asserted, independent of the clock.

### 2. Asynchronous Reset with Synchronous Reset

Directory:

```text
dff_async_reset_sync_reset/
└── dff_async_reset_sync_reset.v
```

This design demonstrates both asynchronous and synchronous reset behavior. The asynchronous reset has priority, while the synchronous reset is evaluated at the active clock edge.

### 3. Asynchronous Set

Directory:

```text
dff_async_set/
└── dff_async_set.v
```

The asynchronous set forces the output `Q` to `1` immediately when the set signal is asserted.

### 4. Synchronous Reset

Directory:

```text
dff_sync_reset/
└── dff_sync_reset.v
```

The synchronous reset is checked only at the active clock edge. When the reset is asserted at the clock edge, the output `Q` is reset to `0`.

## Folder Structure

```text
flip_flops/
│
├── dff_async_reset/
│   └── dff_async_reset.v
│
├── dff_async_reset_sync_reset/
│   └── dff_async_reset_sync_reset.v
│
├── dff_async_set/
│   └── dff_async_set.v
│
├── dff_sync_reset/
│   └── dff_sync_reset.v
│
└── README.md
```

## Comparison

| Flip-Flop | Control Type | Reset/Set Behavior |
|-----------|--------------|--------------------|
| DFF Async Reset | Asynchronous Reset | Q → 0 immediately |
| DFF Async Reset + Sync Reset | Async + Sync Reset | Async reset has priority |
| DFF Async Set | Asynchronous Set | Q → 1 immediately |
| DFF Sync Reset | Synchronous Reset | Q → 0 at clock edge |

## Key Concepts

- D Flip-Flop
- Synchronous reset
- Asynchronous reset
- Asynchronous set
- Clock edge triggering
- Sequential logic
- Verilog HDL
- RTL design

## Tools

- Ubuntu Linux
- Verilog HDL
- Yosys
- SKY130 standard-cell library

## Learning Objective

To implement and understand different D Flip-Flop control configurations using Verilog HDL and distinguish between synchronous and asynchronous control signals.

