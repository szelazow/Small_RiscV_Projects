	.eqv	PRTSTR, 4
	.eqv	GETSTR, 8
	.eqv	EXIT0, 10
	.eqv	BUFSIZE, 100
	
	.data
	
buf:	.space	BUFSIZE

	.text
	
main:
	la	a0, buf
	li	a1, BUFSIZE
	li	a7, GETSTR
	ecall
	la	t0, buf
	li	t1, '0'
	li	t2, '9'
	
loop:
	lbu	t3, (t0)
	bltu	t3, t1, nxtchr
	bgtu	t3, t2, nxtchr
	sub	t3, t2, t3
	add	t3, t3, t1

nxtchr:
	sb,	t3, (t0)
	beqz	t3, end
	addi	t0, t0, 1
	j	loop

end:
	li	a7, PRTSTR
	ecall
	li	a7, EXIT0
	ecall
	