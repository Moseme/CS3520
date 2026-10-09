# Exercise 1: Larger of Two Integers

## Objective
Determine the larger of two integers.

## C++ Model
The C++ program compares two integers using an if-else statement.

## Assembly Approach
- `li` loads the two integer values into registers.
- `bge` performs a conditional branch.
- `mv` copies the selected value into the result register.
- `sw` stores the result in memory.

## Test Case

Input values:
- a = 15
- b = 23

Expected larger value: 23

## Result
The program should select 23 because it is greater than 15.