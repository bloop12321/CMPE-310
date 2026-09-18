.section .data
msg1: .ascii "Input string 1\n"
len1 = . - msg1
msg2: .ascii "\nInput string 2\n"
len2 = . - msg2
msg3: .ascii "\nThe hamming distance between string 1 and string 2 is "
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
    mov $0, %rax # read
    mov $0, %rdi # stdin
    mov $string1,%rsi #store in string1
    mov $length,%rdx #length
    syscall

    mov $1, %rax # write
    mov $1, %rdi # stdout
    mov $msg2,%rsi # buf
    mov $len2,%rdx # len
    syscall

    #input for string2
    mov $0, %rax # read
    mov $0, %rdi # stdin
    mov $string2,%rsi #store in string1
    mov $length,%rdx #length
    syscall

movl $1, %eax # syscall number for sys_exit
xorl %ebx, %ebx # return code 0
int $0x80 # make the syscall