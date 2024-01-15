  .data         # declare and initialize variables
hello:  .asciiz "Hello world!" # string with null terminator
 
  .text         # code starts here
main:           # label marking the entry point of the program
  addi a0, zero, 4
  la a1, hello
  ecall         # make the system call
 
  addi a7, zero, 10    # code to exit
  ecall         # make the system call