.model small
.stack 1000h
.data
    y dw ?
    V dw ?
.code
start:

    call citireNr
    push dx
    pop y
    
    xor cx,cx
    mov ax,y
    inc ax
    mov y,ax
    xor ax,ax
    
Incrementare:
    inc cx
    cmp cx,y
        je terminat2
        
Multiplu3:
    mov ax,cx
    mov bl,3
    div bl
    mov bl,ah
    cmp bl,0
        je Multiplu3si5
        
Multiplu5:
    mov ax,cx
    mov bl,5
    div bl
    mov bl,ah
    cmp bl,0
        je Buzz
    call afisareNumar
    call newLine
    jmp Incrementare
    
Multiplu3si5:
    mov ax,cx
    mov bl,5
    div bl
    mov bl,ah
    cmp bl,0
        je FizzBuzz
    jmp Fizz
    
terminat2:
    jmp terminat
    
Buzz:
    mov dl, 'B'
    call afisareFB
    mov dl, 'u'
    call afisareFB
    mov dl, 'z'
    call afisareFB
    mov dl, 'z'
    call afisareFB
    call newLine
    jmp Incrementare
        
Fizz:
    mov dl, 'F'
    call afisareFB
    mov dl, 'i'
    call afisareFB
    mov dl, 'z'
    call afisareFB
    mov dl, 'z'
    call afisareFB
    call newLine
    jmp Incrementare
        
FizzBuzz:
    mov dl, 'F'
    call afisareFB
    mov dl, 'i'
    call afisareFB
    mov dl, 'z'
    call afisareFB
    mov dl, 'z'
    call afisareFB
    mov dl, 'B'
    call afisareFB
    mov dl, 'u'
    call afisareFB
    mov dl, 'z'
    call afisareFB
    mov dl, 'z'
    call afisareFB
    call newLine
    jmp Incrementare

terminat:
    jmp skipProceduri

citireNr proc ;numarul va fi construit in DX
    xor bx, bx
    xor dx, dx
    mov cx, 10
    
    citireCifra:
        mov ah, 01h
        int 21h
        cmp al, 13
            je amTerminat
        sub al, 48
        mov bl, al
        mov ax, dx
        mul cx
        add ax, bx
        mov dx, ax
        jmp citireCifra
    
    amTerminat: 
    ret
endp

afisareNumar proc
        mov bx, 10
        mov V,cx
        mov ax,cx
        xor cx, cx
    
    descompuneNr:
        xor dx, dx
        div bx
        inc cx
        push dx
        cmp ax, 0
            je afiseazaCifre
        jmp descompuneNr
        
    afiseazaCifre:
        pop dx
        add dl, 48
        mov ah, 02h
        int 21h
        cmp cx,0
            je returnValue
        loop afiseazaCifre
    returnValue:
        mov cx,V
    ret
endp
    

afisareFB proc
        mov ah, 02
        int 21h
        ret
endp

newLine proc
        mov dl,10
        mov ah,2
        int 21h
        mov dl,13
        mov ah,2
        int 21h
        ret
endp

skipProceduri:

    mov ah, 4ch
    int 21h

end start