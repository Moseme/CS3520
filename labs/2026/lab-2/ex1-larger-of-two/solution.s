.data
result: .word 0

.text
.globl main

main:
    # Load the two integers into registers
    li t0, 15
    li t1, 23

    # If b >= a, jump to choose_b
    bge t1, t0, choose_b

    # Otherwise, a is larger
    mv t2, t0
    j finish

choose_b:
    # Select b
    mv t2, t1

finish:
    # Store the result in memory
    la t3, result
    sw t2, 0(t3)

    # Print the result
    mv a0, t2
    li a7, 1    
    ecall

    # End of program
    li a7, 10
    ecall