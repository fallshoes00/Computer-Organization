.data
n_prompt: .asciiz "Enter the number n = "
star: .asciiz "*"
space: .asciiz " "

.text
.globl main
main:
    # allocate space on stack for variables
    addi $sp, $sp, -16
    
    # display prompt and read input
    la $a0, n_prompt
    li $v0, 4
    syscall
    
    li $v0, 5
    syscall
    
    # store input on stack
    sw $v0, 0($sp)
    
    # calculate temp variable
    lw $t0, 0($sp)
    addi $t1, $t0, 1
    div $t1, $t1, 2
    mflo $t1
    
    # check if n is odd and adjust temp variable if necessary
    rem $t2, $t0, 2
    bne $t2, $zero, odd
    j even
odd:
    addi $t1, $t1, -1
even:
    sw $t1, 4($sp)
    
    # print upper triangle of asterisks
    li $t0, 0
outerloop1:
    bge $t0, $t1, endloop1
    li $t2, 0
innerloop1:
    bge $t2, $t0, endinnerloop1
    la $a0, space
    li $v0, 4
    syscall
    addi $t2, $t2, 1
    j innerloop1
endinnerloop1:
    la $a0, star
    li $v0, 4
    syscall
    addi $t3, $t0, 1
    sll $t3, $t3, 1
    sub $t4, $t0, $t1
    sll $t4, $t4, 1
    sub $t3, $t3, $t4
    li $t2, 0
    loop1:
    bge $t2, $t3, endloop1
    la $a0, star
    li $v0, 4
    syscall
    addi $t2, $t2, 1
    j loop1
endloop1:
    la $a0, 10
    li $v0, 11
    syscall
    addi $t0, $t0, 1
    j outerloop1
    
    # print lower triangle of asterisks
    lw $t0, 4($sp)
    addi $t0, $t0, -1
outerloop2:
    bgez $t0, endloop2
    li $t2, 0
innerloop2:
    bge $t2, $t0, endinnerloop2
    la $a0, space
    li $v0, 4
    syscall
    addi $t2, $t2, 1
    j innerloop2
endinnerloop2:
    la $a0, star
    li $v0, 4
    syscall
    addi $t3, $t0, 1
    sll $t3, $t3, 1
    subi    li $t4, 0
    
loop2:
    bge $t4, $t3, endloop2
    la $a0, star
    li $v0, 4
    syscall
    addi $t4, $t4, 1
    j loop2
endloop2:
    la $a0, 10
    li $v0, 11
    syscall
    addi $t0, $t0, -1
    j outerloop2


    # exit program
    li $v0, 10
    syscall
