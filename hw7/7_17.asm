; 7.17代码
data segment
  x dw 0
data ends
code segment
assume cs:code, ds:data
start:
  mov ax, data
  mov ds, ax
let0:
  mov ah, 01h
  int 21h
  cmp al, 0dh
  jz let1
  call in_num
  jmp let0
let1:
  mov ah, 4ch
  int 21h
in_num proc
  push bx
  push cx
  sub al, 30h
  mov cl, al
  mov ch, 0
  mov bx, 10
  mov ax, x
  mul bx
  add ax, cx
  mov x, ax
  pop cx
  pop bx
  ret
in_num endp
code ends
end start