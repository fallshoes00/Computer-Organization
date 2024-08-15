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
    sub $a0, $s7, $s6	#	��n-i���a0	�ǳ�print
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
    addi $sp, $sp, -8       # �b���|�W�� $ra �M $s0 �w�d�Ŷ�
    sw   $ra, 0($sp)        # �N $ra �x�s�b���|�W
    sw   $s0, 4($sp)        # �N $s0 �x�s�b���|�W
    addi $s0, $zero, 1      # �]�m $s0 �� 1

    beq  $a0, $s0, prime_end # if(n=1),   return 0   �p�G $a0 == 1�A�������쵲��  iput�O1���O��ƥh��̪񪺽��
    addi $s0, $zero, 2      # �W����for loop�A�]�m $s0 ��i  = 2

prime_loop0:#		i = s0,	i^2 = t0,	input  n  =  a0
    mul  $t0, $s0, $s0      # �p�� $s0 * $s0�A�s�x�b $t0 ��
    bgt  $t0, $a0, prime_end # �p�G i^2 = $t0  > input = $a0�Aloop�N�ǰ��F
#    div  $a0, $a0, $s0      # �p�� $a0 / $s0�A�P�_�O�_��Q�㰣
    div  $t2, $a0, $s0      # �p�� t2  =  $a0 / $s0�A�Ӧst2�A�P�_�O�_��Q�㰣
    mfhi $t1                # ���l�Ʃ�t1�A����n%i�O�_==0
    bnez $t1, prime_next    # �p�G $t1 != 0�A����U�@���j��
    addi $v0, $zero, 0      # �p�G $t1 == 0�A��^ 0
    j    prime_exit         # ���쵲��

prime_next:
    addi $s0, $s0, 1        # �p�G����㰣�A$s0++
    j    prime_loop0        # ���^ loop0 �}�l��m

prime_end:
    addi $v0, $zero, 1      # line 15		retun  1

prime_exit:
    lw   $ra, 0($sp)        # �q���|�W��_ $ra
    lw   $s0, 4($sp)        # �q���|�W��_ $s0
    addi $sp, $sp, 8        # ������|�Ŷ�
    jr   $ra                # ��^�եΤ�