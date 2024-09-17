.model small
.stack 100h
.data
    dividend dw 1234h      
    divisor dw 000Ah       
    quotient dw ?          
    remainder dw ?         
    msg1 db 'Quotient: $'
    msg2 db 0Dh, 0Ah, 'Remainder: $'
.code
main proc
    mov ax, @data
    mov ds, ax              

    mov ax, dividend        
    xor dx, dx              

    mov bx, divisor         

    div bx                  

    mov quotient, ax        
    mov remainder, dx       

    mov ah, 09h
    lea dx, msg1
    int 21h

    mov ax, quotient
    call display_value16    

    mov ah, 09h
    lea dx, msg2
    int 21h

    mov ax, remainder
    call display_value16    

    mov ah, 4ch
    int 21h
main endp

display_value16 proc
    push ax                 
    mov cx, 0               
    
    cmp ax, 0
    je display_zero
    
convert_loop:
    xor dx, dx              
    mov bx, 10              
    div bx                  
    
    push dx                 
    inc cx                  
    
    test ax, ax             
    jnz convert_loop
    
display_digits:
    pop dx                  
    add dl, 30h             
    mov ah, 02h
    int 21h                 
    
    loop display_digits     
    
    jmp done_display        
    
display_zero:
    mov dl, '0'             
    mov ah, 02h
    int 21h
    
done_display:
    pop ax                  
    ret
display_value16 endp
end main
