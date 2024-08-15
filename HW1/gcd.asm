.data
msg1:	.asciiz "Enter first number: "
msg2:	.asciiz "\nEnter second number:  "
result:	.asciiz "The GCD is: "

.text
.globl main
#------------------------- main -----------------------------
main:
# print msg1 on the console interface
		li      $v0, 4				# call system call: print string
		la      $a0, msg1			# load address of string into $a0
		syscall                 	# run the syscall
 		
# read the input integer in $v0
 		li      $v0, 5          	# call system call: read integer
  		syscall            
		     	# run the syscall
  		move    $s7, $v0      		# store input in $a0 (set arugument of procedure factorial)
# print msg2 on the console interface
		li      $v0, 4				# call system call: print string
		la      $a0, msg2			# load address of string into $a0
		syscall                 	# run the syscall
 
# load 
 		li      $v0, 5          	# call system call: read integer
  		syscall            
		     	# run the syscall
  		move    $s6, $v0      		# store input in $a0 (set arugument of procedure factorial)

#######################################
#######################################
#######################################

## 		s2	=	result 			go GCD
		move	$a0,	$s7
		move	$a1,	$s6
		jal		GCD
		move $s2, $v0
##print	ans
# print  on the console interface   STRING
		li      $v0, 4				# call system call: print string
		la      $a0, result			# load address of string into $a0
		syscall                 	# run the syscall
 # load 
   		move    $a0, $s2      		# store input in $a0 (set arugument of procedure factorial)
 		li      $v0, 1          	# call system call: read integer
		syscall            
		     	# run the syscall
##PRINT END
		li $v0, 10					# call system call: exit
  		syscall						# run the syscall



###################################
#a0   =   a,      a1  =  b,     s0   =   result
###################################
###################################

.text
GCD:
  addi $sp, $sp, -12         # ���t12�Ӧr�`���̪Ŷ�
  sw   $ra, 8($sp)           # �N��^�a�}�O�s�b�̤�
  sw   $a0, 4($sp)           # �Na�Mb�O�s�b�̤�
  sw   $a1, 0($sp)

  # beq�p��a % b
  div  $a0, $a1
  mfhi $s0					#    s0    =    a%b���l�ƨ��X
  beq $s0, $zero, rtn_b			#�p�Ga%b=0   �N�����h��return  b   
#  bne $s0, $zero, else			#�p�Ga%b=0   �N�����h��return  b   
  move $a0, $a1
  move $a1, $s0
  jal GCD
  lw   $ra, 8($sp)           # ��_��^�a�}
  lw   $a0, 0($sp)           # �Na�Mb��_��$a0�M$a1��
#  lw   $a1, 4($sp)
  addi $sp, $sp, 12          # ����̪Ŷ�
  move $v0, $a1
  jr   $ra                   # ��^
  
#  addi $sp, $sp, 12
#  move $v0, $a1
#  jr $ra    		#����return  b
  #   a%b   ������0�����p
#  move $a0, $a1
#  move $a1, $s0

  
  
rtn_b:#return b.
      addi $sp, $sp, 12
  move $v0, $a1
  jr $ra    		#����return  b
#  move $a0, $a1
#  move $a1, $s0
#  jal GCD
#  lw   $ra, 8($sp)           # ��_��^�a�}
#  lw   $a0, 4($sp)           # �Na�Mb��_��$a0�M$a1��
#  lw   $a1, 0($sp)
#  addi $sp, $sp, 12          # ����̪Ŷ�
#  move $v0, $a1
#  jr   $ra                   # ��^


