#*****************************************************************************#
#*Program name: Assignment 1:  your first simple program *#* Description:    *#
#*This program prints the names, study numbers and the name of the assignment*# #*on the terminal                                                            *# #*****************************************************************************#
mystring: .asciz "Fatih Yakici 2672343\n Anass Benhaddou\n Your first simple program"


.global main
#***************************************************************************
#*S u b r o u t i n e:   main                                              *
#*D e s c r i p t i o n   :   application entry point                      *
#***************************************************************************
main:
	pushq	%rbp		# store the caller's base pointer
	movq	%rsp, %rbp	# initialize the base pointer
	
	movq $0, %rax		# no vector registers in use for printf
	movq $mystring, %rdi	# load adress of a string
	
end:
	mov	$0, %rdi	# load program exit code
	call	exit		# exit the program	
	
	

