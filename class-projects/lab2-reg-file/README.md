# Lab 2 — 8x4 Register File

An 8-register, 4-bit-wide register file with a 3-to-8 decoder for write
address selection and an 8-to-1 mux for read output.

## Modules
- `decoder_3to8.vhd` — 3-to-8 write address decoder
- `reg_module.vhd` — single 4-bit register (instantiated 8x as REG0-REG7)
- `mux_8to1.vhd` — 8-to-1 read output multiplexer
- `reg_file.vhd` — structural top-level combining decoder, 8 registers, mux

## Files
- `src/` — design files
- `sim/reg_file_tb.vhd` — testbench
- `constraints/reg_file.xdc` — pin mapping (clk, rst, we, addr, din, dout)

## Tools
Vivado 2025, Xilinx Artix-7
