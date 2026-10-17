# Exercise 4: Factorial

## Objective
Calculate the factorial of a non-negative integer N using a separate procedure.

## C++ Model
The C++ program calculates the factorial using a loop. It initializes the result to 1 and multiplies it by each integer from 1 to N. The function returns the factorial.

## Assembly Approach
- `a0` carries the input N to the factorial procedure and receives the returned result.
- `jal ra, factorial` calls the factorial procedure and stores the return address in `ra`.
- `t0` stores the running factorial result, initialized to 1.
- `t1` stores the loop counter, initialized to 1.
- `bgt` checks whether the counter exceeds N and exits the loop.
- `mul` multiplies the current result by the counter.
- `addi` increments the counter.
- `j` jumps back to the loop.
- `mv a0, t0` places the final factorial in the return register.
- `jalr x0, ra, 0` returns to the calling procedure.
- `la` loads the address of `result`.
- `sw` stores the returned factorial in memory.
- `ecall` prints the result and terminates the program.

## Test Case
Input: N = 5

Expected result: 120

## Result
The factorial procedure calculates 5! = 120, returns the result in `a0`, and the main procedure stores and prints the result.