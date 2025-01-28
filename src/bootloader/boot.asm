org 0x7C00 ; start from address 0x7C00
bits 16 ; Switch 


; ------ FAT12 Signature ----------------------------------------------------------------------------------+
jmp main ;First two bytes - jump to start                                                                   |
nop ;Null byte - Needed to make 3 bytes at the beginning total                                              |
;                                                                                                           |
oem_name:                   db      "elhalili"              ;OEM Name                                       |
bytes_per_sector:           dw      512                     ;Bytes Per Sector                               |
sector_per_cluster:         db      1                       ;Sectors Per Cluster                            |
reserved_sector:            dw      1                       ;Reserved Sector Count - 1 For BootSector       |
fat_count:                  db      2                       ;Number of File Allocation Tables               |
dir_entry_count:            dw      160                     ;Max number of Root Entries (16 * 10)           |
total_sector:               dw      80 * 2 * 18             ;Total Sectors                                  |
media_descriptor_type:      db      0xF0                    ;Media Descriptor                               |
sectors_per_fat:            dw      10                      ;Sectors Per FAT                                |
sectors_per_track:          dw      18                      ;Sectors Per Track                              |
number_of_heads:            dw      2                       ;Number of Heads                                |
number_of_hidden_sectors:   dd      0                       ;Number of Hidden Sectors                       |
large_sector_count:         dd      0                       ; need to docs this                             |
;                                                                                                           |
;extended boot record                                                                                       |
ebr_drive_number:           db      0                       ; need to docs this                             |
                            db      0                       ;                                               |
ebr_signature:              db      0x29                    ; need to docs this                             |
ebr_volume_id:              db      0x12, 0x34, 0x56, 0x78  ;                                               |
ebr_volume_label:           db      'SIMPLE OS  '           ;                                               |
; ---------------------------------------------------------------------------------------------------------+


main:
    mov ax, 0
    mov ds, ax
    mov es, ax
    mov ss, ax

    mov sp, 0x7C00
    mov si, msg

    call print

    hlt

;halt:
;
;    jmp halt

halt_print:
    mov al, '.'

    mov ah, 0x0E ; print a character to the screen
    mov bh, 0 ; provide the page number
    int 0x10; video interrupt

    mov cx, 1
    xor ax, ax
    mov ah, 0x86
    int 0x15; wait interrupt

    jmp halt_print


print:
    push si
    push ax
    push bx

loop_print:
    LODSB
    or al, al
    jz finish

    mov ah, 0x0E ; print a character to the screen
    mov bh, 0 ; provide the page number

    int 0x10; video interrupt

    jmp loop_print

finish:
    pop bx
    pop ax
    pop si

    ret

msg: db "The Simple OS is booting...", 0x0D, 0x0A, 0

TIMES 510 - ($-$$) db 0
dw 0xAA55 ; Boot Signature
