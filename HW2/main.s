	.file	"main.c"
	.option nopic
	.attribute arch, "rv32i2p1_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	2
	.globl	count_leading_zeros
	.type	count_leading_zeros, @function
count_leading_zeros:
	slli	a4,a1,31
	srli	a5,a0,1
	or	a5,a4,a5
	srli	a4,a1,1
	or	a1,a4,a1
	or	a0,a5,a0
	slli	a4,a1,30
	srli	a5,a0,2
	or	a5,a4,a5
	srli	a2,a1,2
	or	a2,a2,a1
	or	a0,a5,a0
	slli	a4,a2,28
	srli	a5,a0,4
	or	a5,a4,a5
	srli	a3,a2,4
	or	a4,a5,a0
	or	a3,a3,a2
	slli	a2,a3,24
	srli	a5,a4,8
	or	a5,a2,a5
	srli	a2,a3,8
	or	a2,a2,a3
	or	a5,a5,a4
	srli	a3,a5,16
	slli	a4,a2,16
	or	a3,a4,a3
	srli	a4,a2,16
	or	a4,a4,a2
	or	a3,a3,a5
	or	a3,a4,a3
	slli	a2,a4,31
	srli	a5,a3,1
	or	a5,a2,a5
	li	a2,1431654400
	addi	a2,a2,1365
	srli	a1,a4,1
	and	a5,a5,a2
	sub	a5,a3,a5
	and	a2,a1,a2
	sgtu	a3,a5,a3
	sub	a4,a4,a2
	sub	a4,a4,a3
	slli	a2,a4,30
	srli	a3,a5,2
	or	a3,a2,a3
	li	a2,858992640
	addi	a2,a2,819
	and	a3,a3,a2
	srli	a1,a4,2
	and	a5,a5,a2
	and	a1,a1,a2
	add	a5,a3,a5
	and	a4,a4,a2
	add	a4,a1,a4
	sltu	a3,a5,a3
	add	a3,a3,a4
	slli	a2,a3,28
	srli	a4,a5,4
	or	a4,a2,a4
	add	a5,a4,a5
	srli	a2,a3,4
	add	a3,a2,a3
	sltu	a4,a5,a4
	add	a4,a4,a3
	li	a3,252645376
	addi	a3,a3,-241
	and	a4,a4,a3
	and	a5,a5,a3
	slli	a2,a4,24
	srli	a3,a5,8
	or	a3,a2,a3
	add	a5,a3,a5
	srli	a2,a4,8
	add	a4,a2,a4
	sltu	a3,a5,a3
	add	a3,a3,a4
	slli	a2,a3,16
	srli	a4,a5,16
	or	a4,a2,a4
	add	a5,a4,a5
	srli	a2,a3,16
	sltu	a4,a5,a4
	add	a3,a2,a3
	add	a4,a4,a3
	add	a4,a4,a5
	andi	a4,a4,127
	li	a0,64
	sub	a0,a0,a4
	slli	a0,a0,16
	srli	a0,a0,16
	ret
	.size	count_leading_zeros, .-count_leading_zeros
	.globl	__ashldi3
	.align	2
	.globl	decrypt
	.type	decrypt, @function
decrypt:
	addi	sp,sp,-32
	sw	s1,20(sp)
	mv	s1,a1
	sw	s0,24(sp)
	mv	a1,a2
	mv	s0,a0
	mv	a0,s1
	sw	ra,28(sp)
	sw	a2,12(sp)
	call	count_leading_zeros
	lw	a1,12(sp)
	mv	a2,a0
	mv	a0,s1
	call	__ashldi3
	lw	a5,0(s0)
	lw	ra,28(sp)
	lw	s1,20(sp)
	xor	a0,a5,a0
	lw	a5,4(s0)
	sw	a0,0(s0)
	xor	a5,a5,a1
	sw	a5,4(s0)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	decrypt, .-decrypt
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align	2
.LC0:
	.string	"Original Data:"
	.align	2
.LC1:
	.string	"Data: 0x%016lx\n"
	.align	2
.LC2:
	.string	"\nEncrypted Data:"
	.align	2
.LC4:
	.string	"\nDecrypted Data:"
	.section	.text.startup,"ax",@progbits
	.align	2
	.globl	main
	.type	main, @function
main:
	li	a2,269488128
	lui	a0,%hi(.LC0)
	addi	sp,sp,-32
	addi	a2,a2,16
	li	a3,0
	addi	a0,a0,%lo(.LC0)
	sw	ra,28(sp)
	sw	s0,24(sp)
	sw	s2,20(sp)
	sw	s3,16(sp)
	sw	a2,8(sp)
	sw	a3,12(sp)
	call	puts
	lui	s0,%hi(.LC1)
	li	a2,269488128
	li	a3,0
	addi	a2,a2,16
	addi	a0,s0,%lo(.LC1)
	call	printf
	lui	a0,%hi(.LC2)
	addi	a0,a0,%lo(.LC2)
	call	puts
	lui	a5,%hi(.LC3)
	lw	s2,%lo(.LC3)(a5)
	lw	s3,%lo(.LC3+4)(a5)
	addi	a0,sp,8
	mv	a1,s2
	mv	a2,s3
	call	decrypt
	lw	a3,12(sp)
	lw	a2,8(sp)
	addi	a0,s0,%lo(.LC1)
	call	printf
	lui	a0,%hi(.LC4)
	addi	a0,a0,%lo(.LC4)
	call	puts
	mv	a1,s2
	mv	a2,s3
	addi	a0,sp,8
	call	decrypt
	lw	a2,8(sp)
	lw	a3,12(sp)
	addi	a0,s0,%lo(.LC1)
	call	printf
	lw	ra,28(sp)
	lw	s0,24(sp)
	lw	s2,20(sp)
	lw	s3,16(sp)
	li	a0,0
	addi	sp,sp,32
	jr	ra
	.size	main, .-main
	.text
	.align	2
	.globl	encrypt
	.type	encrypt, @function
encrypt:
	tail	decrypt
	.size	encrypt, .-encrypt
	.section	.srodata.cst8,"aM",@progbits,8
	.align	3
.LC3:
	.word	-1985229329
	.word	19088743
	.ident	"GCC: (xPack GNU RISC-V Embedded GCC x86_64) 13.2.0"
