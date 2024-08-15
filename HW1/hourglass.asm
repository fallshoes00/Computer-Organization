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
    # ?��`?
		addi $s1, $s0, 1   # �� (n+1)/2,  ����n+1��bt1�̭�			n+1
		div $t2, $s1, 2    # t2 = temp = (n+1)/2					/2
		mflo $s2           # t2 = (n+1)/2����    ��(n+1)/2���Ӧs�bt1  �̭�    (mflo�s�ӡA mfhi�s�l��)	(n+1)/2��Q

		div $t2, $s0, 2		#%2 ==1????		temp--
		mfhi $t3		 #t4= (n+1)/2���l    ��(n+1)/2���l�s�bt4 �̭�						(n+1)/2��R
		beq $t3, 1, odd    # �l�ƬO1�Yodd�A		
	    addi $s3, $0, 0    # t3  =  i   =   0;			
		j even             #�w�]��even
#/////////////////////////////////////////////////
#/////////////////////////////////////////////////
#/////////////////////////////////////////////////
#/////////////////////////////////////////////////�ɴ���loop2������

odd:
		subi $s2, $s2, 1   # temp--
		j loop1

even:
		j loop1

loop1:#    temp�bt1,      i�bt3
#    addi $s3, $0, 0    # t3  =  i   =   0;
    addi $t4, $0, 0   # t4   =  j  =0  �Ĥ@��loop
    bgt  $s2, $s3, loop_1_1#�Ytemp>i,  �h���hloop1_1,   ���M�N���L�o���loop�Atemp>i���P��i<temp
    j mid
loop_1_1:#    j�bt4,   n�bt0
    ble  $t4, $s3, print_space   # �Yj<=i,�h���hprint_space,     s3=i      j=t4
    addi $t4, $0, 0    #�U�@��loop��t4  = j =0
    j loop_1_2  #���M�N�������U��loop_1_2

loop_1_2:# j�bt4
	addi $t5, $0, 2		#t8=0+2,    �������k�n��
	mul  $t5, $t5, $s3  #t8 = 2*i
	sub  $t5, $s0, $t5  #t2 = n-2i
	bgt  $t5, $t4, print_star #t8�p�G�j��t4�A���N���h�L�P�P       t8: n-2i,   t4: j
	j print_line

print_space:
	li $t6, 32           # ASCII�X32��ܪŮ�
    add $a0, $t6, $zero  # �NASCII�X32�ǻ���$a0�Ѽ�
    li $v0, 11           # ��X�r�����t�ΩI�s
    syscall
    addi $t4, $t4, 1  #j++
    j loop_1_1

print_star:
	li $t6, 42           # ASCII�X42��ܬP��
    add $a0, $t6, $zero  # �NASCII�X42�ǻ���$a0�Ѽ�
    li $v0, 11           # ��X�r�����t�ΩI�s
    syscall
 	addi $t4, $t4, 1
 	j loop_1_2

print_line:
	li $t6, 10           # ASCII�X10��ܴ���Ÿ�6
    add $a0, $t6, $zero  # �NASCII�X10�ǻ���$a0�Ѽ�
    li $v0, 11           # ��X�r�����t�ΩI�s
    syscall
    addi $s3, $s3, 1    #i++
    j loop1
    
mid:
	div $t2, $s1, 2    # t2 = temp = (n+1)/2					/2  t2�����n
	mflo $s5           # t2 = (n+1)/2����    ��(n+1)/2���Ӧs�bs5

    subi $s3, $s5, 1  #i = (n+1)/2    -    1   
	j loop2

loop2:

	
#	div $t2, $s1, 2    # t2 = temp = (n+1)/2					/2  t2�����n
#	mflo $s5           # t2 = (n+1)/2����    ��(n+1)/2���Ӧs�bs5

#    subi $s3, $s5, 1  #i = (n+1)/2    -    1   
    addi $t4, $0, 0   # t4   =  j  =0  �Ĥ@��loop
    ble  $zero, $s3, loop_2_1#�Yi >=0  ,   �Y   0  <=  i    ,   �hbranch�L�hloop1

    j end
    
loop_2_1:#    j�bt4,   n�bt0
    ble  $t4, $s3, print_space2   # �Yj<=i,�h���hprint_space,     s3=i      j=t4
    addi $t4, $0, 0    #�U�@��loop��t4  = j =0
    j loop_2_2  #���M�N�������U��loop_1_2

loop_2_2:# j�bt4
	addi $t5, $0, 2		#t8=0+2,    �������k�n��
	mul  $t5, $t5, $s3  #t8 = 2*i
	sub  $t5, $s0, $t5  #t2 = n-2i
	bgt  $t5, $t4, print_star2 #t5�p�G�j��t4�A���N���h�L�P�P       t5: n-2i,   t4: j
	j print_line2

print_space2:
	li $t6, 32           # ASCII�X32��ܪŮ�
    add $a0, $t6, $zero  # �NASCII�X32�ǻ���$a0�Ѽ�
    li $v0, 11           # ��X�r�����t�ΩI�s
    syscall
    addi $t4, $t4, 1  #j++
    j loop_2_1

print_star2:
	li $t6, 42           # ASCII�X42��ܬP��
    add $a0, $t6, $zero  # �NASCII�X42�ǻ���$a0�Ѽ�
    li $v0, 11           # ��X�r�����t�ΩI�s
    syscall
 	addi $t4, $t4, 1
 	j loop_2_2

print_line2:
	li $t6, 10           # ASCII�X10��ܴ���Ÿ�6
    add $a0, $t6, $zero  # �NASCII�X10�ǻ���$a0�Ѽ�
    li $v0, 11           # ��X�r�����t�ΩI�s
    syscall
    subi $s3, $s3, 1    #i++
    subi $s4, $s4, 1
    j loop2


end:
    li $v0, 10      # ?�m�t?
    syscall


