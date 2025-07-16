examples
exampleSource

	^
"Language=X86Asm"
'.section .data
    hello:     .asciz "Hello, World!\n"  ; The string to print

.section .text
    .globl _start

_start:
    # write(1, hello, 14)
    movl $1, %eax          ; syscall number for sys_write
    movl $1, %ebx          ; file descriptor 1 (stdout)
    movl $hello, %ecx      ; pointer to the string
    movl $14, %edx         ; length of the string
    int $0x80               ; call kernel

    # exit(0)
    movl $1, %eax          ; syscall number for sys_exit
    xor %ebx, %ebx         ; exit status 0
    int $0x80               ; call kernel'