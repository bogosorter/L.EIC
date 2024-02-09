# This program operates on 128 bit unsigned integers. These integers are stored
# in four contiguous 32 bit words. The least significative word is stored in the
# lowest address.


.data
n: .word 0x00000013 ,0x00000000 ,0x00000000 ,0x00000000
factorial: .word 0x00000000, 0x00000000, 0x00000000, 0x00000000
aux1: .space 16
aux2: .space 16
aux3: .space 16
str: .space 33


.text
MAIN:
    la a0, n
    la a1, aux1
    la a2, aux2
    la a3, factorial
    la a4, aux3
    call FACTORIAL

    la a0, factorial
    la a1, str
    call QTOA

    # Print result
    la a1, str
    addi a0, zero, 4
    ecall
    # Newline
    addi a1, zero, 10
    addi a0, zero, 11
    ecall
    # Exiting program
    addi a0, zero, 10
    ecall

FACTORIAL:
# Calculates the factorial of a number
# Arguments: a0: address of n
#            a1: address of four free memory positions
#            a2: address of four free memory positions
#            a3: address of result
#            a4: address of four free memory positions
# Registers: s7: address of n
#            s8: address of four free memory positions
#            s9: address of four free memory positions
#            s10: address of result
#            s11: address of four free memory positions

    addi sp, sp, 4
    sw ra, 0(sp)

    # Copy values from argument registers into saved registers
    addi s7, a0, 0
    addi s8, a1, 0
    addi s9, a2, 0
    addi s10, a3, 0
    addi s11, a4, 0

    addi a0, zero, 1
    add a1, s10, zero
    call ITOQ

    # Factorial loop
    FACTLOOP:
        # Copy from result into tmp
        lw t0, 0(s10)
        lw t1, 1(s10)
        lw t2, 2(s10)
        lw t3, 3(s10)
        sw t0, 0(s8)
        sw t1, 1(s8)
        sw t2, 2(s8)
        sw t3, 3(s8)

        add a0, s10, zero
        call CLEAN

        add a0, s7, zero
        add a1, s8, zero
        add a2, s10, zero
        add a3, s9, zero
        add a4, s11, zero
        call MULT

        # Clean tmp variables
        add a0, s9, zero
        call CLEAN
        add a0, s11, zero
        call CLEAN

        lw t0, 0(s0)
        addi t0, t0, -1
        sw t0, 0(s0)
        bne t0, zero, FACTLOOP


    FACTOLOOPEND:
    lw ra, 0(sp)
    addi sp, sp, -4
    ret

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
        sltu t0, t5, t3
        lw t3, 0(a1)
        add t2, t5, t3
        sw t2, 0(a2)
        # Set overflow flag
        sltu t5, t2, t3
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


QTOA:
# Converts a 128 bit number into ASCII (assuming hexadecimal output)
# Arguments: a0: number address
#            a1: string address
# Registers: t0: i
#            t1: current byte
#            t2: tmp
    addi sp, sp, 4
    sw ra, 0(sp)

    addi t0, zero, 15
    LOOP2: # Store each of the digits in a separate byte
        add t2, a0, t0
        lbu t1, 0(t2)
        # Store each of the byte's halves in a separate byte
        srli t2, t1, 4
        sb t2, 0(a1)
        addi a1, a1, 1
        slli t2, t1, 28
        srli t2, t2, 28
        sb t2, 0(a1)
        addi a1, a1, 1
        addi t0, t0, -1
        bge t0, zero, LOOP2
    
    addi t0, zero, 31  
    addi t2, zero, 10
    addi a1, a1, -1
    LOOP3: # Convert each of the digits into it's hexadecimal representation
        lb t1, 0(a1)

        bge t1, t2, CHARACTER
        NUMBER: # Digit is < 10
            addi t1, t1, 48
            beq zero, zero, BRANCHEND
        CHARACTER: # Digit is >= 10
            addi t1, t1, 55
        BRANCHEND:
        sb t1, 0(a1)
        addi a1, a1, -1

        addi t0, t0, -1
        bge t0, zero, LOOP3

    # Null terminate the string
    addi a1, a1, 33
    sb zero, 0(a1)

    lw ra, 0(sp)
    addi sp, sp, -4
    ret

ATOQ:
# Converts ASCII into a 128 bit number (assuming hexadecimal input)
# Arguments: a0: string address
#            a1: number address
# Registers: t0: i
#            t1: current byte
#            t2: tmp
    addi sp, sp, 4
    sw ra, 0(sp)

    addi t0, zero, 31
    addi a0, a0, 31
    addi t2, zero, 65
    LOOP4: # Convert each of the digits into it's hexadecimal representation
        lbu t1, 0(a0)

        bge t1, t2, CHARACTER2
        NUMBER1: # Digit is < 10
            addi t1, t1, -48
            beq zero, zero, BRANCHEND2
        CHARACTER2: # Digit is >= 10
            addi t1, t1, -55
        BRANCHEND2:
        sb t1, 0(a0)
        
        addi a0, a0, -1
        addi t0, t0, -1
        bge t0, zero, LOOP4

    addi a0, a0, 1
    addi a1, a1, 15
    addi t0, zero, 15

    LOOP5:
        lbu t1, 0(a0)
        lbu t2, 1(a0)
        slli t1, t1, 4
        or t1, t1, t2
        sb t1, 0(a1)
        addi a0, a0, 2
        addi a1, a1, -1
        addi t0, t0, -1
        bge t0, zero, LOOP5

    lw ra, 0(sp)
    addi sp, sp, -4
    ret

ITOQ:
# Converts a 32 bit number into an 128 bit number
# Arguments: a0: 32 bit value
#            a1: number address
    addi sp, sp, 4
    sw ra, 0(sp)

    sw a0, 0(a1)
    sw zero, 1(a1)
    sw zero, 2(a1)
    sw zero, 3(a1)

    lw ra, 0(sp)
    addi sp, sp, -4
    ret

CLEAN:
# Multiplies two 128 bit numbers, ignoring overflow
# Arguments: a0: number address
    addi sp, sp, 4
    sw ra, 0(sp)

    sw zero, 0(a0)
    sw zero, 1(a0)
    sw zero, 2(a0)
    sw zero, 3(a0)

    lw ra, 0(sp)
    addi sp, sp, -4
    ret