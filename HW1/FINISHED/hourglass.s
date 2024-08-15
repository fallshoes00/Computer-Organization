.data
msg1:	.asciiz "Enter the number n = ? "
star:		.asciiz "*"
space:	.asciiz " "
newline:	.asciiz "\n"

.text
.globl main
#------------------------- main -----------------------------
main:
# print msg1 on the console interface
		li      $v0, 4			# call system call: print string
		la      $a0, msg1			# load address of string into $a0
		syscall                 	# run the syscall
 
# read the input integer in $v0,  ->   t7
 		li      $v0, 5          	# read integer    scanf syscall=5
  		syscall            
		     	# run the syscall
  		move    $s0, $v0      		#   s0    =  n  

#Load temp  placed at t0
    # ?行循?
		addi $s1, $s0, 1   # 算 (n+1)/2,  先把n+1放在t1裡面			n+1
		div $t2, $s1, 2    # t2 = temp = (n+1)/2					/2
		mflo $s2           # t2 = (n+1)/2的商    把(n+1)/2的商存在t1  裡面    (mflo存商， mfhi存餘數)	(n+1)/2的Q

		div $t2, $s0, 2		#%2 ==1????		temp--
		mfhi $t3		 #t4= (n+1)/2的餘    把(n+1)/2的餘存在t4 裡面						(n+1)/2的R
		beq $t3, 1, odd    # 餘數是1即odd，		
	    addi $s3, $0, 0    # t3  =  i   =   0;			
		j even             #預設跳even
#/////////////////////////////////////////////////
#/////////////////////////////////////////////////
#/////////////////////////////////////////////////
#/////////////////////////////////////////////////借換成loop2做測試

odd:
		subi $s2, $s2, 1   # temp--
		j loop1

even:
		j loop1

loop1:#    temp在t1,      i在t3
#    addi $s3, $0, 0    # t3  =  i   =   0;
    addi $t4, $0, 0   # t4   =  j  =0  第一個loop
    bgt  $s2, $s3, loop_1_1#若temp>i,  則跳去loop1_1,   不然就跳過這兩個loop，temp>i等同於i<temp
    j mid
loop_1_1:#    j在t4,   n在t0
    ble  $t4, $s3, print_space   # 若j<=i,則跳去print_space,     s3=i      j=t4
    addi $t4, $0, 0    #下一個loop的t4  = j =0
    j loop_1_2  #不然就直接往下跳loop_1_2

loop_1_2:# j在t4
	addi $t5, $0, 2		#t8=0+2,    等等乘法要用
	mul  $t5, $t5, $s3  #t8 = 2*i
	sub  $t5, $s0, $t5  #t2 = n-2i
	bgt  $t5, $t4, print_star #t8如果大於t4，那就跳去印星星       t8: n-2i,   t4: j
	j print_line

print_space:
	li $t6, 32           # ASCII碼32表示空格
    add $a0, $t6, $zero  # 將ASCII碼32傳遞給$a0參數
    li $v0, 11           # 輸出字元的系統呼叫
    syscall
    addi $t4, $t4, 1  #j++
    j loop_1_1

print_star:
	li $t6, 42           # ASCII碼42表示星號
    add $a0, $t6, $zero  # 將ASCII碼42傳遞給$a0參數
    li $v0, 11           # 輸出字元的系統呼叫
    syscall
 	addi $t4, $t4, 1
 	j loop_1_2

print_line:
	li $t6, 10           # ASCII碼10表示換行符號6
    add $a0, $t6, $zero  # 將ASCII碼10傳遞給$a0參數
    li $v0, 11           # 輸出字元的系統呼叫
    syscall
    addi $s3, $s3, 1    #i++
    j loop1
    
mid:
	div $t2, $s1, 2    # t2 = temp = (n+1)/2					/2  t2不重要
	mflo $s5           # t2 = (n+1)/2的商    把(n+1)/2的商存在s5

    subi $s3, $s5, 1  #i = (n+1)/2    -    1   
	j loop2

loop2:

	
#	div $t2, $s1, 2    # t2 = temp = (n+1)/2					/2  t2不重要
#	mflo $s5           # t2 = (n+1)/2的商    把(n+1)/2的商存在s5

#    subi $s3, $s5, 1  #i = (n+1)/2    -    1   
    addi $t4, $0, 0   # t4   =  j  =0  第一個loop
    ble  $zero, $s3, loop_2_1#若i >=0  ,   即   0  <=  i    ,   則branch過去loop1

    j end
    
loop_2_1:#    j在t4,   n在t0
    ble  $t4, $s3, print_space2   # 若j<=i,則跳去print_space,     s3=i      j=t4
    addi $t4, $0, 0    #下一個loop的t4  = j =0
    j loop_2_2  #不然就直接往下跳loop_1_2

loop_2_2:# j在t4
	addi $t5, $0, 2		#t8=0+2,    等等乘法要用
	mul  $t5, $t5, $s3  #t8 = 2*i
	sub  $t5, $s0, $t5  #t2 = n-2i
	bgt  $t5, $t4, print_star2 #t5如果大於t4，那就跳去印星星       t5: n-2i,   t4: j
	j print_line2

print_space2:
	li $t6, 32           # ASCII碼32表示空格
    add $a0, $t6, $zero  # 將ASCII碼32傳遞給$a0參數
    li $v0, 11           # 輸出字元的系統呼叫
    syscall
    addi $t4, $t4, 1  #j++
    j loop_2_1

print_star2:
	li $t6, 42           # ASCII碼42表示星號
    add $a0, $t6, $zero  # 將ASCII碼42傳遞給$a0參數
    li $v0, 11           # 輸出字元的系統呼叫
    syscall
 	addi $t4, $t4, 1
 	j loop_2_2

print_line2:
	li $t6, 10           # ASCII碼10表示換行符號6
    add $a0, $t6, $zero  # 將ASCII碼10傳遞給$a0參數
    li $v0, 11           # 輸出字元的系統呼叫
    syscall
    subi $s3, $s3, 1    #i++
    subi $s4, $s4, 1
    j loop2


end:
    li $v0, 10      # ?置系?
    syscall


