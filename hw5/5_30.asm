; 5.30题目
data segment
  buf db 11 dup(?)
data ends
code segment
  assume cs:code, ds:data
start:
  mov ax, data
  mov ds, ax
  mov bx, 0      ; 当做数组下标

let1:
  mov ah, 01h    ; 调01h中断读入单个字符带回显
  int 21h

  mov buf[bx], al; 把读到的存进数组
  inc bx
  cmp bx, 10     ; 看看是不是读满10个了
  jz out1
  cmp al, 20h    ; ' '在ascii就是20h，遇到空格也不输了
  jnz let1
out1:
  mov al, '$'    ; 让它变成标准的字符串结束
  mov buf[bx], al

  mov dx, offset buf
  mov ah, 09h    ; 输出我们读进来的字符串
  int 21h

  mov ah, 4ch
  int 21h
code ends
end start