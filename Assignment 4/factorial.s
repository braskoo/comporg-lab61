#*****************************************************************************#
#*Program name: Assignment 4: factorial                  *#* Description:    *#
#*This program asks for a number input n from the user and then outputs the  *#
#*factorial n! of the number                                                 *#
#*****************************************************************************#
.text
formatstr: .asciz "%ld"
mystring: .asciz "Fatih Yakici: 2672343\nAnass Benhaddou: 2675334\nAssignment 4: factorial\n"
mysentence: .asciz "Please enter a number:\n"
newline: .asciz "\n"

.global main
#***************************************************************************
#*S u b r o u t i n e:   main                                              *
#*D e s c r i p t i o n   :   application entry point                      *
#***************************************************************************
main:
	movq $0, %rax		# no vector registers in use for printf
	movq $mystring, %rdi	# load adress of a string
	call printf		# call the printf routine
	
	pushq %rbp              # store the caller's base pointer
        movq %rsp, %rbp         # initiliaze the base pointer
	
        movq $mysentence, %rdi  # ask the user for number input
        movq $0, %rax
	call printf

	subq $16, %rsp           # Reserve stack space for variable
        leaq -8(%rbp), %rsi     # Load address of stack var in rsi
        movq $formatstr, %rdi   # Load first argument of scanf
        movq $0, %rax           # no vector registers for scanf
        call scanf              # Call scanf

	call factorial

	movq %rax, %rsi         # load stack variable as second argument
        movq $formatstr, %rdi   # load the formatstr as first argument
        movq $0, %rax
	call printf

	movq $newline, %rdi
	movq $0, %rax
	call printf

	movq %rbp, %rsp         # clear local variables from stack
        popq %rbp               # Restore caller's base pointer

end:
        mov     $0, %rdi        # load program exit code
        call    exit            # exit the program      

#************************************************************
#*Subroutine: factorial                                     *
#*Arguments:                                                *
#*Return value: int                                         *
#*Description: Takes input n from user and calculates n!    *
#************************************************************

factorial:
	movq $1, %rax	# move stack value into RAX
if:
	cmpq $1, -8(%rbp)	# compare stack value: -8(%rbp) <= 1
	jle base_case		# if -8(%rbp)<=1 jump to base_case
	jmp recursivecall	# else jmp to recursivecall
recursivecall:
	imulq -8(%rbp)		# multiplicate stack value with RAX
	decq -8(%rbp)		# decrement stack value with 1
	call if			# calling if again recursively
base_case:
	ret 			# return from subroutine
