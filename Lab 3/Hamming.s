.section .data
msg1: .ascii "Input string 1\n"
len1 = . - msg1
msg2: .ascii "Input string 2\n"
len2 = . - msg2
msg3: .ascii "The hamming distance between string 1 and string 2 is "
len3 = . - msg3

length: .int 256

.section .bss
string1: .space 256
string2: .space 256

.section .text
.global _start
_start:


    mov $1, %rax # write
    mov $1, %rdi # stdout
    mov $msg1,%rsi # buf
    mov $len1,%rdx # len
    syscall

    #input for string1

    mov $1, %rax # write
    mov $1, %rdi # stdout
    mov $msg2,%rsi # buf
    mov $len2,%rdx # len
    syscall

    #input for string2