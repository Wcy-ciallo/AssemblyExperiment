data segment
    ; 10号功能buffer规定
    buf db 20
        db ?
        db 20 dup(?)
    ; 换行输出
    crlf db 0dh, 0ah, '$'
data ends

code segment
    assume cs:code, ds:data
main:
    mov ax, data
    mov ds, ax

    ; 10号功能输入字符串
    lea dx, buf
    mov ah, 0ah
    int 21h

    ; 打印换行符
    lea dx, crlf
    mov ah, 09h
    int 21h

    ; 替换为'$'
    lea bx, buf
    xor ch, ch
    mov cl, [bx+1]

    add bx, 2
    add bx, cx
    mov byte ptr [bx], '$'

    ; 打印输入的字符串
    lea dx, buf+2
    mov ah, 09h
    int 21h

    ; 退出程序
    mov ah, 4ch
    int 21h
code ends
end main

