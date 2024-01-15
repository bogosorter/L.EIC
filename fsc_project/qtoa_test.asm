.data
num1: .word 0x1000000A ,0x2000000B ,0x3000000C ,0x4000000D
num2: .word 0x00000000 ,0x00000000 ,0x89ABCDEF ,0x01234567
answer1: .space 33
answer2: .space 33

.text
MAIN:
    la a0, num1
    la a1, answer1
    call QTOA
    # Print result
    la a1, answer1 # Address may have change while executing QTOA
    addi a0, zero, 4
    ecall
    # Newline
    addi a1, zero, 10
    addi a0, zero, 11
    ecall

    la a0, num2
    la a1, answer2
    call QTOA
    # Print result
    la a1, answer2 # Address may have change while executing QTOA
    addi a0, zero, 4
    ecall
    # Newline
    addi a1, zero, 10
    addi a0, zero, 11
    ecall
    
    # Exiting program
    addi a0, zero, 10
    ecall


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