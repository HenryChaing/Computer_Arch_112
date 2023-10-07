.data
arr:      .word 6,9,25
str1:     .string "The normalization for number "
str2:     .string " is 1."
str3:     .string "\n"
str4:     .string " * 2^"
str5:     .string "please ignore 0b\n"

.text
main:
        la a0, str5
        li a7, 4
        ecall
        addi t5,zero,3
        la t6,arr

loop:        
        lw a0,0(t6)
        jal ra, count_leading_zeros       # Jump-and-link to the 'fact' label

        # Print the result to console
        #calculate the mantisa
        lw t3, 0(t6)
        

        mv  a1, a0
        lw  a0, 0(t6)
        jal ra, printResult
        addi t5,t5,-1
        addi t6,t6,4
        bne t5,zero,loop
        # Exit program
        li a7, 10
        ecall

count_leading_zeros:
        
        srai t0, a0, 1
        or  a0, a0, t0
        srai t0, a0, 2
 
        or  a0, a0, t0
        srai t0, a0, 4
        
        or  a0, a0, t0
        srai t0, a0, 8
        or  a0, a0, t0
        
        srai t0, a0, 16
        or  a0, a0, t0
        srai t0, a0, 16
        srai t0, a0, 16
        or  a0, a0, t0

        srai t0, a0, 1
        andi  t0, t0, 0x555
        sub  a0, a0, t0
        srai t0, a0, 2
        andi t0, t0,0x333
        andi t1, a0,0x333
        add a0,t0,t1
        srai t0, a0,4
        add t0,a0,t0
        andi a0,t0,0xf0f
        srai t0,a0,8
        add a0,a0,t0
        srai t0,a0,16
        add a0,a0,t0
        srai t0,a0,16
        srai t0,t0,16
        add a0,a0,t0
        andi t0,a0,0x7f
        addi t1,zero,64
        sub a0,t0,zero

        jr ra
        

# --- printResult ---
# a0: Value which factorial number was computed from
# a1: Factorial result
printResult:
        mv t0, a0
        mv t1, a1
        la a0, str1
        li a7, 4
        ecall
        mv a0, t0
        li a7, 1
        ecall
        la a0, str2
        li a7, 4
        ecall
	addi t2,zero,33
	sub t2,t2,t1
	sll t3,t3,t2
        mv a0, t3
        li a7, 35
        ecall
        la a0, str4
        li a7, 4
        ecall
	
	addi t1,t1,-1
	mv a0, t1
        li a7, 1
        ecall
        la a0, str3
        li a7, 4
        ecall
        ret