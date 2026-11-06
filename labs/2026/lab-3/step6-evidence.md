# Lab 3 - Step 6 Evidence

For each finding: what I looked at, what I expected, and what I actually read in Ripes.
"Not read" means I did not take that reading from the simulator.

## A. No dedicated branch adder (cycle: `beq x5 x6 8 <skip>`, PC = 0x28)

| Port | Expected | Observed |
| --- | --- | --- |
| alu_op1_src.out | 0x00000028 (the PC) | 0x00000028 |
| alu_op2_src.out | 8 (the immediate) | 0x00000008 |
| alu.res | 0x00000030 (branch target) | 0x00000030 |

Conclusion: the main ALU computes the branch target (PC + offset = 0x28 + 8 = 0x30). There is no
separate branch adder, as the Week 6 figure would show.

## B. Separate comparison unit (cycles: `beq` then `bne`)

| Cycle | Port | Expected | Observed |
| --- | --- | --- | --- |
| beq (PC = 0x28) | branch unit result ("taken") | 0 (12 != 5, not taken) | 0 (shown red in the Ripes view) |
| bne (PC = 0x2C) | branch unit result ("taken") | 1 (12 != 5, taken) | not read |
| bne (PC = 0x2C) | PC mux input 1 | 0x00000034 (branch target) | 0x00000034 |
| bne (PC = 0x2C) | pc_src.select | 1 | 1, inferred: the pipeline diagram shows `jal` (0x34) executing in the cycle right after `bne`, so the PC mux took the target input |

Conclusion: while the branch is being decided, the ALU is busy computing the branch target
(finding A), so the comparison of the two registers is done by the separate branch unit.

## C. Third write-back input (cycle: `jal x1 12 <report>`, PC = 0x34)

| Port | Expected | Observed |
| --- | --- | --- |
| reg_wr_src, number of inputs | 3 | 3 (visible on the write-back mux in every Ripes screenshot) |
| reg_wr_src input 2 (third input) | PC+4 = 0x00000038 | 0x00000038 |
| reg_wr_src, selected input | PC+4 | not read |
| ra (x1) after the `jal` | 0x00000038 | not read |

Conclusion: the write-back mux has a third input that carries PC+4 (0x34 + 4 = 0x38), the return
address. The textbook two-input MemtoReg mux has no such input.
