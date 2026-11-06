# Lab 3 - Trace Tables

Processor: Ripes RISC-V Single Cycle, Extended layout. Program: `trace-classes.s`.
Register aliases: x5 = t0, x6 = t1, x7 = t2, x10 = a0.

## Step 3 - `add t2, t0, t1` (PC = 0x00000008, t0 = 12, t1 = 5)

| Element | Port | Value |
| --- | --- | --- |
| pc_reg | out | 0x00000008 |
| pc_4 | out | 0x0000000C |
| instr_mem | data_out | 0x006283B3 |
| decode | r1_reg_idx / r2_reg_idx | 5 / 6 |
| decode | wr_reg_idx | 7 |
| control | reg_do_write_ctrl | 1 |
| control | alu_op2_ctrl | REG2 (register, not immediate) |
| registerFile | r1_out / r2_out | 12 / 5 |
| alu_op1_src | out | 12 (register rs1, not PC) |
| alu_op2_src | out | 5 (register rs2, not immediate) |
| alu | res | 17 |
| data_mem | wr_en | 0 |
| reg_wr_src | select / out | ALURES / 17 |
| pc_src | select / out | 0 / 0x0000000C |

Hand check of the encoding (R-type: funct7 | rs2 | rs1 | funct3 | rd | opcode):
`0000000 | 00110 | 00101 | 000 | 00111 | 0110011` = `0000 0000 0110 0010 1000 0011 1011 0011` = **0x006283B3**.

## Step 4 - one row per instruction class

The Instruction memory panel lists 18 instructions (17 source lines, but `la a0, ...`
expands to `auipc a0, 0x10000` + `addi a0, a0, -24`, at 0x18 and 0x1c).

| Instruction | Format | imm | op1 mux | op2 mux | alu.res | wb mux / pc mux |
| --- | --- | --- | --- | --- | --- | --- |
| addi t0, zero, 12 | I | 12 | reg (0) | imm (12) | 12 | ALURES / PC+4 |
| add t2, t0, t1 | R | n/a | reg (12) | reg (5) | 17 | ALURES / PC+4 |
| lui t4, 0x2B | U | 0x2B000 (176128) | reg (unused, ALU passes op2) | imm | 0x0002B000 (176128) | ALURES / PC+4 |
| auipc t5, 0x0 | U | 0 | PC (0x14) | imm (0) | 0x00000014 (20) | ALURES / PC+4 |
| lw a1, 0(a0) | I | 0 | reg (a0 = 0x10000000) | imm (0) | 0x10000000 | memory data / PC+4 |
| sw t2, 4(a0) | S | 4 | reg (a0 = 0x10000000) | imm (4) | 0x10000004 (268435460) | none written (register write = 0) / PC+4 |
| beq t0, t1, skip | B | 8 | PC (0x28) | imm (8) | 0x00000030 (target) | none written / select 0, not taken, PC+4 = 0x2C |
| bne t0, t1, target | B | 8 | PC (0x2C) | imm (8) | 0x00000034 (target) | none written / select 1, taken, PC = 0x34 |
| jal ra, report | J | 12 | PC (0x34) | imm (12) | 0x00000040 (target) | PC+4 (0x38 into ra) / select 1, PC = 0x40 |
| jalr zero, ra, 0 | I | 0 | reg (ra = 0x38) | imm (0) | 0x00000038 (target) | PC+4 (0x48 aimed at x0, discarded) / select 1, PC = 0x38 |

Execution order: 0x0, 4, 8, c, 10, 14, 18, 1c, 20, 24, 28, 2c, 34, 40, 44, 38, 3c.
`beq` is not taken (12 != 5), `bne` is taken, so `skip` at 0x30 never executes.

Evidence from Ripes: t4 = 0x0002b000 after `lui`; a0 = 0x10000000 and t2 = 0x11 at the `sw`;
branch unit "taken" output = 0 during `beq`; pc_4.out = 0x2c during `beq`.

## Step 5 - statistics

| Item | Value |
| --- | --- |
| Instructions listed in panel | 18 |
| Instructions never executed | 1 (0x30, `addi a2, zero, 99`) |
| Distinct instructions executed | 17 |
| Cycles (pipeline diagram, cycles 0-17) | 18 |
| CPI | 1.00 (one instruction per cycle) |
| IPC | 1.00 |

Note: in the pipeline diagram `addi x12 x0 7` (0x40) shows two dots, cycle 13 and cycle 17. The
second is the instruction after the `ecall` at 0x3c, which Ripes fetched and ran once more before
stopping, which is why the run is 18 cycles and not 17.
