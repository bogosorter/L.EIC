.data
num2: .word 0x00000002 ,0x00000000 ,0x00000000 ,0x00000000
num3: .word 0x00000003 ,0x00000000 ,0x00000000 ,0x00000000
num4: .word 0x00000004 ,0x00000000 ,0x00000000 ,0x00000000
factorial3: .space 16
factorial4: .space 16
aux1: .space 16
aux2: .space 16
aux3: .space 16
aux4: .space 17


.text
MAIN:
    la a0, num2
    la a1, num3
    la a2, factorial3
    la a3, aux1
    la a4, aux2
    call MULT

    la a0, factorial3
    la a1, num4
    la a2, factorial4
    la a3, aux3
    la a4, aux4
    call MULT

    # Exiting program
    addi a0, zero, 10
    ecall

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
        add t2, t0, t3
        lw t3, 0(a1)
        add t2, t2, t3
        sw t2, 0(a2)
        # Set overflow flag
        slt t0, t2, t3

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


MULT:
# Multiplies two 128 bit numbers, ignoring overflow
# Arguments: a0: address of first number
#            a1: address of second number
#            a2: address of result (zeroed)
#            a3: zeroed 128 bit number
#            a4: zeroed 128 bit number
# Result:    a0: 0 if no overflow, 1 if overflow
# Registers: s0: address of first number
#            s1: address of second number
#            s2: address of result (zeroed)
#            s3: zeroed 128 bit number
#            s4: zeroed 128 bit number
#            s5: overflow
#            s6: tmp
    addi sp, sp, 4
    sw ra, 0(sp)

    add s0, a0, zero
    add s1, a1, zero
    add s2, a2, zero
    add s3, a3, zero
    add s4, a4, zero
    add s5, zero, zero

    addi s6, zero, 1
    sw s6, 0(s4)
    # s4 allways points to number 1
    # s3 is the loop counter
    

    # First line
    MULT_LOOP:

        add a0, s1, zero
        add a1, s2, zero
        add a2, s2, zero
        call ADD
        or s5, s5, a0

        # Increment variable
        add a0, s4, zero
        add a1, s3, zero
        add a2, s3, zero
        call ADD

        add a0, s0, zero
        add a1, s3, zero
        call EQUAL
        beq a0, zero, MULT_LOOP
    
    lw ra, 0(sp)
    addi sp, sp, -4
    ret

EQUAL:
# Whether two 128 bit numbers are equal
# Arguments: a0: address of first number
#            a1: address of second number
# Result:    a0: 1 if equal else 0
    addi sp, sp, 4
    sw ra, 0(sp)

    lw t0, 0(a0)
    lw t1, 0(a1)
    bne t0, t1, NO

    lw t0, 1(a0)
    lw t1, 1(a1)
    bne t0, t1, NO

    lw t0, 2(a0)
    lw t1, 2(a1)
    bne t0, t1, NO

    lw t0, 3(a0)
    lw t1, 3(a1)
    bne t0, t1, NO

    YES:
        addi a0, zero, 1
        beq zero, zero, EQUALEND
    NO:
        add a0, zero, zero

    EQUALEND:
    lw ra, 0(sp)
    addi sp, sp, -4
    ret
