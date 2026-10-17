
.data
result: .word 0

.text
.globl main

main:
    li a0, 48              # First argument: a = 48
    li a1, 18              # Second argument: b = 18

    jal ra, gcd            # Call gcd(a, b)

    la t0, result
    sw a0, 0(t0)           # Store returned GCD

    mv a1, a0               # Value to print
    li a7, 1                # Print integer
    ecall

    li a7, 10               # Exit
    ecall

gcd:
    addi sp, sp, -16        # Allocate stack space
    sw ra, 12(sp)           # Save return address
    sw s0, 8(sp)            # Save s0
    sw s1, 4(sp)            # Save s1

    mv s0, a0               # s0 = a
    mv s1, a1               # s1 = b

gcd_loop:
    beq s1, zero, gcd_done  # If b == 0, finish

    rem t1, s0, s1          # t1 = a % b
    mv s0, s1               # a = b
    mv s1, t1               # b = remainder

    j gcd_loop

gcd_done:
    mv a0, s0               # Return GCD in a0

    lw s1, 4(sp)            # Restore s1
    lw s0, 8(sp)            # Restore s0
    lw ra, 12(sp)           # Restore ra
    addi sp, sp, 16         # Release stack space

    ret
