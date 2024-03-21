	.data
buf:	.space	100
	.text

main:
li	a7, 8
li	a1, 100
la	a0, buf
ecall
la	t0, buf		#cur pointer
li	t1, 48
li	t2, 57
li	a0, 0

loop:
lbu	t3, (t0)	#contains current value
beqz	t3,exit
addi	t0, t0,1
bgtu	t3, t2,loop
bltu	t3, t1,loop	#go back to start if current char is not a digit
addi	a0, a0,1
j	loop

exit:
li	a7, 36
ecall
li	a7, 10
ecall