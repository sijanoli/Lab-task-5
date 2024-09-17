.model small
.stack 100h
.data
    dividend db 64h
    divisor db 0Ah
    quotient db ?
    remainder db ?
    msg1 db 'Quotient: $'
    msg2 db 0Dh, 0Ah, 'Remainder: $'
.code
main proc
    mov ax, @data
    mov ds, ax
    mov al, dividend
    mov bl, divisor
    xor ah, ah
    div bl
    mov quotient, al
    mov remainder, ah

    mov ah, 09h
    lea dx, msg1
    int 21h

    mov al, quotient
    call display_value

    mov ah, 09h
    lea dx, msg2
    int 21h

    mov al, remainder
    call display_value

    mov ah, 4ch
    int 21h
main endp

display_value proc
    add al, 30h
    mov ah, 02h
    mov dl, al
    int 21h
    ret
display_value endp
end main