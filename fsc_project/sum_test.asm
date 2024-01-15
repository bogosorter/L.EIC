.data
num1: .word 0x1000000A ,0x2000000B ,0x3000000C ,0x4000000D
num2: .word 0x00000000 ,0x20000000 ,0x30000000 ,0x40000000
answer1: .space 16
# Result: 0x1000000A, 0x6000000C, 0x4000000B, 0x8000000D
# Overflow bit: 0
num3: .word 0xFFFFFFFF ,0xFFFFFFFF ,0xFFFFFFFF ,0xFFFFFFFF
num4: .word 0x00000001 ,0x00000000 ,0x00000000 ,0x00000000
answer2: .space 16
# Result: 0x00000000 ,0x00000000 ,0x00000000 ,0x00000000
# Overflow bit: 1

.text
MAIN:
    la a0, num1
    la a1, num2
    la a2, answer1
    call ADD
    la a0, num3
    la a1, num4
    la a2, answer2
    call ADD
END:
    beq, zero, zero, END

ADD:
# Adds two 128 bit numbers
# Arguments: a0: address of first number
#            a1: address of second number
#            a2: address of result
# Result:    a0: 0 if no overflow, 1 if overflow
# Registers: t0: whether there was overflow on previous operation
#            t1: decrementing counter
#            t2: 32 bit addition result
#            t3: tmp

    addi sp, sp, 4
    sw ra, 0(sp)

    add t0, zero, zero
    addi t1, zero, 4

    LOOP1:
        # Calculate 32 bit addition result
        lw t3, 0(a0)
        add t5, t0, t3
        lw t3, 0(a1)
        add t2, t5, t3
        sw t2, 0(a2)
        # Set overflow flag
        slt t0, t2, t3
        slt t5, t2, t5
        or t0, t0, t5

        # Increment adresses
        addi a0, a0, 4
        addi a1, a1, 4
        addi a2, a2, 4

        addi t1, t1, -1
        bne t1, zero, LOOP1

    # Store overflow flag
    add a0, t0, zero

    lw ra, 0(sp)
    addi sp, sp, -4
    ret
