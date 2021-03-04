#*****************************************************************************#
#*Program name: Assignment 3: parameter passing and local variables          *# 
#*Description:                                                               *#
#*This program asks the user for a positive base and exponent and calculates *#
#*the resulting power and prints the return value                            *#
#*****************************************************************************#
.text
formatstr1: .asciz "%ld%ld"
formatstr2: .asciz "%ld"
mystring: .asciz "Fatih Yakici 2672343\nAnass Benhaddou 2675334\nAssignment 3\n\n"
mysentence: .asciz "Please enter a positive base and exponent\n"
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

	pushq %rbp
	movq %rsp, %rbp

	movq $mysentence, %rdi	# ask user for positive base and exponent
	movq $0, %rax
	call printf

	subq $16, %rsp		# reserve stack space for variable
	leaq -16(%rbp), %rdx	# load address of 2nd stack var in rdx
	leaq -8(%rbp), %rsi	# load address of 1st stack var in rsi
	movq $formatstr1, %rdi	# load first argument of scanf
	movq $0, %rax
	call scanf

	call pow
	
	movq $newline, %rdi	# newline print after last print in terminal
	movq $0, %rax
	call printf

	movq %rbp, %rsp         # clear local variables from stack
        popq %rbp               # Restore caller's base pointer

end:
        mov     $0, %rdi        # load program exit code
        call    exit            # exit the program      

#************************************************************
#*Subroutine: pow                                           *
#*Arguments: int base, int exp                              *
#*Return value: int                                         *
#*Description: Takes arguments from user and calculates the *
#*resulting power                                           *
#************************************************************

pow:	
	movq $1, %rax		# initialize total value with 1

multiplier:
	cmpq $0, -16(%rbp)	# if 2nd stack var(exp) <= 1 jump to
	jle endpow

	imulq -8(%rbp), %rax	# multiply 1st stack var(base) with RAX and store in RAX
	decq -16(%rbp)		# decrement 2nd stack var(exp) with 1

	jmp multiplier		# repeat the loop

endpow:
	movq %rax, %rsi
	movq $formatstr2, %rdi
	movq $0, %rax
	call printf

	ret 			# return from subroutine
