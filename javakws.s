# 
#  Name:	Nguyen, Peter
#  Homework:	4
#  Due:		11/10/2022 
#  Course:	cs-2640-04-f22 
# 
#  Description: 
#    Takes argument through command line and searches through array to find out which index it is
# 
	
	.data
intro:		.asciiz "Java Keywords by P. Nguyen\n\n"

keywords:
	.word	abstract, assert, boolean, xbreak, byte, case, catch, char
	.word	class, const, continue, default, do, double, else, enum
	.word	extends, false, final, finally, float, for, goto, if
	.word	implements, import, instanceof, int, interface, long, native, new
	.word	null, package, private, protected, public, return, short, static
	.word	strictfp, super, switch, synchronized, this, throw, throws, transient
	.word	true, try, void, volatile, while

abstract:	.asciiz	"abstract"
assert:		.asciiz	"assert"
boolean:	.asciiz	"boolean"
xbreak:		.asciiz	"break"
byte:		.asciiz	"byte"
case:		.asciiz	"case"
catch:		.asciiz	"catch"
char:		.asciiz	"char"
class:		.asciiz	"class"
const:		.asciiz	"const"
continue:	.asciiz	"continue"
default:	.asciiz	"default"
do:		.asciiz	"do"
double:		.asciiz	"double"
else:		.asciiz	"else"
enum:		.asciiz	"enum"
extends:	.asciiz	"extends"
false:		.asciiz	"false"
final:		.asciiz	"final"
finally:	.asciiz	"finally"
float:		.asciiz	"float"
for:		.asciiz	"for"
goto:		.asciiz	"goto"
if:		.asciiz	"if"
implements:	.asciiz	"implements"
import:		.asciiz	"import"
instanceof:	.asciiz	"instanceof"
int:		.asciiz	"int"
interface:	.asciiz	"interface"
long:		.asciiz	"long"
native:		.asciiz	"native"
new:		.asciiz	"new"
null:		.asciiz	"null"
package:	.asciiz	"package"
private:	.asciiz	"private"
protected:	.asciiz	"protected"
public:		.asciiz	"public"
return:		.asciiz	"return"
short:		.asciiz	"short"
static:		.asciiz	"static"
strictfp:	.asciiz	"strictfp"
super:		.asciiz	"super"
switch:		.asciiz	"switch"
synchronized:	.asciiz	"synchronized"
this:		.asciiz	"this"
throw:		.asciiz	"throw"
throws:		.asciiz	"throws"
transient:	.asciiz	"transient"
true:		.asciiz	"true"
try:		.asciiz	"try"
void:		.asciiz	"void"
volatile:	.asciiz	"volatile"
while:		.asciiz	"while"



	.text
main:
	move	$s0, $a0	# s0 = argc
	move	$s1, $a1	# s1 = argv, address to an array of cstring
	sub	$s0, $s0, 1	# removing 1 so it doesn't count path to args
	addiu	$s1, $s1, 4	# adding 4 so it skips path and goes to first argument

	la	$a0, intro
	li	$v0, 4
	syscall
	li	$a0, '\n'
	li	$v0, 11
	syscall



dowhile:
	la	$a0, keywords
	li	$a1, 53
	lw	$a2, ($s1)	# loop and output all argv

	jal	lsearch

	bge	$v0, 53, else2	# if the return value is greater than the length => else2

	move	$t4, $v0	# prints
	la	$t2, keywords
	sll	$t5, $v0, 2
	addu	$t3, $t2, $t5	
	lw	$a0, ($t3)
	li	$v0, 4
	syscall
	li	$a0, ':'
	li	$v0, 11
	syscall
	move	$a0, $t4
	li 	$v0, 1
	syscall
	li	$a0, '\n'
	li	$v0, 11
	syscall
	b endif3
else2:				# doesn't exist in array
	lw	$a0, ($s1)	# prints word
	li	$v0, 4
	syscall
	li	$a0, '\n'
	li	$v0, 11
	syscall
endif3:
	addiu	$s1, $s1, 4	# next argv
	sub	$s0, $s0, 1
	bnez	$s0, dowhile


	
	li	$a0, '\n'
	li	$v0, 11
	syscall
	li	$v0, 10		# exit
	syscall

lsearch:
	addiu	$sp, $sp, -4
	sw	$ra, ($sp)
	move	$s2, $a0		# s2 = keyword array address
	move	$s3, $a1		# s3 = length

	li	$s4, 0			# index

while1:	bge	$s4, $s3, endwhile1	# index >= 52


	lw	$a0, ($s2)		# address of string
	move	$a1, $a2		# address to value
	jal	strcmp

	bnez	$v0, else1	
	b	endwhile1
else1:
	addi	$s4, $s4, 1
	addi	$s2, $s2, 4

	b	while1

endwhile1:

	lw	$ra, ($sp)
	addiu	$sp, $sp, 4
	move	$v0, $s4
	jr	$ra

strcmp:
	li	$t0, 0			# int i = 0

while2:
	addu	$t1, $a0, $t0
	addu	$t2, $a1, $t0

	lb	$t3, ($t1)		# loads characters into t3 and t4
	lb	$t4, ($t2)
	bne	$t3, $t4, endwhile2	# t3 != t4 => endwhile2
	bne	$t3, $zero, endif2	# t3 != '\0' => endif2
	li	$v0, 0
	b	endwhile2
endif2:
	addi	$t0, $t0, 1		# i++
	b while2

endwhile2:
	sub	$v0, $t3, $t4		# return s[i] - t[i]
	jr	$ra