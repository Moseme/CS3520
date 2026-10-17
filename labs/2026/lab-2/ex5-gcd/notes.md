# Exercise 5: Greatest Common Divisor (GCD)

## Objective
Calculate the greatest common divisor of two integers using Euclid's algorithm.

## C++ Model
The C++ program uses a loop to calculate the GCD. It repeatedly calculates the remainder when `a` is divided by `b`, assigns `b` to `a`, and assigns the remainder to `b`. The loop stops when `b` becomes zero, and `a` contains the GCD.

## Assembly Approach
- `a0` stores the first argument and holds the returned GCD.
- `a1` stores the second argument.
- `s0` stores the current value of `a`.
- `s1` stores the current value of `b`.
- `rem` calculates the remainder of `a` divided by `b`.
- `beq` checks whether `b` is zero and exits the loop when it is.
- `mv` updates the values of `a` and `b` during each iteration.
- `jal` calls the `gcd` procedure.
- `sp` manages stack space, while `sw` and `lw` save and restore registers.
- `ret` returns to the calling procedure.
- The final GCD is stored in memory and printed.

## Test Case
Input: `a = 48`, `b = 18`

Expected result: `6`

## Result
The program calculates the GCD of 48 and 18 as 6, stores the result in memory, and prints the answer.