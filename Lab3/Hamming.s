.section .data
msg1: .ascii "Input string 1\n"
len1 = . - msg1
msg2: .ascii "\nInput string 2\n"
len2 = . - msg2
msg3: .ascii "\nThe hamming distance between string 1 and string 2 is "
len3 = . - msg3
char: .ascii "\n"
len4 = . - char

length: .int 256

.section .bss
string1: .space 256
string2: .space 256

digit1: .space 2
digit2: .space 2
digit3: .space 2
digit4: .space 2

.section .text
.global _start
_start:

    mov $1, %rax # write
    mov $1, %rdi # stdout
    mov $msg1,%rsi # buf
    mov $len1,%rdx # len
    syscall

    # input for string1
    mov $0, %rax # read
    mov $0, %rdi # stdin
    mov $string1,%rsi # store in string1
    mov $length,%rdx # length
    syscall

    mov $1, %rax # write
    mov $1, %rdi # stdout
    mov $msg2,%rsi # buf
    mov $len2,%rdx # len
    syscall

    #input for string2
    mov $0, %rax # read
    mov $0, %rdi # stdin
    mov $string2,%rsi # store in string2
    mov $length,%rdx # length
    syscall

    mov $1, %rax # write
    mov $1, %rdi # stdout
    mov $msg3,%rsi # buf
    mov $len3,%rdx # len
    syscall

    mov $0, %bx                  # bx is the register that will count the differences
    
    mov $0, %ecx
    compare:                     # main looping function
        cmp $0xFF, %ecx            # checks if has looped 256 times
        je end                   # jump out if it has looped 255 times
        mov string1(%ecx), %ah   # Move the charicter in string1 at the position at ecx into the ah register
        mov string2(%ecx), %dh   # Move the charicter in string2 at the position at ecx into the dh register
        inc %ecx                 # Increments the loop counter
        cmp $0x0a, %ah            # Checks if string1 charicter == 0
        je end                   # Jump out if string 1 charicter == 0
        cmp $0x0a, %dh            # Checks if string2 charicter == 0
        je end                   # Jump out if string 2 charicter == 0
        xor %dh, %ah             # Logical xor of dh and ah, stores result in ah

        mov $0x00, %al            # ham loop incrementer

        ham:                     # loop that will count the amount of differences
            mov $0b00000001, %dh     # sets the value of dh to be the logical AND mask
            and %ah, %dh             # checks if the right most bit of ah == 1 and stores the result in dh
            jz skip
            inc %bx
            skip:
            inc %al                  # increments the al counter
            shr $1, %ah
            jz compare
            cmp $0x08, %al            # check if al is equal to 8
            jb ham                   # jump to ham if al is less than 8

        jmp compare

    end:

mov %bx, %ax
mov $10, %bx

mov $0, %dx
div %bx
add $'0', %dl
mov %dl, digit1
cmp $0, %ax
je last

mov $0, %dx
div %bx
add $'0', %dl
mov %dl, digit2
cmp $0, %ax
je seclast

mov $0, %dx
div %bx
add $'0', %dl
mov %dl, digit3
cmp $0, %ax
je third

mov $0, %dx
div %bx
add $'0', %dl
mov %dl, digit4

    mov $1, %rax # write
    mov $1, %rdi # stdout
    mov $digit4,%rsi # buf
    mov $2,%rdx # len
    syscall
    third:
    mov $1, %rax # write
    mov $1, %rdi # stdout
    mov $digit3,%rsi # buf
    mov $2,%rdx # len
    syscall
    seclast:
    mov $1, %rax # write
    mov $1, %rdi # stdout
    mov $digit2,%rsi # buf
    mov $2,%rdx # len
    syscall
    last:
    mov $1, %rax # write
    mov $1, %rdi # stdout
    mov $digit1,%rsi # buf
    mov $2,%rdx # len
    syscall

    mov $1, %rax # write
    mov $1, %rdi # stdout
    mov $char,%rsi # buf
    mov $len4,%rdx # len
    syscall

movl $1, %eax # syscall number for sys_exit
xorl %ebx, %ebx # return code 0
int $0x80 # make the syscall