# EE 271 — DE1-SoC Labs

A collection of my EE 271 labs for the Terasic **DE1-SoC** board using **SystemVerilog**, **Quartus**, and **ModelSim**.

> **Note:** For **Lab 8 (Final Project)** I implemented a **Frogger-style** game. See the detailed section below.

---

## Table of Contents

- [Repo Structure](#repo-structure)
- [Tooling & Conventions](#tooling--conventions)
- [Labs 1–7 (Brief Summaries)](#labs-17-brief-summaries)
- [Lab 8 — Final Project: Frogger](#lab-8--final-project-frogger)
  - [Overview](#overview)
  - [I/O Mapping](#io-mapping)
  - [Architecture](#architecture)
  - [Key Modules](#key-modules)
  - [Timing & Control](#timing--control)
  - [Collision & Win Logic](#collision--win-logic)
  - [Simulation](#simulation)
  - [Synthesis / Board Bring-Up](#synthesis--board-bring-up)
  - [Parameters & Tuning](#parameters--tuning)
  - [Known Limitations / Future Work](#known-limitations--future-work)
  - [Demo / Grading Checklist](#demo--grading-checklist)

---

## Repo Structure


---

## Tooling & Conventions

- **Single synchronous clock** across the design; slower behavior uses **clock enables** (no secondary clocks).
- **Active-high sync reset**. Asynchronous inputs (buttons) go through **2-FF synchronizers** + **one-shot edge** detectors.
- Clear separation of **datapath**, **controller (FSM)**, and **I/O**.
- Sim before synth; small **directed tests** for each module.

---

## Labs 1–7 (Brief Summaries)

- **Lab 1 — Combinational Logic & Seven-Seg**: truth tables, priority encoders/decoders, HEX display basics.  
- **Lab 2 — Sequential Counters**: D-FFs, enables, sync reset, parameterized up/down counters.  
- **Lab 3 — FSMs**: one-hot vs binary encodings; separating next-state vs output logic.  
- **Lab 4 — Input Conditioning**: 2-FF sync, edge detect, simple debounce for `KEY`s.  
- **Lab 5 — Rate Control**: clock-enable generation (human-scale ticks), strobes.  
- **Lab 6 — Rendering**: mapping logical state to LEDs/HEX; clean output interfaces.  
- **Lab 7 — Integration & TBs**: top-level wiring, pin constraints, reusable testbench harness.

---

# Lab 8 — Final Project: Frogger

## Overview

A minimalist **Frogger** game. Move the frog from the start row to the goal row while avoiding moving cars in multiple lanes. Emphasis on single-clock design, clean FSMs, synchronized inputs, and modular rendering.

**Features**
- Debounced, one-shot movement (no diagonals)
- Multiple car lanes (configurable direction & speed)
- Collision detect + respawn (and optional lives)
- Goal detect + score increment
- Clean separation of game logic vs renderer

---

## I/O Mapping

> Adjust pins to your exact wiring. DE1-SoC `KEY` are active-low (invert in logic).

| Signal | Dir | Use                |
|-------:|:---:|--------------------|
| `KEY3` | In  | Up                 |
| `KEY2` | In  | Down               |
| `KEY1` | In  | Left               |
| `KEY0` | In  | Right              |
| `SW9`  | In  | Global reset (AH)  |
| `HEX*` | Out | Score / lives      |
| `LEDS` | Out | Compact grid / debug |

---

## Architecture


---

## Key Modules

- **`clock_divider.sv`** — Generates `game_tick` enable from `CLOCK_50`.  
- **`input_sync.sv` + `edge_detect.sv`** — 2-FF sync + rising-edge pulses for movement buttons.  
- **`frog_controller.sv`** — Maintains `(row, col)`, applies moves on `game_tick`, bounds checked.  
- **`lane_gen.sv` (parametric)** — Car bitfields shift left/right with per-lane `SPEED_DIV` and wrap.  
- **`collision.sv`** — Overlap check of `frog_cell` vs current `cars[row]`.  
- **`scoreboard.sv`** — Score++ on goal; (optional) lives–– on hit; handles respawn.  
- **`renderer.sv`** — Maps grid state to LEDs/HEX (row-scan or direct mapping).

---

## Timing & Control

- **Single source clock** (e.g., 50 MHz).  
- All updates driven by **`game_tick` enable**, not secondary clocks.  
- Movement: **edge** of a button + **game_tick** ⇒ one cell per press.  
- Lanes: shift once per tick; per-lane prescalers (e.g., tick/2, tick/3…) choose speed.

**Frog Controller (Moore-style)**
- `IDLE` → wait input  
- `MOVE_REQ` → latch direction  
- `MOVE_APPLY` → at `game_tick`, move if in-bounds  
- `COOLDOWN` → 1 tick to prevent double-steps

---

## Collision & Win Logic

- **Collision:**  
  ```verilog
  hit <= |(cars_row_bits & (1'b1 << frog_col));
