# 3-to-8 Decoder: Layered SystemVerilog Testbench

A class-based, layered testbench for a 3-to-8 decoder, written in SystemVerilog.
It uses randomized stimulus, a self-checking scoreboard with a reference model,
and functional coverage.

**Live demo:** [Run on EDA Playground](https://edaplayground.com/x/btTp)

## Decoder behavior

The 3-bit input `a` selects which one of the 8 output bits in `y` is set.

| a   | y        |
|-----|----------|
| 000 | 00000001 |
| 001 | 00000010 |
| 010 | 00000100 |
| 011 | 00001000 |
| 100 | 00010000 |
| 101 | 00100000 |
| 110 | 01000000 |
| 111 | 10000000 |

## Features

- Randomized stimulus on the 3-bit input
- Layered, class-based architecture connected by mailboxes
- Self-checking scoreboard with reference model (`1 << a`)
- Functional coverage on all input values and all one-hot outputs
- Pass/fail counters and coverage summary at the end of the run

## Testbench architecture

```
generator --> driver --> [ Decoder (DUT) ] --> monitor --> scoreboard
   (mailbox)  (virtual interface)  (virtual interface)    (mailbox)
                                                              |
                                                           coverage
```

| Component   | Role                                                            |
|-------------|-----------------------------------------------------------------|
| transaction | Randomized input `a` plus output `y`                            |
| generator   | Creates random transactions and sends them to the driver        |
| driver      | Drives the DUT input through a virtual interface                |
| monitor     | Samples DUT input and output and sends them to the scoreboard   |
| scoreboard  | Computes expected output, compares with actual, counts pass/fail |
| coverage    | Covergroup sampled by the scoreboard for every transaction      |
| environment | Builds and connects all components                              |
| test        | Program block that creates and runs the environment             |
| testbench   | Top module: instantiates the interface, DUT and test            |

## Functional coverage

| Coverpoint | What it measures                          |
|------------|-------------------------------------------|
| `cp_a`     | Each of the 8 input values (0 to 7)       |
| `cp_y`     | Each of the 8 one-hot output patterns     |

## Project structure

```
Decoder/
├── rtl/
│   └── design.sv
└── tb/
    ├── interface.sv
    ├── transaction.sv
    ├── coverage.sv
    ├── generator.sv
    ├── driver.sv
    ├── monitor.sv
    ├── scoreboard.sv
    ├── environment.sv
    ├── test.sv
    └── testbench.sv
```

## How to run

Only `design.sv` and `testbench.sv` are compiled directly. The other
testbench files are pulled in with `` `include ``.

QuestaSim:

```
vlog -mfcu +incdir+tb rtl/design.sv tb/testbench.sv
vsim -c top -do "run -all; exit"
```

EDA Playground: put `design.sv` in the design pane, the testbench files in
the testbench pane, and select QuestaSim.

The number of vectors is set with `repeat(100)` in the generator, driver,
monitor and scoreboard. Change all four together.

## Sample result

```
[SCO][PASS] a=100 output correct: 00010000
[SCO][PASS] a=011 output correct: 00001000
[SCO][PASS] a=111 output correct: 10000000
--------------------------------------
Total=100  PASS=100  FAIL=0
Functional coverage = 100.00%
--------------------------------------
```

100 random vectors, all checks passed, and every input value and output
pattern was covered.

