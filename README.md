# FPGA Design Portfolio

Personal FPGA/digital design projects built from the ground up in Verilog, VHDL, and SystemVerilog.
Focused on digital logic fundamentals, HDL simulation, and hardware implementation.

Target roles: FPGA Design Engineer | Digital Design Engineer | Hardware Verification Engineer | Embedded Systems Engineer (FPGA focus)

---

## Languages & Tools

- **HDLs:** Verilog, VHDL (in progress), SystemVerilog (planned)
- **Platforms:** Xilinx Artix-7 (class hardware), simulation-only for now, board TBD
- **Tools:** Vivado 2025, Icarus Verilog, ModelSim, GTKWave, Git
- **Concepts:** Combinational & Sequential Logic, FSMs, Memory Design, Pipelining, Protocols, DSP, Verification/Testbenches

---

## Phase 0 — Class Projects (Design of Digital Systems)

> Existing coursework using AMD Vivado 2025 and the Xilinx Artix-7 board

| Project | Description | Status |
| ------- | ------------ | ------ |
| [Lab 0 — Pipelined Register](class-projects/lab0-pipelined-register) | 2-bit synchronous double-buffered register | ✅ Complete |
| [Lab 1 — Comparator](class-projects/lab1-comparator) | 2-bit equality comparator, implemented 4 ways (if-then-else, when-else, boolean equation, LUT primitive) | ✅ Complete |
| [Lab 2 — Register File](class-projects/lab2-reg-file) | 8x4 register file with 3-to-8 decoder and 8-to-1 read mux | ✅ Complete |
| [Lab 3 — ALU](class-projects/lab3-alu) | 6-bit ALU (adder, multiplier, logic unit, shifter) | ✅ Complete |
| [Lab 4 — Debugging](class-projects/lab4-debugging) | Debugging exercises/techniques in Vivado (waveform analysis, simulation troubleshooting) | ⏳ Pending |
| [Lab 5 — Vending Machine System](class-projects/lab5-vending-machine) | Structural vending machine controller (coin/deposit input, inventory tracking, locking logic, LED/7-seg display) | ✅ Complete |

---

## Phase 1 — FPGA Fundamentals (Simulation)

> Pure HDL simulation projects focused on core digital design concepts

| Project | Description | Status |
| ------- | ------------ | ------ |
| Priority Encoder / One-Hot Decoder | Combinational priority encoding and one-hot decoding logic | ⏳ Pending |
| Traffic Light FSM | Finite state machine with timed transitions | ⏳ Pending |
| FIFO Buffer | Synchronous FIFO with full/empty flags | ⏳ Pending |
| Multi-Mode Counter | Parameterizable up/down/load counter | ⏳ Pending |


cd "/c/Users/kjbai/OneDrive/Documents/.VS Code/fpga-asic-projects/class-projects"
mv lab4-project-name lab4-debugging
cd ..

cat > README.md << 'EOF'
# FPGA Design Portfolio

Personal FPGA/digital design projects built from the ground up in Verilog, VHDL, and SystemVerilog.
Focused on digital logic fundamentals, HDL simulation, and hardware implementation.

Target roles: FPGA Design Engineer | Digital Design Engineer | Hardware Verification Engineer | Embedded Systems Engineer (FPGA focus)

---

## Languages & Tools

- **HDLs:** Verilog, VHDL (in progress), SystemVerilog (planned)
- **Platforms:** Xilinx Artix-7 (class hardware), simulation-only for now, board TBD
- **Tools:** Vivado 2025, Icarus Verilog, ModelSim, GTKWave, Git
- **Concepts:** Combinational & Sequential Logic, FSMs, Memory Design, Pipelining, Protocols, DSP, Verification/Testbenches

---

## Phase 0 — Class Projects (Design of Digital Systems)

> Existing coursework using AMD Vivado 2025 and the Xilinx Artix-7 board

| Project | Description | Status |
| ------- | ------------ | ------ |
| [Lab 0 — Pipelined Register](class-projects/lab0-pipelined-register) | 2-bit synchronous double-buffered register | ✅ Complete |
| [Lab 1 — Comparator](class-projects/lab1-comparator) | 2-bit equality comparator, implemented 4 ways (if-then-else, when-else, boolean equation, LUT primitive) | ✅ Complete |
| [Lab 2 — Register File](class-projects/lab2-reg-file) | 8x4 register file with 3-to-8 decoder and 8-to-1 read mux | ✅ Complete |
| [Lab 3 — ALU](class-projects/lab3-alu) | 6-bit ALU (adder, multiplier, logic unit, shifter) | ✅ Complete |
| [Lab 4 — Debugging](class-projects/lab4-debugging) | Debugging exercises/techniques in Vivado (waveform analysis, simulation troubleshooting) | ⏳ Pending |
| [Lab 5 — Vending Machine System](class-projects/lab5-vending-machine) | Structural vending machine controller (coin/deposit input, inventory tracking, locking logic, LED/7-seg display) | ✅ Complete |

---

## Phase 1 — FPGA Fundamentals (Simulation)

> Pure HDL simulation projects focused on core digital design concepts

| Project | Description | Status |
| ------- | ------------ | ------ |
| Priority Encoder / One-Hot Decoder | Combinational priority encoding and one-hot decoding logic | ⏳ Pending |
| Traffic Light FSM | Finite state machine with timed transitions | ⏳ Pending |
| FIFO Buffer | Synchronous FIFO with full/empty flags | ⏳ Pending |
| Multi-Mode Counter | Parameterizable up/down/load counter | ⏳ Pending |

---

## Phase 2 — Intermediate Design (Simulation)

> Combining multiple concepts into larger, realistic designs

| Project | Description | Status |
| ------- | ------------ | ------ |
| 8-Bit Processor Datapath | Register file + ALU + control unit | ⏳ Pending |
| UART Tx/Rx | Serial communication protocol in HDL | ⏳ Pending |
| Pipelined ALU | Multi-stage pipelined arithmetic unit | ⏳ Pending |
| SPI Master Controller | Configurable CPOL/CPHA SPI interface | ⏳ Pending |

---

## Phase 3 — Advanced Design (Simulation)

> High-performance and specialized digital design concepts

| Project | Description | Status |
| ------- | ------------ | ------ |
| FIR Digital Filter | Pipelined DSP filter with configurable coefficients | ⏳ Pending |
| Cache Controller | Simplified L1 cache with hit/miss and LRU logic | ⏳ Pending |
| DDR Memory Controller | Simplified timing/control for DDR interface | ⏳ Pending |
| Matrix Multiplier Accelerator | Parallelized 4x4 matrix multiply hardware | ⏳ Pending |

---

## Hardware Phase (Planned)

> Real board projects once a dev board is purchased

- LED Blinker with Timing Constraints
- Button Debouncer
- UART on FPGA (Tx/Rx to PC)
- SPI Master on FPGA (external device)
- VGA Display Driver
- Soft-Core Processor (RISC-V or custom)

---

## About

Computer Engineering student building FPGA/digital design skills alongside an embedded systems software portfolio, targeting FPGA design, verification, and embedded hardware roles.

Roadmap reference: [m3y54m/FPGA-ASIC-Roadmap](https://github.com/m3y54m/FPGA-ASIC-Roadmap)
