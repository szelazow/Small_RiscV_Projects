	.eqv	SYS_GETSTR, 8
	.eqv	SYS_PRTINTU, 36
	.eqv	SYS_EXIT0, 10
	.eqv	BUFSIZE, 100
	.data
buf:	.space	BUFSIZE
	.text
main:
	la	a0,buf
	li	a1,BUFSIZE
	li	a7,SYS_GETSTR
	ecall
	la	t0,buf
	li	t1,'0'
	li	t2,'9'
	li	a0, 0
	
loop:
	lbu	t3,(t0)
	beqz	t3,exit
	addi	t0,t0,1
	bgtu	t3,t2,loop
	bltu	t3,t1,loop		#not a digit -> go back

numfnd:
	lbu	t3, (t0)
	beqz	t3, endnum
	addi	t0, t0, 1
	bgtu	t3, t2, endnum
	bltu	t3, t1, endnum		#not a digit -> end loop
	j	loop

endnum:
	addi	a0, a0, 1
	beqz	t3, exit
	j	loop
	

exit:
	li	a7, SYS_PRTINTU
	ecall
	li	a7, SYS_EXIT0
	ecall
