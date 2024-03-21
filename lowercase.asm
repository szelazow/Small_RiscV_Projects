	.data
buf:	.space	100
	.text
main:
la	a0, buf
li	a1, 100		#size of buffer
li	a7, 8		#get string
ecall
la	t0, buf		#src pointer
li	t1, 90		#upper bound
li	t2, 65		#lower bound

nxtchr:
lbu	t3, (t0)	#load character
addi	t0, t0, 1	#increment source pointer by 
beqz	t3, end		#end if t3 is the endline character
bgtu	t3, t1, nxtchr
bltu	t3, t2, nxtchr
addi	t3, t3, 32
sb	t3,-1(t0)
b	nxtchr

end:
la	a0, buf
li	a7, 4
ecall
li	a7, 10
ecall
