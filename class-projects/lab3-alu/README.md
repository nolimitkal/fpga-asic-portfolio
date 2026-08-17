# Lab 3 — ALU (Arithmetic Logic Unit)

A 6-bit ALU built from four functional sub-units (adder, multiplier, logic
unit, shifter), combined into a single top-level module with individual
and top-level testbenches.

## Modules
- `adder.vhd` — 6-bit adder/subtractor (select-controlled)
- `mult.vhd` — 6-bit multiplier (low/high result select)
- `logic_unit.vhd` — bitwise NOT/AND/OR/XOR (select-controlled)
- `shifter.vhd` — barrel shifter (direction/amount select)
- `alu.vhd` — structural top-level combining all four via 4-bit opcode select

## Files
- `src/` — design files
- `sim/` — individual testbenches (`lab3_adder_sim.vhd`, `lab3_mult_sim.vhd`,
  `lab3_logic_unit_sim.vhd`, `lab3_shifter_sim.vhd`) and top-level
  (`lab3_alu_sim.vhd`)
- `constraints/alu.xdc` — pin mapping (Xilinx Artix-7)

## Tools
Vivado 2025, Xilinx Artix-7
