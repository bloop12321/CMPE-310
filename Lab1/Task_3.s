.section .bss
.global ram
.lcomm ram, 256

.section .text
.global fill_ram

fill_ram:

    lea ram+0x50, %edi
        movb $0x00, (%edi) #0x50
        inc %edi
        movb $0x00, (%edi) #0x51
        inc %edi
        movb $0x00, (%edi) #0x52
        inc %edi
        movb $0x00, (%edi) #0x53
        inc %edi
        movb $0x00, (%edi) #0x54
        inc %edi
        movb $0x00, (%edi) #0x55
        inc %edi
        movb $0x00, (%edi) #0x56
        inc %edi
        movb $0x00, (%edi) #0x57
        inc %edi
        movb $0x00, (%edi) #0x58

    ret

.section .note.GNU-stack,"",@progbits