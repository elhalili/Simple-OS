org 0x7C00 ; start from address 0x7C00
bits 16 ; Switch 

main:
    mov ax, 0
    mov ds, ax
    mov es, ax
    mov ss, ax

    mov sp, 0x7C00
    mov si, msg

    call print

    hlt

halt:
    jmp halt

print:
    push si
    push ax
    push bx

loop_print:
    LODSB
    or al, al
    jz finish


    mov ah, 0x0E
    mov bh, 0

    int 0x10

    jmp loop_print

finish:
    pop bx
    pop ax
    pop si

    ret

msg: db "Hello from Simple OS !!!", 0x0D, 0x0A, 0

TIMES 510 - ($-$$) db 0
dw 0xAA55 ; Boot Signature