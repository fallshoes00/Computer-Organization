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
  addi $sp, $sp, -12         # 分配12個字節的棧空間
  sw   $ra, 8($sp)           # 將返回地址保存在棧中
  sw   $a0, 4($sp)           # 將a和b保存在棧中
  sw   $a1, 0($sp)

  # beq計算a % b
  div  $a0, $a1
  mfhi $s0					#    s0    =    a%b的餘數取出
  beq $s0, $zero, rtn_b			#如果a%b=0   就直接去做return  b   
#  bne $s0, $zero, else			#如果a%b=0   就直接去做return  b   
  move $a0, $a1
  move $a1, $s0
  jal GCD
  lw   $ra, 8($sp)           # 恢復返回地址
  lw   $a0, 0($sp)           # 將a和b恢復到$a0和$a1中
#  lw   $a1, 4($sp)
  addi $sp, $sp, 12          # 釋放棧空間
  move $v0, $a1
  jr   $ra                   # 返回
  
#  addi $sp, $sp, 12
#  move $v0, $a1
#  jr $ra    		#直接return  b
  #   a%b   不等於0的情況
#  move $a0, $a1
#  move $a1, $s0

  
  
rtn_b:#return b.
      addi $sp, $sp, 12
  move $v0, $a1
  jr $ra    		#直接return  b
#  move $a0, $a1
#  move $a1, $s0
#  jal GCD
#  lw   $ra, 8($sp)           # 恢復返回地址
#  lw   $a0, 4($sp)           # 將a和b恢復到$a0和$a1中
#  lw   $a1, 0($sp)
#  addi $sp, $sp, 12          # 釋放棧空間
#  move $v0, $a1
#  jr   $ra                   # 返回


