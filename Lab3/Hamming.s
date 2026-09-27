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

    # input for string1
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

    mov $0, %al                  # al is the register that will count the differences
    
    mov $0, %ecx
    compare:                     # main looping function
        cmp $FF, %ecx            # checks if has looped 256 times
        je end                   # jump out if it has looped 256 times
        mov string1[%ecx], %ah   # Move the charicter in string1 at the position at ecx into the ah register
        mov string2[%ecx], %dh   # Move the charicter in string2 at the position at ecx into the dh register
        inc %ecx                 # Increments the loop counter
        cmp 0x00, %ah            # Checks if string1 charicter == 0
        je end                   # Jump out if string 1 charicter == 0
        cmp 0x00, %dh            # Checks if string2 charicter == 0
        je end                   # Jump out if string 2 charicter == 0
        xor %dh, %ah             # Logical xor of dh and ah, stores result in ah

        mov 0x00, %bh            # ham loop incrementer

        ham:                     # loop that will count the amount of differences
            mov $0b00000001, %dh     # sets the value of dh to be the logical AND mask
            and %ah, %dh             # checks if the right most bit of ah == 1 and stores the result in dh
            add %dh, %al             # adds the result of the and to the al register
            inc %bh                  # increments the bh counter
            cmp 0x08, %bh            # check if bh is equal to 8
            jb ham                   # jump to ham if bh is less than 8

        jmp compare

    end:


movl $1, %eax # syscall number for sys_exit
xorl %ebx, %ebx # return code 0
int $0x80 # make the syscall