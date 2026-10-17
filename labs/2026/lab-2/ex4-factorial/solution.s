
.data
result: .word 0

.text
.globl main

main:
    li a0, 5              # Input: calculate 5!
    jal ra, factorial     # Call factorial procedure

    la t0, result
    sw a0, 0(t0)          # Store returned factorial

    li a7, 1              # Print integer in a0
    ecall

    li a7, 10             # Exit program
    ecall

factorial:
    li t0, 1              # Running result
    li t1, 1              # Counter i

factorial_loop:
    bgt t1, a0, factorial_done
    mul t0, t0, t1
    addi t1, t1, 1
    j factorial_loop

factorial_done:
    mv a0, t0             # Return factorial in a0
    jalr x0, ra, 0        # Return to main
