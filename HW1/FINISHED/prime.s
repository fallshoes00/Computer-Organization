.data
msg1: .asciiz "Enter the number n = "
msg2: .asciiz " is a prime\n"
msg3: .asciiz " is not a prime, the nearest prime is "
comma: .asciiz ","
space:  .asciiz " "
.text
.globl main

main:
    # allocate space for n and flag
#addi $sp, $sp, -8

    # 	printf("Enter the number n = ")
    la $a0, msg1
    li $v0, 4
    syscall
    # 	scanf("%d", &n)
    li $v0, 5
    syscall
    move $s7, $v0 # save n to $s7


    #	if( 	prime(n)    )
    move $a0, $s7
    jal prime
    beq $v0, 1, is_prime	#prime ( n )=1		go print

    # if n is not prime, find nearest primes
    addi $a0, $s7, 0
    li $v0, 1
    syscall
    
    la $a0, msg3
    li $v0, 4
    syscall

    addi $s6,$zero, 1 # initialize i to 1
check_primes:
    # check n-i for prime
    sub $a0, $s7, $s6
    jal prime
    beq $v0, 1, found_prime1

    # check n+i for prime
    add $a0, $s7, $s6
    jal prime
    beq $v0, 1, found_prime2

    # increment i and repeat
    addi $s6, $s6, 1
    j check_primes
check_primes2:
   # check n+i for prime
    add $a0, $s7, $s6
    jal prime
    beq $v0, 1, found_prime2

    # increment i and repeat
    addi $s6, $s6, 1
    j check_primes
found_prime1:
    # print n-i
    li $v0, 1		#print integer
    sub $a0, $s7, $s6	#
    syscall
    la $a0, space
    li $v0, 4		#print ,
    syscall
    j check_primes2

found_prime2:
    # print n+i
    li $v0, 1
    add $a0, $s7, $s6
    syscall
#    la $a0, comma
#    li $v0, 4
#    syscall
    j done

is_prime:
    # print n is prime
    li $v0, 1
    move $a0, $s7	#	n	=	s7
    syscall
    la $a0, msg2
    li $v0, 4
    syscall

done:
    # deallocate space for n and flag
    addi $sp, $sp, 8

    # exit program
    li $v0, 10
    syscall
###################################
###################################
###################################
prime:
    addi $sp, $sp, -8       # ?œ¨??†ç?Šä?Šç‚º $ra ??? $s0 ??ç?™ç©º???
    sw   $ra, 0($sp)        # å°? $ra ?„²å­˜åœ¨??†ç?Šä??
    sw   $s0, 4($sp)        # å°? $s0 ?„²å­˜åœ¨??†ç?Šä??
    addi $s0, $zero, 1      # è¨­ç½® $s0 ?‚º 1

    beq  $a0, $s0, prime_end # if(n=1),   return 0   å¦‚æ?? $a0 == 1ï¼Œç›´?¥è·³åˆ°çµæ??  iput?˜¯1ä¸æ˜¯è³ªæ•¸?»?‰¾??è¿‘ç?„è³ª?•¸
    addi $s0, $zero, 2      # ä¸Šé¢??„for loopï¼Œè¨­ç½? $s0 ?‚ºi  = 2

prime_loop0:#		i = s0,	i^2 = t0,	input  n  =  a0
    mul  $t0, $s0, $s0      # è¨ˆç?? $s0 * $s0ï¼Œå?˜å„²?œ¨ $t0 ä¸?
    bgt  $t0, $a0, prime_end # å¦‚æ?? i^2 = $t0  > input = $a0ï¼Œloopå°±ç”­??šä??
#    div  $a0, $a0, $s0      # è¨ˆç?? $a0 / $s0ï¼Œåˆ¤?–·?˜¯?¦?ƒ½è¢«æ•´?™¤
    div  $t2, $a0, $s0      # è¨ˆç?? t2  =  $a0 / $s0ï¼Œå?†å?˜t2ï¼Œåˆ¤?–·?˜¯?¦?ƒ½è¢«æ•´?™¤
    mfhi $t1                # ??–é?˜æ•¸?”¾t1ï¼Œé?—è?‰n%i?˜¯?¦==0
    bnez $t1, prime_next    # å¦‚æ?? $t1 != 0ï¼Œè·³?ˆ°ä¸‹ä?æ¬¡è¿´???
    addi $v0, $zero, 0      # å¦‚æ?? $t1 == 0ï¼Œè?”å?? 0
    j    prime_exit         # è·³åˆ°çµæ??

prime_next:
    addi $s0, $s0, 1        # å¦‚æ?œä?èƒ½?•´?™¤ï¼?$s0++
    j    prime_loop0        # è·³å?? loop0 ??‹å?‹ä?ç½®

prime_end:
    addi $v0, $zero, 1      # line 15		retun  1

prime_exit:
    lw   $ra, 0($sp)        # å¾å?†ç?Šä?Šæ¢å¾? $ra
    lw   $s0, 4($sp)        # å¾å?†ç?Šä?Šæ¢å¾? $s0
    addi $sp, $sp, 8        # ??‹æ”¾??†ç?Šç©º???
    jr   $ra                # è¿”å?èª¿?”¨?–¹
