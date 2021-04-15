.data
GroupMembers:	.asciiz	"Nurul Husna Binti Harun\nNurul Aqilah Shahirah Binti Amirudin\nNurul Nabilah Binti Abdul Munir\nTiang King Jeck\n"
EnterVehicle:	.asciiz "\nPlease enter the type of vehicle\nC for car\nL for lorry\nB for bus\nused: "
EnterTime:		.asciiz "\n\nPlease enter the parking time (in hour): "
Error:			.asciiz	"\nInvalid input!"
Result:			.asciiz "\nYour parking cost is RM "

.text
main:	
	#Display group members name
	li $v0, 4
	la $a0, GroupMembers
	syscall
	
	#Initialize the values
	li.s $f1, 3.0
	li.s $f5, 0.0

	#Let user input the type of vehicle and store it
	li $v0, 4
	la $a0, EnterVehicle
	syscall
	li $v0, 12
	syscall
	move $s0, $v0

	#Let user input the parking time and store it
	li $v0, 4
	la $a0, EnterTime
	syscall
	li $v0, 6
	syscall	#$f0=input

	#Compare and Jump of C or c			#Start Selection
	li $t0, 'C'
	li $t1, 'c'
	beq $s0, $t0, CAR
	beq $s0, $t1, CAR

	#Compare and Jump of L or l
	li $t2, 'L'
	li $t3, 'l'
	beq $s0, $t2, LORRY
	beq $s0, $t3, LORRY

	#Compare and Jump of B or b
	li $t4, 'B'
	li $t5, 'b'
	beq $s0, $t4, BUS
	beq $s0, $t5, BUS

	#For invalid input then exit
	li $v0, 4
	la $a0, Error
	syscall
	j EXIT

CAR:	
	c.eq.s $f0, $f5
	bc1t Time_eq_0

	li.s $f2, 1.00
	c.le.s $f0, $f1
	bc1t Time_le_3

	li.s $f3, 1.5
	c.lt.s $f1, $f0
	bc1t Time_gt_3
	j EXIT

LORRY:
	c.eq.s $f0, $f5
	bc1t Time_eq_0

	li.s $f2, 1.50
	c.le.s $f0, $f1
	bc1t Time_le_3

	li.s $f3, 2.5
	c.lt.s $f1, $f0
	bc1t Time_gt_3
	j EXIT

BUS:
	c.eq.s $f0, $f5
	bc1t Time_eq_0

	li.s $f2, 2.00
	c.le.s $f0, $f1
	bc1t Time_le_3

	li.s $f3, 3.5
	c.lt.s $f1, $f0
	bc1t Time_gt_3
	j EXIT

Time_eq_0:
	jal PRINT
	li $v0, 1
	move $a0, $zero
	syscall
	j EXIT
Time_le_3:
	jal PRINT
	li $v0, 2
	mov.s $f12, $f2
	syscall
	j EXIT
Time_gt_3:
	sub.s $f4, $f0, $f1
	mul.s $f4, $f4, $f3
	add.s $f4, $f0, $f2
	jal PRINT
	li $v0, 2
	mov.s $f12, $f4
	syscall
	j EXIT
	#1 + ((hour - 3)*1.5)
EXIT:	
	li $v0, 10
	syscall

PRINT:
	#Print out result and return
	li $v0, 4
	la $a0, Result
	syscall
	jr $ra