.data
GroupMembers:	.asciiz	"Nurul Husna Binti Harun\nNurul Aqilah Shahirah Binti Amirudin\nNurul Nabilah Binti Abdul Munir\nTiang King Jeck\n"
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

	li.s $f1, 1.00			#float $f1 = 1.00
	ble $s1, $s2, Time_le_3	#if (hours <= 3); goto Time_le_3

	li.s $f2, 1.50			#float $f2 = 1.50
	bgt $s1, $s2, Time_gt_3 #if (hour > 3); goto Time_gt_3

	j EXIT					#unconditional jump to EXIT

LORRY:
	li $s2, 3				#int $s2 = 3

	beqz $s1, Time_eq_0		#if (hour == 0); goto Time_eq_0

	li.s $f1, 1.50			#float $f1 = 1.50
	ble $s1, $s2, Time_le_3	#if (hours <= 3); goto Time_le_3

	li.s $f2, 2.50			#float $f2 = 2.50
	bgt $s1, $s2, Time_gt_3 #if (hour > 3); goto Time_gt_3

	j EXIT					#unconditional jump to EXIT

BUS:
	li $s2, 3				#int $s2 = 3

	beqz $s1, Time_eq_0		#if (hour == 0); goto Time_eq_0

	li.s $f1, 2.00			#float $f1 = 2.00
	ble $s1, $s2, Time_le_3	#if (hours <= 3); goto Time_le_3

	li.s $f2, 3.50			#float $f2 = 3.50
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
	li $v0, 2				#code for printing float is 3
	mov.s $f12, $f1			#move float to be printed into $f12
	syscall					#cout << $f1
	j EXIT					#unconditional jump to EXIT

Time_gt_3:					#parkingrate = $f1 + ((hour - $s2)*$f2); hour = $s1
	sub $t0, $s1, $s2		#$t0 = $s1 - $s2
	mtc1 $t0, $f4			#move to FP registers (no conversion)
	cvt.s.w $f0, $f4		#convert from integer($f4) to float($f0)
	mul.s $f0, $f0, $f2		#$f0 = $f0 * $f2
	add.s $f3, $f1, $f0		#$f3 = $f1 + $f0
	jal PRINT				#call PRINT
	li $v0, 2				#code for printing float is 3
	mov.s $f12, $f3			#move float to be printed into $f12
	syscall					#cout << $f3
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