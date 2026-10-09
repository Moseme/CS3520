# Exercise 2: Sum of the First N Integers

## Objective
Calculate the sum of the first N positive integers.

## C++ Model
The C++ program uses a `for` loop to iterate from 1 to N. During each iteration, the current value of `i` is added to the running total stored in `sum`.

## Assembly Approach
- `t0` stores N.
- `t1` stores the current integer i.
- `t2` stores the running sum.
- A conditional branch ends the loop when i exceeds N.
- The `add` instruction accumulates the sum.
- The `addi` instruction increments i.
- The final sum is stored in memory.

## Test Case
N = 5

Calculation: 1 + 2 + 3 + 4 + 5

Expected result: 15

## Result
The program should calculate and store 15.