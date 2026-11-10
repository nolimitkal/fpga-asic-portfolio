# Project 1: 4-Bit Priority Encoder

## Specification

| Item | Decision |
|---|---|
| Input width | 4 request lines |
| Priority direction | MSB wins (`req[3]` is highest priority) |
| Output when nobody requests | `idx = 2'b00`, `valid = 0` |
| Circuit type | Combinational (no clock, no reset, no state) |
| Language | Verilog-2001 (synthesizable) |

## Interface

| Port | Direction | Width | Meaning |
|---|---|---|---|
| `req` | input | 4 | Request lines, `req[3]` is highest priority |
| `idx` | output | 2 | Binary index of the winning request |
| `valid` | output | 1 | 1 if at least one request is active |

## Block Diagram

```
             +--------------------+
 req[3:0] -->|                    |--> idx[1:0]
   (4 bits)  |  priority_encoder  |     (2 bits)
             |                    |--> valid
             +--------------------+     (1 bit)
```

## Design Decisions

**Why MSB wins:** The most significant bit is the first one a person reads in a
binary number, so "highest bit wins" is the most natural convention. It also
matches how many interrupt controllers assign a fixed priority order.

**Why `valid` exists:** `idx = 00` is ambiguous. It could mean "request 0 won"
or "nobody requested." The `valid` output removes the ambiguity: when
`valid = 0`, the value of `idx` must be ignored. I chose `idx = 00` for the
no-request case so the output is always a defined value (never `x`), and so the
testbench has one exact value to check.

## Full Truth Table (all 16 input combinations)

| req[3] | req[2] | req[1] | req[0] | idx[1] | idx[0] | valid | Winner |
|:---:|:---:|:---:|:---:|:---:|:---:|:---:|---|
| 0 | 0 | 0 | 0 | 0 | 0 | 0 | none |
| 0 | 0 | 0 | 1 | 0 | 0 | 1 | 0 |
| 0 | 0 | 1 | 0 | 0 | 1 | 1 | 1 |
| 0 | 0 | 1 | 1 | 0 | 1 | 1 | 1 |
| 0 | 1 | 0 | 0 | 1 | 0 | 1 | 2 |
| 0 | 1 | 0 | 1 | 1 | 0 | 1 | 2 |
| 0 | 1 | 1 | 0 | 1 | 0 | 1 | 2 |
| 0 | 1 | 1 | 1 | 1 | 0 | 1 | 2 |
| 1 | 0 | 0 | 0 | 1 | 1 | 1 | 3 |
| 1 | 0 | 0 | 1 | 1 | 1 | 1 | 3 |
| 1 | 0 | 1 | 0 | 1 | 1 | 1 | 3 |
| 1 | 0 | 1 | 1 | 1 | 1 | 1 | 3 |
| 1 | 1 | 0 | 0 | 1 | 1 | 1 | 3 |
| 1 | 1 | 0 | 1 | 1 | 1 | 1 | 3 |
| 1 | 1 | 1 | 0 | 1 | 1 | 1 | 3 |
| 1 | 1 | 1 | 1 | 1 | 1 | 1 | 3 |

## Compressed Truth Table (don't-cares, in priority order)

`x` means "don't care". The first row that matches wins, and that ordering
is what creates the priority behavior.

| req[3:0] | idx[1:0] | valid | Covers |
|:---:|:---:|:---:|---|
| `1xxx` | `11` | 1 | 8 rows |
| `01xx` | `10` | 1 | 4 rows |
| `001x` | `01` | 1 | 2 rows |
| `0001` | `00` | 1 | 1 row |
| `0000` | `00` | 0 | 1 row |

16 rows compress to 5 (8 + 4 + 2 + 1 + 1 = 16, so every input is covered exactly once).

## Boolean Equations (cross-check)

Derived from the compressed table:

```
valid  = req[3] | req[2] | req[1] | req[0]
idx[1] = req[3] | req[2]
idx[0] = req[3] | (~req[2] & req[1])
```

Check: `idx[1]` is 1 only when the winner is 3 or 2. `idx[0]` is 1 only when
the winner is 3 or 1. Winner 1 requires `req[3] = 0`, `req[2] = 0`,
`req[1] = 1`, and the equation reproduces that because `req[3]` already
takes over whenever it is high.

## Hardware Mapping

| Target | How it maps |
|---|---|
| FPGA | Each output depends on at most 4 inputs, so each fits in a single LUT (3 LUTs total, no carry chain, no flip-flops) |
| ASIC | `valid` is a 4-input OR, `idx[1]` is a 2-input OR, `idx[0]` is an AND-OR structure (AOI/OAI style cells) |
| Scaling | Wider encoders need deeper logic because each lower bit is masked by every higher bit. This matters for Fmax in larger designs |

## Verification Plan

- Exhaustive test: apply all 16 input values (only 16 exist).
- Expected values come from an independent method in the testbench (a loop
  scanning from `req[3]` down to `req[0]`), not from the RTL.
- Check both `idx` and `valid` on every vector, print PASS/FAIL per vector and a final summary.
- Required corner cases: `0000` (no request), `1111` (all requests), and each single-bit request.

## Common Pitfalls

- Incomplete `if`/`case` in the combinational block infers a latch.
- `req[0:3]` instead of `req[3:0]` silently reverses the priority.
- Reading `idx` while `valid = 0` and treating it as a real winner.

## Interview Notes

- Priority encoder vs. plain encoder: a plain encoder assumes only one input is high, a priority encoder defines the result when several are high.
- Why `valid`: it separates "request 0 won" from "no request."
- Why an incomplete `case` creates a latch: the output must hold its old value on unassigned paths, which requires memory.

## Status

- [x] Block diagram
- [x] Priority direction and no-request behavior chosen
- [x] Full truth table
- [x] Compressed truth table
- [ ] RTL (`rtl/priority_encoder.v`)
- [ ] Self-checking testbench (`tb/tb_priority_encoder.v`)
- [ ] Lint and Yosys latch check
- [ ] Waveform screenshot in `docs/`
- [ ] Project README