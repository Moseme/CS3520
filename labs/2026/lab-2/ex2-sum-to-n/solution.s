.data
result: .word 0

.text
.globl main

main:
    li t0, 5          # t0 = N
    li t1, 1          # t1 = i
    li t2, 0          # t2 = sum

loop:
    bgt t1, t0, finish    # If i > N, exit the loop

    add t2, t2, t1        # sum = sum + i
    addi t1, t1, 1        # i = i + 1

    j loop                # Repeat the loop

finish:
    la t3, result         # Load address of result
    sw t2, 0(t3)          # Store sum in memory

    # Print sum
    mv a0, t2             # Move sum to a0 for printing
    li a7, 1              # Print integer 
    ecall

    li a7, 10             # Exit program
    ecall