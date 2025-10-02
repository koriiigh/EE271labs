EE 271 — DE1-SoC Labs
This repository contains my EE 271 lab work on the Terasic DE1-SoC FPGA board using SystemVerilog, Quartus, and ModelSim. Each lab folder includes source files, constraints/pin assignments, and (where applicable) a testbench.
Note on Lab 8: I chose to implement Frogger for the final project. Details below.
Repo Structure
EE271labs/
  Lab1/
  Lab2/
  Lab3/
  Lab4/
  Lab5/
  Lab6/
  Lab7/
  Lab8_Frogger/
    src/                 # SystemVerilog sources
    tb/                  # testbench(s) and .do scripts
    quartus/             # .qpf, .qsf, pin assignments
    docs/                # writeup, notes, block diagrams
  README.md
Tooling & Conventions
Single synchronous clock for sequential logic; slower behaviors use clock-enables (no derived clocks).
Active-high synchronous reset with 2-FF input synchronizers for all asynchronous inputs (e.g., buttons).
Clean separation of datapath, controller (FSM), and I/O wrappers.
Simulation before synthesis (assertions where helpful).
Consistent file headers and module naming.
Labs 1–7 (Brief Summaries)
These are short summaries—adjust to reflect your exact deliverables.
Lab 1 — Combinational Logic & Seven-Seg Basics
Simple combinational modules, truth tables, priority encoders/decoders, and mapping to HEX displays.
Lab 2 — Sequential Elements & Counters
D-FFs, enables, synchronous reset, and parameterized counters with rollover; basic timing checks in ModelSim.
Lab 3 — Finite State Machines (FSM)
One-hot vs binary encoding, next-state/output logic separation, Mealy vs Moore tradeoffs.
Lab 4 — Input Conditioning
2-FF synchronizers, one-shot edge detectors, and simple debouncing for KEY inputs.
Lab 5 — Timers & Rate Control
Clock-enable generation for human-scale updates (e.g., 5–15 Hz game ticks), rate dividers, and strobes.
Lab 6 — Display/Renderer Plumbing
Clean interfaces for driving LEDs/HEX (and/or simple grid renderers), mapping logical state to outputs.
Lab 7 — Integration & Testbenches
Bringing modules together, top-level pin constraints, and a reusable testbench harness with directed tests.
Lab 8 — Final Project: Frogger
Overview
A minimalist Frogger-style game on the DE1-SoC. The player guides a frog from the start row to the goal row while avoiding moving cars. The design emphasizes single-clock discipline, clean FSM control, synchronized inputs, and modular rendering.
Key Features
Player movement with debounced one-shot inputs (no diagonals).
Multiple car lanes with configurable directions and speeds.
Collision detection (frog ↔ car overlap) and respawn.
Win/goal detection with score increment and reset to start.
Clean separation of game logic and rendering.
I/O (Adjust to your wiring)
Inputs
KEY[3:0]: UP, DOWN, LEFT, RIGHT (active-low on DE1-SoC; inverted in logic)
SW[9]: global reset (active-high)
Outputs
HEX or LEDs to visualize frog, cars, score; or a compact “row renderer” on LEDs.
Optional: additional HEX for lives/level.
Architecture
        +-------------------+
        |  clock_divider    | --> game_tick (enable @ ~10 Hz)
        +-------------------+
                 |
                 v
+----------------+-------------------+
|   input_sync & edge_detect         |   # 2-FF sync + one-shots for KEYs
+----------------+-------------------+
                 |
                 v
+----------------+-------------------+       +-------------------+
|  frog_controller (FSM/datapath)    |       |  lane_gen[N]      |
|  - holds frog row/col              |<----->|  - shift regs     |
|  - bounds checking                 |       |  - dir & speed    |
+----------------+-------------------+       |  - wrap patterns  |
                 |                            +-------------------+
                 v
          +-------------+
          | collision   |--> hit / safe
          +-------------+
                 |
                 v
          +-------------+             +-------------------+
          | score/lives |-----------> | renderer          |--> LEDs/HEX
          +-------------+             +-------------------+
Key Modules (rename to match your files)
clock_divider.sv — generates game_tick enable from CLOCK_50.
input_sync.sv + edge_detect.sv — 2-FF sync + rising-edge pulses for movement.
frog_controller.sv — maintains (row,col), applies moves on game_tick.
lane_gen.sv (parametric N instantiations) — car bitfields that shift left/right with per-lane rates.
collision.sv — overlap check: frog_cell & car_cells[row].
scoreboard.sv — score++ on goal; lives-- on collision (or instant respawn).
renderer.sv — maps grid state to LEDs/HEX cleanly.
Timing & Control
Single source clock (e.g., CLOCK_50).
All moving parts updated on game_tick (an enable, not a derived clock).
Player moves: edge of button + game_tick → one cell/step.
Car lanes: shift once per tick; per-lane prescalers adjust speed (e.g., tick/2, tick/3).
State Machines
Frog Controller (Moore)
States: IDLE → MOVE_REQ → MOVE_APPLY → COOLDOWN
IDLE: wait for any input edge.
MOVE_REQ: latch direction (mutually exclusive).
MOVE_APPLY: apply if in-bounds (at game_tick).
COOLDOWN: 1 tick dead-time to avoid double steps.
Game State (Optional)
SPAWN, PLAY, HIT, GOAL with timers for on-board feedback.
Collision / Win Logic
Collision: hit <= (cars[row] & onehot(col)) != 0;
Goal: reaching TOP_ROW without hit within the same tick.
Priority: detect hit first, then goal (or vice versa, but be consistent and test both edge cases).
Rendering
Compact LED renderer:
Drive one row per fast scan and OR in frog/car bits (persistence makes it appear steady).
HEX score:
Two HEX digits for score; optional lives indicator.
Keep renderer pure-comb where possible; latch only what’s needed for scan timing.
Simulation Plan (ModelSim)
Unit tests: frog_controller_tb.sv, lane_gen_tb.sv, collision_tb.sv
Top test: frogger_tb.sv with tasks:
press_up(), press_left(), etc. (generate a clean pulse)
Drive game_tick periodically (e.g., every 5 µs).
Checks:
Moves bounded; no diagonal; single step per pulse.
Cars wrap correctly; per-lane speeds differ.
Collision → respawn; Goal → score++ & respawn.
Synthesis / Board Bring-Up
Open Quartus project (Lab8_Frogger/quartus/*.qpf), add sources.
Verify pin assignments for KEY, SW, LEDs/HEX match the DE1-SoC user manual.
Compile; fix any timing warnings (should be clean with one clock + enables).
Program the board and test:
Ensure reset brings frog to start.
Validate one-step motion & lane movement rate.
Confirm collision/goal events.
Parameters & Tuning
GRID_COLS, GRID_ROWS (e.g., 16×8)
LANE_COUNT, per-lane DIR and SPEED_DIV
TICK_HZ (game difficulty)
Optional: LIVES_MAX, SCORE_MAX
Known Limitations / Future Work
Fixed car patterns (add LFSR for pseudo-random traffic).
No pause or sound.
Limited visual resolution with LEDs/HEX (VGA upgrade possible).
Single speed per lane (could accelerate with level).