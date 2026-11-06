# Lab 3 - Step 6 Evidence

For each finding: what I looked at, what I expected, and what I actually read in Ripes.
Fill in the "Observed" column from the simulator before committing. Where the simulator
disagrees with the expectation, say so and explain it.

## A. No dedicated branch adder (cycle: `beq x5 x6 8 <skip>`, PC = 0x28)

| Port | Expected | Observed |
| --- | --- | --- |
| alu_op1_src.out | 0x00000028 (the PC) | |
| alu_op2_src.out | 8 (the immediate) | |
| alu.res | 0x00000030 (branch target) | |

Screenshot: `screenshots/step6-a-beq.png`

## B. Separate comparison unit (cycles: `beq` then `bne`)

| Cycle | Port | Expected | Observed |
| --- | --- | --- | --- |
| beq (PC = 0x28) | branch unit result | 0 (12 != 5, not taken) | |
| bne (PC = 0x2C) | branch unit result | 1 (12 != 5, taken) | |
| bne (PC = 0x2C) | pc_src.select | 1 | |

The ALU is busy computing the target in these cycles, so the comparison must be done by the
separate branch unit.

Screenshots: `screenshots/step6-b-beq.png`, `screenshots/step6-b-bne.png`

## C. Third write-back input (cycle: `jal x1 12 <report>`, PC = 0x34)

| Port | Expected | Observed |
| --- | --- | --- |
| reg_wr_src, number of inputs | 3 | |
| reg_wr_src, selected input | PC+4 | |
| reg_wr_src.out | 0x00000038 | |

For comparison, on `add` the selected input is ALURES.

Screenshot: `screenshots/step6-c-jal.png`
