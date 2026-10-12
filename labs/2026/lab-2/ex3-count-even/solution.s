
.data
arr:    .word 3, 8, 4, 7, 10, 5, 12
result: .word 0

.text
.globl main

main:
    la t0, arr          # t0 = address of array
    li t1, 7            # t1 = number of elements
    li t2, 0            # t2 = index i
    li t3, 0            # t3 = count of even numbers

loop:
    bge t2, t1, finish  # if i >= 7, finish

    slli t4, t2, 2      # t4 = i * 4 (each integer is 4 bytes)
    add t5, t0, t4      # t5 = address of arr[i]
    lw t6, 0(t5)        # t6 = arr[i]

    andi a0, t6, 1      # a0 = last bit of the number
    bnez a0, next       # if odd, skip incrementing count

    addi t3, t3, 1      # count++

next:
    addi t2, t2, 1      # i++
    j loop

finish:
    la t0, result
    sw t3, 0(t0)        # store count (expected: 4)

    mv a0, t3
    li a7, 1
    ecall   

    li a7, 10
    ecall
