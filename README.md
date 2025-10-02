# EE 271 — DE1-SoC Labs

A collection of my EE 271 labs for the Terasic **DE1-SoC** board using **SystemVerilog**, **Quartus**, and **ModelSim**.

> **Lab 8 (Final Project): Frogger** — implemented a minimalist Frogger-style game with clean single-clock design, input synchronization, modular lanes, collision detection, and a compact LED/HEX renderer.

---

## Table of Contents
- [Repo Structure](#repo-structure)
- [Tooling & Conventions](#tooling--conventions)
- [Labs 1–7 (Brief Summaries)](#labs-17-brief-summaries)
- [Lab 8 — Final Project: Frogger](#lab-8--final-project-frogger)
  - [Overview](#overview)
  - [Source Files](#source-files)
  - [I/O Mapping](#io-mapping)
  - [Architecture](#architecture)
  - [Timing & Control](#timing--control)
  - [Simulation](#simulation)
  - [Synthesis / Board Bring-Up](#synthesis--board-bring-up)
  - [Parameters & Tuning](#parameters--tuning)
  - [Known Limits / Future Work](#known-limits--future-work)
  - [Demo / Grading Checklist](#demo--grading-checklist)

---

## Repo Structure


---

## Tooling & Conventions

- **Single synchronous clock** (no derived clocks); slower behavior via **clock-enable** pulses.
- **Active-high synchronous reset** (asynchronous inputs go through **2-FF sync** + **edge detect**).
- Clear separation of **datapath**, **controller (FSM)**, and **I/O renderers**.
- Sim before synth; directed tests where helpful.

---

## Labs 1–7 (Brief Summaries)

- **Lab 1 — Combinational & Seven-Seg**: truth tables/decoders, HEX basics.  
- **Lab 2 — Sequential Counters**: D-FFs, enables, synchronous reset.  
- **Lab 3 — FSMs**: one-hot vs binary encodings; next-state vs output split.  
- **Lab 4 — Input Conditioning**: 2-FF sync + one-shot edges for `KEY` inputs.  
- **Lab 5 — Rate Control**: clock-enable generation, human-scale ticks.  
- **Lab 6 — Rendering**: clean mapping to LEDs/HEX.  
- **Lab 7 — Integration**: top-level wiring, pin constraints, reusable TB harness.

---

# Lab 8 — Final Project: Frogger

## Overview
A compact **Frogger-style** game. Move the frog from the start row to the goal row while avoiding cars that shift across multiple lanes. Emphasizes clean timing (one clock + enables), input synchronization, modular lane generators, and simple collision/goal logic.

### Features
- Debounced, one-shot movement (no diagonals).
- Multiple car lanes with configurable direction and speed.
- Collision detect + respawn (optional lives/score).
- Score display on **HEX**; minimal LED grid renderer for playfield.

---

## Source Files

| File                | Role |
|---------------------|------|
| `DE1_SoC.sv`        | Top level: clocks, reset, pin mapping, module instantiation. |
| `FroggerGame.sv`    | Core game logic: frog position, bounds, collision, goal, score/lives. |
| `CarController.sv`  | Parametric lane generator(s): directional shifting, per-lane speed/wrap. |
| `User_Input.sv`     | 2-FF input synchronizers + edge detection for `KEY[3:0]`. |
| `LEDDriver.sv`      | LED grid / row-scan or direct mapping of frog/cars to LEDs. |
| `seg7.sv`           | Seven-segment encoder (score/lives/level). |
| `clock_divider.sv`  | Base clock → game tick **enable** (e.g., ~5–15 Hz). |
| `LFSR.sv`           | Optional pseudo-random patterns for cars/difficulty. |
| `VictoryCounter.sv` | Tracks wins/levels; drives HEX and/or difficulty step-up. |

---

## I/O Mapping

> Adjust to your exact wiring. DE1-SoC `KEY` are **active-low**; invert in logic or inside `User_Input.sv`.

| Signal | Dir | Use                         |
|-------:|:---:|-----------------------------|
| `KEY3` | In  | Move **Up**                 |
| `KEY2` | In  | Move **Down**               |
| `KEY1` | In  | Move **Left**               |
| `KEY0` | In  | Move **Right**              |
| `SW9`  | In  | Global **Reset** (active-high) |
| `HEX*` | Out | Score / lives / victory count |
| `LED*` | Out | Compact grid / debug status   |

---

## Architecture


---

## Timing & Control

- All sequential logic uses **the same base clock**.  
- Movement & lane shifts apply **on `game_tick` enable** (no second clock domain).  
- Button press = **edge** + **tick** ⇒ one cell per move (bounded).  
- Each lane has its own prescaler (e.g., shift every N ticks) for speed differences.

**Typical Frog FSM (Moore)**:
- `IDLE` → wait input edge  
- `MOVE_REQ` → latch direction  
- `MOVE_APPLY` → on `game_tick`, update `(row,col)` if in bounds  
- `COOLDOWN` → 1 tick to prevent double-step

---

## Simulation

**Top-level idea**: drive `CLOCK_50`, generate periodic `game_tick`, pulse `KEY` edges, and assert expected frog/collision/goal behavior.

Example ModelSim snippet:
```tcl
vlib work
vlog -sv ./Lab8_Frogger/src/*.sv
# vsim top: replace with your TB or top-level
vsim work.DE1_SoC
run 10 ms
Checklist:
Movement is 1 step per edge+tick; no diagonal.
Lanes shift with correct direction/speed and wrap.
Collision → respawn (or life decrement).
Reaching goal → score/victory increments, respawn.
Synthesis / Board Bring-Up
Open Quartus project in Lab8_Frogger/quartus/.
Verify pin assignments for KEY, SW, LED, and HEX.
Compile (single clock + enables should keep timing clean).
Program board: test reset → spawn, per-press movement, lane speeds, collision/goal paths.
Parameters & Tuning
Grid size: GRID_COLS, GRID_ROWS (e.g., 16×8).
Lane config: LANE_COUNT, per-lane DIR, SPEED_DIV.
Game rate: TICK_HZ in clock_divider.sv.
Score/lives: adjust in FroggerGame.sv / VictoryCounter.sv.
Randomization: enable LFSR.sv for pseudo-random car patterns.
Known Limits / Future Work
LED/HEX resolution is limited (consider VGA/HDMI renderer).
Deterministic lane patterns unless LFSR is enabled.
No audio or pause menu (possible extensions).
Single speed per lane (could scale with level/victories).