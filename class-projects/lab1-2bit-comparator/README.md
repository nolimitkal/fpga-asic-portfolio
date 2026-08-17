# Lab 1 — 2-Bit Equality Comparator

Implements a 2-bit equality comparator (X = Y) four different ways in VHDL,
combined into a single structural top-level module.

## Implementations
- `if_then_else.vhd` — behavioral, if-then-else
- `when_else.vhd` — dataflow, when-else
- `boolean_equation.vhd` — dataflow, explicit Boolean equation
- `LUT_primitive.vhd` — structural, Xilinx LUT4 primitive
- `comparator_top.vhd` — structural top-level combining all four

## Files
- `src/` — design files
- `sim/comparator_tb.vhd` — exhaustive testbench (all 16 input combinations)
- `constraints/comparator_top.xdc` — pin mapping for Nexys A7-100T

## Tools
Vivado 2025, Xilinx Artix-7 (Nexys A7-100T)
