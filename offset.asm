.data
array	:	.space		100

.text
main	:
la $s0, array
li $t1, 11
li $t2, 12
li $t3, 13

sw $t1, 0($s0)
sw $t2, 4($s0)
sw $t3, 8($s0)

lw $s1, 0($s0)
lw $s2, 4($s0)

addu $s0, $s0, 4
lw $s3, 0($s0)

li $v0, 1
move $a0, $s1
syscall
move $a0, $s2
syscall
move $a0, $s3
syscall
