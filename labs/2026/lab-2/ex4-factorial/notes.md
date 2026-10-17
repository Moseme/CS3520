# Exercise 4: Factorial

## Objective
Calculate the factorial of a non-negative integer \(N\).

## C++ Model
The C++ program calculates the factorial using a loop. It initializes the result to 1 and multiplies it by each integer from 1 to \(N\). After the loop finishes, the function returns the factorial.

## Assembly Approach
- `t0` stores the input number `N`.
- `t1` stores the loop counter `i`.
- `t2` stores the running factorial result, initialized to 1.
- `bgt` checks whether the loop counter is greater than `N` and exits the loop when the condition is true.
- `mul` multiplies the current factorial result by the loop counter.
- `addi` increments the loop counter by one.
- `j` jumps back to the loop label to repeat the calculation.
- `la` loads the address of the result variable.
- `sw` stores the final factorial result in memory.
- `mv` moves the result into `a0` for printing.
- `ecall` prints the integer and terminates the program using the appropriate service codes.

## Test Case
Input: `N = 5`

Expected result: `120`

## Result
The program calculates \(5! = 120\), prints the result, and stores the factorial value in memory.