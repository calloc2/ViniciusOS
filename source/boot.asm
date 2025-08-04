; NASM syntax
org 0x7C00

start:
    xor ax, ax
    mov ds, ax
    mov es, ax

    ; Store boot drive (usually 0x00 or 0x80)
    mov [boot_drive], dl

    ; Set up to read second sector (LBA 1)
    mov ah, 0x02          ; BIOS: Read sectors
    mov al, 0x01          ; Read 1 sector
    mov ch, 0x00          ; Cylinder
    mov dh, 0x00          ; Head
    mov cl, 0x02          ; Sector 2 (starts at 1)
    mov dl, [boot_drive]  ; Drive

    mov bx, 0x0800        ; Load address: 0x0000:0600
    mov es, bx
    xor bx, bx

    int 0x13


    jmp 0x0800:0000       ; Jump to second-stage code

boot_drive: db 0

times 510 - ($ - $$) db 0
dw 0xAA55
