.data
.data
n: .word 0x00000005 ,0x00000000 ,0x00000000 ,0x00000000
factorial: .space 16
aux1: .space 16
aux2: .space 16
aux3: .space 16
aux4: .space 17

.text
MAIN:
    la a0, num1
    la a1, answer1
    call ATOQ
    la a0, answer1
    la a1, num1
    call QTOA
    # Print result
    la a1, num1 # Address may have change while executing QTOA
    addi a0, zero, 4
    ecall
    # Newline
    addi a1, zero, 10
    addi a0, zero, 11
    ecall

    la a0, num2
    la a1, answer2
    call ATOQ
    la a0, answer2
    la a1, num2
    call QTOA
    # Print result
    la a1, num2 # Address may have change while executing QTOA
    addi a0, zero, 4
    ecall
    # Newline
    addi a1, zero, 10
    addi a0, zero, 11
    ecall

    # Exiting program
    addi a0, zero, 10
    ecall


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