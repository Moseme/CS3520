# Exercise 3: Count Even Numbers

## Objective
Count the number of even integers in an array.

## C++ Model
The C++ program traverses an array using a loop. For each element, it checks whether the remainder after division by 2 is zero. If it is, the counter increases by one.

## Assembly Approach
- `t0` stores the base address of the array.
- `t1` stores the number of elements.
- `t2` stores the current array index.
- `t3` stores the count of even numbers.
- `slli` calculates the byte offset of the current element because each integer occupies 4 bytes.
- `lw` loads the current element from memory.
- `andi` checks the least significant bit to determine whether the number is even or odd.
- `bnez` skips the counter increment when the number is odd.
- `addi` increments the counter when an even number is found.
- The final count is stored in memory.

## Test Case
Array: `{3, 8, 4, 7, 10, 5, 12}`

Expected result: `4`

## Result
The program counts four even numbers and stores the result in memory.