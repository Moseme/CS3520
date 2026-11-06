# Lab 3 - Datapath Notes

## Think questions (Steps 2, 3, 5)

**Step 2 - the third write-back input.** The third input of `reg_wr_src` is PC+4. `jal` and `jalr`
cannot work without it, because they must save the return address (the address of the next
instruction) into `rd`. The two-way MemtoReg signal in the Week 7 truth table has no way to do this.

**Step 3 - why `data_mem.addr` holds a value on an `add`.** The address port is wired directly to
`alu.res`, so it simply shows the ALU result (17). In the first cycle (`addi`, ALU result 0xc) the
data memory output showed 0x40628e33, the encoding of the instruction stored at 0xc, because code and
data share one memory. It is harmless because `data_mem.wr_en` is 0, so nothing is written, and the
write-back mux does not select the memory output (it selects ALURES), so the read data is ignored.
The cost is time: memory sits in series on every instruction's path, so the clock period must be long
enough for the slowest instruction (`lw`), and every instruction pays for it.

**Step 5 - what the design sacrificed.** CPU time = IC x CPI x Tc. IC is the same for any
implementation of the ISA, and CPI = 1.00 is the best possible, so the cost is in **Tc**. The
single clock period must cover the longest path (`lw`: fetch, register read, ALU, data memory,
register write), so every instruction runs at the speed of the slowest. A pipeline cuts Tc to
roughly the longest single stage, a gain of about the number of stages (about 4-5x for five stages)
at CPI slightly above 1. Exact factor = Tc(single-cycle, sum of the `lw` path delays) divided by
Tc(longest stage), using the component delays from the Week 7 worked exercise.

## Step 4 questions

1. **lui vs auipc.** Both are U-format and produce the same immediate (imm << 12). The difference
   is the `alu_op1_src` multiplexer together with the ALU operation. For `auipc` the mux selects
   the **PC**, so the ALU computes PC + imm. For `lui` the register input is not used and the ALU
   passes the immediate (operand 2) straight through, so the result is just imm.
2. **sw.** The control signal is **reg_do_write_ctrl (RegWrite) = 0**, together with
   `data_mem.wr_en = 1`. The write-back multiplexer still has some input selected and still shows a
   value, but that value goes nowhere because the register file's write-enable is 0.
3. **Branch path.** Register values go into the **branch unit**, whose `res` says whether the
   condition is true. That goes through the **`br_and` AND gate**, which ANDs it with the control
   unit's branch signal, so it only matters for branch instructions. The result then goes through the
   **`controlflow_or` OR gate**, which also takes the jump signal (`jal`/`jalr`), and the output is
   `pc_src.select`. For `beq` (12 != 5) the branch unit gives 0, so the AND gives 0, select is 0 and the
   PC takes PC+4. For `bne` the branch unit gives 1, the AND gives 1, the OR gives 1, select is 1 and
   the PC takes the ALU-computed target.
4. **jal / jalr return address.** It comes from the **PC+4 input** of the write-back multiplexer.
   The ALU cannot supply it because in the same cycle it is busy computing the jump target
   (PC + imm, or rs1 + imm). Data memory cannot supply it because it only returns data loaded from
   an address, and has no connection to the PC.

## Step 6 - three differences from the Week 6 textbook datapath

**A. No dedicated branch adder.** The branch (and `jal`) target is computed by the main ALU.
`alu_op1_src` selects the PC and `alu_op2_src` selects the immediate, so the ALU computes PC + offset.
*Gained:* one whole adder removed (less area and power), at the price of an extra operand mux. It is
possible only because branch comparison is done elsewhere (finding B), leaving the ALU free.

**B. A separate branch comparison unit.** The textbook tests `beq` with the ALU's Zero flag after a
subtraction. Here a dedicated unit compares the two registers directly. It can do what a Zero flag
cannot: signed and unsigned less-than and greater-or-equal, which a subtract-and-test-Zero scheme gets
wrong when the subtraction overflows. Instructions that need it: `beq`, `bne`, `blt`, `bge`, `bltu`,
`bgeu`. *Gained:* the complete branch set, no overflow problem, and the ALU is free to compute the
target at the same time as the comparison (which is what makes finding A work).

**C. Three-input write-back multiplexer.** Inputs are ALU result, memory data and **PC+4**. The third
input is needed by `jal` and `jalr`, which write the return address (PC+4) to `rd`. *Gained:* link
instructions with no extra ALU pass; the ALU is used for the target while PC+4 (already computed by
`pc_4`) goes straight to the register file.

**Think: dedicated adder vs reusing the ALU.** A dedicated adder (textbook) costs extra area but
works in parallel, so the target can be computed in the same cycle as other ALU work and the ALU
never needs an extra operand mux in front of it. This is the right choice when speed or parallelism
matters, for example in a pipeline where the target is computed early to shorten the branch penalty.
Reusing the ALU (this implementation) saves an adder and its power, at the price of an extra mux on
the ALU input and the ALU being busy with the target. It is the right choice when area and cost are the
priority and the ALU would otherwise be idle during a branch, as it is in a simple single-cycle design.

## Other observation

A small multiplexer feeding the PC adder has inputs 4 and 2. It lets the PC advance by 2 for 16-bit
compressed instructions. For this program every instruction is 32-bit, so it selects 4.
