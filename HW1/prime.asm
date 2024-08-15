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
    sub $a0, $s7, $s6	#	把n-i放到a0	準備print
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
    addi $sp, $sp, -8       # 在堆疊上為 $ra 和 $s0 預留空間
    sw   $ra, 0($sp)        # 將 $ra 儲存在堆疊上
    sw   $s0, 4($sp)        # 將 $s0 儲存在堆疊上
    addi $s0, $zero, 1      # 設置 $s0 為 1

    beq  $a0, $s0, prime_end # if(n=1),   return 0   如果 $a0 == 1，直接跳到結束  iput是1不是質數去找最近的質數
    addi $s0, $zero, 2      # 上面的for loop，設置 $s0 為i  = 2

prime_loop0:#		i = s0,	i^2 = t0,	input  n  =  a0
    mul  $t0, $s0, $s0      # 計算 $s0 * $s0，存儲在 $t0 中
    bgt  $t0, $a0, prime_end # 如果 i^2 = $t0  > input = $a0，loop就甭做了
#    div  $a0, $a0, $s0      # 計算 $a0 / $s0，判斷是否能被整除
    div  $t2, $a0, $s0      # 計算 t2  =  $a0 / $s0，商存t2，判斷是否能被整除
    mfhi $t1                # 取餘數放t1，驗證n%i是否==0
    bnez $t1, prime_next    # 如果 $t1 != 0，跳到下一次迴圈
    addi $v0, $zero, 0      # 如果 $t1 == 0，返回 0
    j    prime_exit         # 跳到結束

prime_next:
    addi $s0, $s0, 1        # 如果不能整除，$s0++
    j    prime_loop0        # 跳回 loop0 開始位置

prime_end:
    addi $v0, $zero, 1      # line 15		retun  1

prime_exit:
    lw   $ra, 0($sp)        # 從堆疊上恢復 $ra
    lw   $s0, 4($sp)        # 從堆疊上恢復 $s0
    addi $sp, $sp, 8        # 釋放堆疊空間
    jr   $ra                # 返回調用方