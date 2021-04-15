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

	#Initialize the values
	li $t1, 'C'				#$t0 = 'C'
	li $t2, 'L'				#$t2 = 'L'
	li $t3, 'B'				#$t4 = 'B'
	li $s0, 3				#$s1 = 3
	
	#Let user input the type of vehicle and store it
	li $v0, 4				#code for printing string is 4
	la $a0, EnterVehicle	#load address of string to be printed into $a0
	syscall					#cout << EnterVehicle
	li $v0, 12				#code for reading character is 12
	syscall					#cin >> vehicles
	move $s1, $v0			#char $s1 = vehicles

	#Let user input the parking time and store it
	li $v0, 4				#code for printing string is 4
	la $a0, EnterTime		#load address of string to be printed into $a0
	syscall					#cout << EnterTime
	li $v0, 5				#code for reading integer is 5
	syscall					#cin >> hour
	move $s2, $v0			#int $s2 = hour

	beqz $s2, Time_eq_0		#if (hour == 0); goto Time_eq_0
	ble $s2, $s0, Time_le_3	#if (hours <= 3); goto Time_le_3
	bgt $s2, $s0, Time_gt_3 #if (hour > 3); goto Time_gt_3

Time_eq_0:
	jal PRINT				#call PRINT
	li $v0, 1				#code for printing integer is 1
	move $a0, $zero			#move integer to be printed into $a0
	syscall					#cout << $zero
	j EXIT					#unconditional jump to EXIT

Time_le_3:
	beq $s1, $t1, CAR		#if (vehicles == 'C'); goto CAR
	beq $s1, $t2, LORRY		#if (vehicles == 'L'); goto LORRY
	beq $s1, $t3, BUS		#if (vehicles == 'B'); goto BUS
	
	jal PRINT				#call PRINT
	li $v0, 1				#code for printing integer is 1
	move $a0, $s3			#move integer to be printed into $a0
	syscall					#cout << $s3
	j EXIT					#unconditional jump to EXIT

Time_gt_3:					
	beq $s1, $t1, CAR		#if (vehicles == 'C'); goto CAR
	beq $s1, $t2, LORRY		#if (vehicles == 'L'); goto LORRY
	beq $s1, $t3, BUS		#if (vehicles == 'B'); goto BUS
	
	#parkingrate = $s3 + ((hour - $s0)*$s4); hour = $s2
	sub $t0, $s2, $s0		#$t0 = $s2 - $s0
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

CAR:
	li $s3, 1				#$s3 = 1
	li $s4, 2				#$s4 = 2

LORRY:
	li $s3, 2				#$s3 = 2

BUS:
	li $s3, 3				#$s3 = 3
	
PRINT:
	#Print out result and return
	li $v0, 4				#code for printing string is 4
	la $a0, Result			#load address of string to be printed into $a0
	syscall					#cout << Result
	jr $ra					#return from call

