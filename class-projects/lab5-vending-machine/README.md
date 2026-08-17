# Lab 5 — Vending Machine System

A structural vending machine controller combining coin/deposit input,
inventory tracking, locking logic, LED status, and 7-segment BCD display
output, built from two design files with nested sub-entities.

## vending_machine_system.vhd
- `display_7seg` — raw 7-segment display driver
- `bin_bcd` — binary to BCD converter
- `decoder_bcd_7seg` — BCD to 7-segment decoder
- `locking_system` — vending machine lock/unlock logic
- `vending_machine_cc` — coin counter
- `vending_machine_input` — user input handling
- `vending_machine_led` — LED status indicators
- `vending_machine_7seg` — top-level display integration
- `vending_machine_system` — top-level structural design

## vending_machine_subsystem.vhd
- `vending_machine_ctrl` — subsystem control logic
- `soda_list` — soda inventory tracking
- `coin_list` — coin inventory tracking
- `deposit_register` — deposit amount register
- `vending_machine_subsystem` — structural subsystem integration

## Files
- `src/` — design files
- `sim/vending_machine_subsystem_tb.vhd` — subsystem testbench
- `constraints/vending_machine_constraints.xdc` — pin mapping (Xilinx Artix-7)

## Tools
Vivado 2025, Xilinx Artix-7
