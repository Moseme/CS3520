# Lab 2: Discussion Questions

## 1. Why does the C++ loop use `i < n`, while the assembly uses `bge` (`i >= n`)?

The C++ loop continues while `i < n`. The assembly uses `bge` to branch to the loop exit when `i >= n`. The condition is inverted because the assembly branch is used to exit the loop when the C++ continuation condition is no longer true.

## 2. What do the pseudo-instructions `li`, `mv`, `la`, and `ble` become, and why are they provided?

- `li` (load immediate) is translated into one or more real instructions, such as `addi` or `lui` followed by `addi`, depending on the value.
- `mv` (move) is translated into `addi` with an immediate of zero.
- `la` (load address) is translated into one or more real instructions to calculate and load an address, depending on the addressing mode and distance.
- `ble` (branch if less than or equal) is typically translated into `bge` with the operands reversed.

These pseudo-instructions make assembly code easier to read and write by providing convenient shorthand for common operations.

## 3. Why does `find_max` save `s1` on the stack but not save `ra`?

The register `s1` is a callee-saved register. If a procedure uses it, it must preserve its original value and restore it before returning.

The register `ra` holds the return address. If `find_max` is a leaf procedure, meaning it does not call another procedure, its return address is not overwritten by another procedure call. Therefore, it does not need to save `ra` on the stack.
