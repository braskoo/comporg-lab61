#*****************************************************************************#
#*Program name: Assignment 2: inout                      *#* Description:    *#
#*This program asks for a number input from the user and then increases the  *#
#*value with 1 and prints it.                                                *#
#*****************************************************************************#
.text
formatstr: .asciz "%ld"
mystring: .asciz "Fatih Yakici 2672343\nAnass Benhaddou 2675334\nAssignment 2: inout\n"
mysentence: .asciz "Please enter a number\n"
space: .asciz "\n"

.global main
#***************************************************************************
#*S u b r o u t i n e:   main                                              *
#*D e s c r i p t i o n   :   application entry point                      *
#***************************************************************************
main:
	movq $0, %rax		# no vector registers in use for printf
	movq $mystring, %rdi	# load adress of a string
	call printf		# call the printf routine

	call inout	
	movq $0, %rax
	movq $space, %rdi
	call printf
end:
        mov     $0, %rdi        # load program exit code
        call    exit            # exit the program      

#************************************************************
#*Subroutine: inout                                         *
#*Arguments:                                                *
#*Return value: int                                         *
#*Description: Takes input from user and increments with 1  *
#************************************************************

inout:
	pushq %rbp		# store the caller's base pointer
	movq %rsp, %rbp		# initiliaze the base pointer
	
	movq $0, %rax
	movq $mysentence, %rdi	# ask the user for number input
	call printf

	subq $8, %rsp		# Reserve stack space for variable
	leaq -8(%rbp), %rsi	# Load address of stack var in rsi
	movq $formatstr, %rdi	# Load first argument of scanf
	movq $0, %rax		# no vector registers for scanf
	call scanf		# Call scanf

	incq -8(%rbp)		# increments the value of the stack variable
	movq -8(%rbp), %rsi	# load stack variable as second argument
	movq $formatstr, %rdi	# load the formatstr as first argument
	movq $0, %rax		
	call printf
 	
	movq %rbp, %rsp		# clear local variables from stack
	popq %rbp		# Restore caller's base pointer
	ret 			# return from subroutine
