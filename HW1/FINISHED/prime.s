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
    addi $sp, $sp, -8       # ?��??��?��?�為 $ra ??? $s0 ??��?�空???
    sw   $ra, 0($sp)        # �? $ra ?��存在??��?��??
    sw   $s0, 4($sp)        # �? $s0 ?��存在??��?��??
    addi $s0, $zero, 1      # 設置 $s0 ?�� 1

    beq  $a0, $s0, prime_end # if(n=1),   return 0   如�?? $a0 == 1，直?��跳到結�??  iput?��1不是質數?��?��??近�?�質?��
    addi $s0, $zero, 2      # 上面??�for loop，設�? $s0 ?��i  = 2

prime_loop0:#		i = s0,	i^2 = t0,	input  n  =  a0
    mul  $t0, $s0, $s0      # 計�?? $s0 * $s0，�?�儲?�� $t0 �?
    bgt  $t0, $a0, prime_end # 如�?? i^2 = $t0  > input = $a0，loop就甭??��??
#    div  $a0, $a0, $s0      # 計�?? $a0 / $s0，判?��?��?��?��被整?��
    div  $t2, $a0, $s0      # 計�?? t2  =  $a0 / $s0，�?��?�t2，判?��?��?��?��被整?��
    mfhi $t1                # ??��?�數?��t1，�?��?�n%i?��?��==0
    bnez $t1, prime_next    # 如�?? $t1 != 0，跳?��下�?次迴???
    addi $v0, $zero, 0      # 如�?? $t1 == 0，�?��?? 0
    j    prime_exit         # 跳到結�??

prime_next:
    addi $s0, $s0, 1        # 如�?��?�能?��?���?$s0++
    j    prime_loop0        # 跳�?? loop0 ??��?��?�置

prime_end:
    addi $v0, $zero, 1      # line 15		retun  1

prime_exit:
    lw   $ra, 0($sp)        # 從�?��?��?�恢�? $ra
    lw   $s0, 4($sp)        # 從�?��?��?�恢�? $s0
    addi $sp, $sp, 8        # ??�放??��?�空???
    jr   $ra                # 返�?�調?��?��
