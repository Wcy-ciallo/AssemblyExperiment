assume cs:code,ds:data
data segment
buf db 79,?,80 dup(?)
data ends
code segment
start:
mov bx,data
mov ds,bx
mov dx,offset buf
mov ah,0ah
int 21h
mov bl,buf[1]
add bx,2
mov buf[bx],'$'
mov buf[0],0ah
mov buf[1],0dh
mov ah,9
int 21h
mov ah,4ch
int 21h
code ends
end start