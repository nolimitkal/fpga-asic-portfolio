# Lab 0 — Pipelined Register

A 2-bit synchronous double-buffered register in VHDL. On each rising clock
edge, input data is shifted through two register stages, so the output
reflects the input from two clock cycles earlier.

## Modules
- `mydesign1` — 2-bit register with two sequential pipeline stages

## Files
- `src/design.vhd` — RTL design
- `sim/sim.vhd` — testbench (drives a sequence of input values and observes
  the delayed output)
- `constraints/constraints.xdc` — pin mapping (Xilinx Artix-7)

## Tools
Vivado 2025, Xilinx Artix-7
