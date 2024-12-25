[BITS 16]
[ORG 0000h]

jmp osmain

backwidth db 0
backheigth db 0
pagination db 0
welcome db "olaaaa", 0

osmain:
    call configsegment
    call configstack
    call TEXT.setvideomode
    call backcolor
    jmp showstring

showstring:
    mov dh, 3
    mov dl, 2
    call movecursor
    mov si, welcome
    call printstring
    mov ah, 00
    int 16h
    jmp END

configsegment:
    mov ax, es
    mov ds, ax
ret

configstack:
    mov ax, 7D00h
    mov ss, ax
    mov sp, 03FEh
ret

TEXT.setvideomode:
    mov ah, 00h
    mov al, 03h
    int 10h
    mov BYTE [backwidth], 80
    mov BYTE[backheigth], 20
ret

backcolor:
    mov ah, 06h
    mov al, 0
    mov bh, 0001_1111b
    mov ch, 0
    mov cl, 0
    mov dh, 70 ;numero de linhas
    mov dl, 80
    int 10h
ret

printstring:
    mov ah, 09h
    mov bh, [pagination]
    mov bl, 1111_0001b
    mov cx, 1
    mov al, [si]
    print:
        int 10h
        inc si
        call movecursor
        mov ah, 09h
        mov al, [si]
        cmp al, 0
        jne print
ret

movecursor:
    mov ah, 02h
    mov bh, [pagination]
    inc dl
    int 10h
ret

END: