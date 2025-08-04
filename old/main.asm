; bootloader.asm — minimal 512-byte boot sector
BITS 16
ORG 0x7C00               ; BIOS loads boot sector to 0x7C00

; caracteres

start:
    mov al, 0
    mov bx, 0

    call print_string

    ;jmp loop

    jmp $
    
loop:
    call main
    jmp loop

print_string:
    mov al, [strings+bx]
    cmp al, 0
    je return

    mov ah, 0x0e
    int 0x10
    inc bx
    call print_string

return:
    ret

main:
    mov ah, 1 ; preparar input de teclado nao bloqueador
    int 0x16 ; interrupt de teclado
    cmp al, 0 ; comparando o que recebeu de input com 0, se for 0, ret
    jne $+2 ; Mesma coisa que return

    mov ah, 0 ;preparar input de teclado e receber ascii
    int 0x16 ; interrupt de teclado
    ;al vai receber o valor ASCII.

    mov ah, 0x0e ; preparar print
    int 0x10 ;interrupt pro print
    ;al tem o valor do ASCII então ele printa no interrupt.
    
    ret ;volta pra função principal


strings:
    db "Eu quero muito dar o cu KKKKKKKKKKK lol xdxdxd KKK", 0

stored_char:
    db 0

data:
    ; Fill up to 510 bytes
    times 510 - ($ - $$) db 0
    dw 0xAA55