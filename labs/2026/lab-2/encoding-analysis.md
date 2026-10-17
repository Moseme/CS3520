# Lab 2: RISC-V Instruction Encoding Analysis

1. B-Type Instruction: Conditional Branch

Assembly instruction:
beq x9, x0, 20

Address:0x44

Machine code:0x00048A63

32-bit binary encoding:

00000000000001001000101001100011


Instruction Fields

| Field | Bits | Value | Meaning |
|---|---|---|---|
| imm[12] | 31 | 0 | Immediate bit |
| imm[10:5] | 30–25 | 000000 | Immediate bits |
| rs2 | 24–20 | 00000 | Source register x0 |
| rs1 | 19–15 | 01001 | Source register x9 |
| funct3 | 14–12 | 000 | BEQ operation |
| imm[4:1] | 11–8 | 1010 | Immediate bits |
| imm[11] | 7 | 0 | Immediate bit |
| opcode | 6–0 | 1100011 | Branch instruction |

The immediate fields are rearranged when the processor reconstructs the branch offset of 20 bytes. The instruction branches to address `0x58` when the values in x9 and x0 are equal.

2. J-Type Instruction: Unconditional Jump

Assembly instruction:

jal x0, -16

Address: 0x54

Machine code:0xFF1FF06F

32-bit binary encoding:

11111111000111111111000001101111

Instruction Fields

| Field | Bits | Value | Meaning |
|---|---|---|---|
| imm[20] | 31 | 1 | Immediate bit |
| imm[10:1] | 30–21 | 1111111000 | Immediate bits |
| imm[11] | 20 | 1 | Immediate bit |
| imm[19:12] | 19–12 | 11111111 | Immediate bits |
| rd | 11–7 | 00000 | Destination register x0 |
| opcode | 6–0 | 1101111 | JAL instruction |

The immediate fields are rearranged to reconstruct the signed jump offset of -16 bytes. The jump goes from address `0x54` back to address `0x44`, returning to the beginning of the GCD loop. Since the destination register is x0, the return address is discarded.

3. Why Are Immediate Bits Scattered?

RISC-V scatters immediate bits in B-type and J-type instructions to keep the instruction length fixed and simplify hardware decoding. The register fields and opcode remain in consistent positions across instruction formats, allowing the processor to identify registers and instruction types efficiently. The processor rearranges the immediate bits to reconstruct the signed offset before calculating the branch or jump target.

The B-type format is used for conditional branches, while the J-type format is used for jumps such as JAL.