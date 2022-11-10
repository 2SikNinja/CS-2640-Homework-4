#  Name:   Nguyen, Peter
#  Homework:  # 4
#  Due:        11/10/2022
#  Course:  cs-2640-04-f22 
# 
#  Description: 
#    Goes through java keywords and finds which number it is


	.data
keywords:
	.word	abstract, assert, boolean, xbreak, byte, case, catch, char
	.word	class, const, continue, default, do, double, else, enum
	.word	extends, false, final, finally, float, for, goto, if
	.word	implements, import, instanceof, int, interface, long, native, new
	.word	null, package, private, protected, public, return, short, static
	.word	strictfp, super, switch, synchronized, this, throw, throws, transient
	.word	true, try, void, volatile, while

intro:    .asciiz   "Java Keywords by P. Nguyen\n\n"
abstract:	.asciiz	"abstract"
assert:	.asciiz	"assert"
boolean:	.asciiz	"boolean"
xbreak:	.asciiz	"break"
byte:	.asciiz	"byte"
case:	.asciiz	"case"
catch:	.asciiz	"catch"
char:	.asciiz	"char"
class:	.asciiz	"class"
const:	.asciiz	"const"
continue:	.asciiz	"continue"
default:	.asciiz	"default"
do:	.asciiz	"do"
double:	.asciiz	"double"
else:	.asciiz	"else"
enum:	.asciiz	"enum"
extends:	.asciiz	"extends"
false:	.asciiz	"false"
final:	.asciiz	"final"
finally:	.asciiz	"finally"
float:	.asciiz	"float"
for:	.asciiz	"for"
goto:	.asciiz	"goto"
if:	.asciiz	"if"
implements:
	.asciiz	"implements"
import:	.asciiz	"import"
instanceof:
	.asciiz	"instanceof"
int:	.asciiz	"int"
interface:
	.asciiz	"interface"
long:	.asciiz	"long"
native:	.asciiz	"native"
new:	.asciiz	"new"
null:	.asciiz	"null"
package:	.asciiz	"package"
private:	.asciiz	"private"
protected:
	.asciiz	"protected"
public:	.asciiz	"public"
return:	.asciiz	"return"
short:	.asciiz	"short"
static:	.asciiz	"static"
strictfp:	.asciiz	"strictfp"
super:	.asciiz	"super"
switch:	.asciiz	"switch"
synchronized:
	.asciiz	"synchronized"
this:	.asciiz	"this"
throw:	.asciiz	"throw"
throws:	.asciiz	"throws"
transient:
	.asciiz	"transient"
true:	.asciiz	"true"
try:	.asciiz	"try"
void:	.asciiz	"void"
volatile:	.asciiz	"volatile"
while:	.asciiz	"while"


	.text
main:
	li	$v0, 4         #prints out the intro
	la	$a0, intro
     syscall
	move	$t0, $a0
	move	$t1, $a1

doagain:	
	lw	$a0, ($t1)	# loop and output all argv
	li	$v0, 4
	syscall
	li	$a0, '\n'
	li	$v0, 11
	syscall

	addiu	$t1, $t1, 4	# next argv
	sub	$t0, $t0, 1
	bnez	$t0, doagain

	li	$v0, 10
	syscall


strcmp:
            # a0 = strkeyword , a1 = strinput
forLoop:
	lb	$t1, ($a0)    # t1 = strkeyword[i] , a char of strkeyword
	lb	$t2, ($a1)    # t2 = strinput[i], a char of strinput
	bne	$t1, $t2, endfor    # while(strkeyword[i]==strinput[i])

	beqz	$t1, endif    # if(strkeyword[i]==\0) go to endif

	add	$a0, 1    # i++
	add	$a1, 1
	b	forLoop    
endfor:
	sub	$v0, $t1, $t2    # return strkeyword[i] - strinput[i]
	jr	$ra
endif:
	li	$v0, 0    #return 0
	jr	$ra 


lsearch:
	li	$t1, 0	#$t1 boolean operator
	li	$t2, 0	#$t2 index
	bnez	$t1,	o

lsearch:
	li	$t0, 0                   # Load 0 into the index
	j	linearLoop                # Loop

linearLoop:
	lw	$t1, 0($a0)              # Load the element into t1
  	beq	$t1, $a1, linearFound   # Found the element
  	addi $a0, $a0, 4            # Add 4 (1 word index) to the array
  	addi $t0, $t0, 1            # Add one to the index
	j 	linearLoop

linearFound:
	add $v0, $t0, $0            # Move $t0 into $v0
	jr $ra                      # Return

lsearch:
            # a0 = keywords[], a1 = length, a2 = inputstring[]
	addiu $sp,$sp,-4    # push(ra) b/c will call a procedure later
	sw	$ra, 0($sp)

	move	$s1, $a0    # s1 = keywords[], b/c calling procedure later so args will change
	move	$s2, $a1    # s2 = length
	move	$s3, $a2    # s3 = inputstring[]	
	li	$s0, 0    # index = 0
	li	$s4, 0    # s4 = false, if found or not
whileLoop2:
	beq	$s4, 1, endWhile2    # while(!found && index<length)
	bge	$s0, $t3,endWhile2    

	sll	$s5, $t0, 2    #offset = index*4
	add	$s5, $s1, $s5    # effect addr = baseadr + offset 
	lw	$s5, ($s5)    # s5 = keywords[i] 

	move	$a0,$s5    # strcmp(keywords[i],length)
	move	$a1,$s3
	jal	strcmp    # v0 = 0 if strings same

	bnez	$v0, else1    # if( strcmp(keywords[i],length) == 0)
	li	$s4, 1    # s0 = true, keyword is found
	b	endif
else1:
	add	$s0, 1    # index++
endif2:    
	b	whileLoop2
endWhile2:

	lw	$ra,0($sp)    # pop(), ra = back to main
	addiu $sp,$sp,4

	jr	$ra
