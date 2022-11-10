
# cpp.cos.cs.2640.04.f22.tvnguyen7 - process command line args
# QtSPIM:
#   To specify the command line, 
#	select Simulator > Run Parameters > Enter the command line args

	.text
# int main(int argc, char *argv[]) - argv[0] is the program name
# 	a0: argc
# 	a1: argv, address to an array of cstring

main:
	move	$t0, $a0
	move	$t1, $a1
do:	lw	$a0, ($t1)	# loop and output all argv
	li	$v0, 4
	syscall
	li	$a0, '\n'
	li	$v0, 11
	syscall

	addiu	$t1, $t1, 4	# next argv
	sub	$t0, $t0, 1
	bnez	$t0, do

	li	$v0, 10
	syscall
