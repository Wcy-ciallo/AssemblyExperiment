; 7.30实现代码
data segment
  A db 10, -20, 30, -40, 50
  B db -10, -11, -12, -13, 14, 15
  SUM1 db ?
  SUM2 db ?
data ends
code segment
assume cs:code, ds:data
strat:
  mov ax, data
  mov ds, ax

  mov si, offset A
  mov cx, 5
  call sum
  mov SUM1, bl
  
  mov si, offset B
  mov cx, 6
  call sum
  mov SUM2, bl

  mov ah, 4ch
  int 21h
sum proc
  ; si是数组首地址，cx是数组元素个数
  ; bl存储运算结果
  push ax
  push cx
  push si

  xor bx, bx
sum_loop:
  mov al, [si]
  cmp al, 0
  jge not_nag
  add bl, al
not_nag:
  inc si
  loop sum_loop

  pop si
  pop cx
  pop ax
  ret
sum endp
code ends
end start
