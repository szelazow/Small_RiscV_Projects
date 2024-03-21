		.eqv	SYS_READSTR, 8
		.eqv	SYS_EXIT0, 10
		.eqv	SYS_PRTINTU, 36
		.eqv	BUFSIZE, 100
		
		.data
		
	buf:	.space	BUFSIZE
	
		.text
		
	main:	
		la	a0, buf
		li	a1, BUFSIZE
		li	a7, SYS_READSTR
		ecall
	
		la	t0, buf
		li	t1, '0'
		li	t2, '9'
		mv	a0, zero		#current biggest will be stored in a0 
		mv	t4, zero		#current number
		li	t5, 10

	loop:
		lbu	t3, (t0)
		beqz	t3, exit
		addi	t0, t0, 1
		bltu	t3, t1, loop
		bgtu	t3, t2, loop		#keep looping if no digits
		sub	t3, t3, t1
		add 	t4, t4, t3
		
	make_num:
		lbu	t3, (t0)
		addi	t0, t0, 1
		beqz	t3, num_cmp
		bltu	t3, t1, num_cmp
		bgtu	t3, t2, num_cmp		#compare to current largest if finished
		mul	t4, t4, t5
		sub	t3, t3, t1
		add 	t4, t4, t3
		j	make_num
	
	num_cmp:
		mv	t6, t4
		mv	t4, zero
		bgeu	a0, t6, loop	
		mv	a0, t6
		j loop
	
	exit:
		li	a7, SYS_PRTINTU
		ecall
		li	a7, SYS_EXIT0
		ecall
	