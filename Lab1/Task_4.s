.section .bss
.global ram
.lcomm ram, 256

.section .text
.global fill_ram

fill_ram:


    mov $0x0A, %edi
    mov $0x01, %ecx
    mov $0x00, %eax
    movb $0x00, ram+0x50

    additions_loop:
    add %ecx, %eax
    inc %ecx

    cmp %edi, %ecx
    jle additions_loop

    mov %eax, ram+0x50


    ret

.section .note.GNU-stack,"",@progbits