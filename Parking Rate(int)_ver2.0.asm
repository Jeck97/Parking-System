.data
GroupMembers:	.asciiz	"Group 2:\nNurul Husna Binti Harun\nNurul Aqilah Shahirah Binti Amirudin\nNurul Nabilah Binti Abdul Munir\nTiang King Jeck\n"
EnterVehicle:	.asciiz "\nPlease enter the type of vehicle\nC for car\nL for lorry\nB for bus\nused: "
EnterTime:		.asciiz "\n\nPlease enter the parking time (in hour): "
Error:			.asciiz	"\nInvalid input!"
Result:			.asciiz "\nYour parking cost is RM "

.text
main:	
	#Display group members name
	li $v0, 4				#code for printing string is 4
	la $a0, GroupMembers	#load address of string to be printed into $a0
	syscall					#cout << GroupMembers
	
	#Let user input the type of vehicle and store it
	li $v0, 4				#code for printing string is 4
	la $a0, EnterVehicle	#load address of string to be printed into $a0
	syscall					#cout << EnterVehicle
	li $v0, 12				#code for reading character is 12
	syscall					#cin >> vehicles
	move $s0, $v0			#char $s0 = vehicles

	#Let user input the parking time and store it
	li $v0, 4				#code for printing string is 4
	la $a0, EnterTime		#load address of string to be printed into $a0
	syscall					#cout << EnterTime
	li $v0, 5				#code for reading integer is 5
	syscall					#cin >> hour
	move $s1, $v0			#int $s1 = hour

	#Compare and Jump of C or c
	li $t0, 'C'				#$t0 = 'C'
	li $t1, 'c'				#$t1 = 'c'
	beq $s0, $t0, CAR		#if (vehicles == 'C'); goto CAR
	beq $s0, $t1, CAR		#if (vehicles == 'c'); goto CAR

	#Compare and Jump of L or l
	li $t2, 'L'				#$t2 = 'L'
	li $t3, 'l'				#$t3 = 'l'
	beq $s0, $t2, LORRY		#if (vehicles == 'L'); goto LORRY
	beq $s0, $t3, LORRY		#if (vehicles == 'l'); goto LORRY

	#Compare and Jump of B or b
	li $t4, 'B'				#$t4 = 'B'
	li $t5, 'b'				#$t5 = 'b'
	beq $s0, $t4, BUS		#if (vehicles == 'B'); goto BUS
	beq $s0, $t5, BUS		#if (vehicles == 'b'); goto BUS

	#For invalid input then exit
	li $v0, 4				#code for printing string is 4
	la $a0, Error			#load address of string to be printed into $a0
	syscall					#cout << Error
	j EXIT					#unconditional jump to EXIT

CAR:
	li $s2, 3				#int $s2 = 3

	beqz $s1, Time_eq_0		#if (hour == 0); goto Time_eq_0

	li $s3, 1				#int $s3 = 1
	ble $s1, $s2, Time_le_3	#if (hours <= 3); goto Time_le_3

	li $s4, 2				#int $s4 = 2
	bgt $s1, $s2, Time_gt_3 #if (hour > 3); goto Time_gt_3

	j EXIT					#unconditional jump to EXIT

LORRY:
	li $s2, 3				#int $s2 = 3

	beqz $s1, Time_eq_0		#if (hour == 0); goto Time_eq_0

	li $s3, 2				#int $s3 = 2
	ble $s1, $s2, Time_le_3	#if (hours <= 3); goto Time_le_3

	li $s4, 3				#int $s4 = 3
	bgt $s1, $s2, Time_gt_3 #if (hour > 3); goto Time_gt_3

	j EXIT					#unconditional jump to EXIT

BUS:
	li $s2, 3				#int $s2 = 3

	beqz $s1, Time_eq_0		#if (hour == 0); goto Time_eq_0

	li $s3, 3				#int $s3 = 3
	ble $s1, $s2, Time_le_3	#if (hours <= 3); goto Time_le_3

	li $s4, 4				#int $s4 = 4
	bgt $s1, $s2, Time_gt_3 #if (hour > 3); goto Time_gt_3

	j EXIT					#unconditional jump to EXIT

Time_eq_0:
	jal PRINT				#call PRINT
	li $v0, 1				#code for printing integer is 1
	move $a0, $zero			#move integer to be printed into $a0
	syscall					#cout << $zero
	j EXIT					#unconditional jump to EXIT

Time_le_3:
	jal PRINT				#call PRINT
	li $v0, 1				#code for printing integer is 1
	move $a0, $s3			#move integer to be printed into $a0
	syscall					#cout << $s3
	j EXIT					#unconditional jump to EXIT

Time_gt_3:					#parkingrate = $s3 + ((hour - $s2)*$s4); hour = $s1
	sub $t0, $s1, $s2		#$t0 = $s1 - $s2
	mult $t0, $s4			#$t0 * $s4
	mflo $t0				#$t0 = $t0 * $s4
	add $t0, $s3, $t0		#$t0 = $s3 + $t0
	jal PRINT				#call PRINT
	li $v0, 1				#code for printing integer is 1
	move $a0, $t0			#move integer to be printed into $a0
	syscall					#cout << $t0
	j EXIT					#unconditional jump to EXIT
	
EXIT:	
	li $v0, 10				#code for exit is 10
	syscall					#call operating system to exit

PRINT:
	#Print out result and return
	li $v0, 4				#code for printing string is 4
	la $a0, Result			#load address of string to be printed into $a0
	syscall					#cout << Result
	jr $ra					#return from call