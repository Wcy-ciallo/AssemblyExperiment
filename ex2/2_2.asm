data segment
    msg db 0dh, 0ah, 'Y=2X+3=$'
data ends

code segment
    assume cs:code, ds:data
main:
    mov ax, data
    mov ds, ax

    ; 输入x
    mov ah, 01h
    int 21h

    sub al, 30h

    mov bl, 2
    mul bl

    aam

    add al, 3
    aaa

    mov bx, ax

    ; 显示换行和提示信息
    lea dx, msg
    mov ah, 09h
    int 21h

    ; 显示十位的数
    mov dl, bh
    add dl, 30h
    mov ah, 02h
    int 21h

    ; 显示个位的数
    mov dl, bl
    add dl, 30h
    mov ah, 02h
    int 21h

    mov ah, 4ch
    int 21h
code ends
end main