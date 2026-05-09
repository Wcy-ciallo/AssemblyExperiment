; 7.21子程序代码
; bx = 10010b
show proc
  push ax
  push bx
  push cx
  push dx

  cmp bx, 0
  jne convert

  mov dl, '0'
  mov ah, 02h
  int 21h
  jmp show_done
convert:
  mov ax, bx
  mov bx, 10
  xor cx, cx
div_loop:
  xor dx, dx
  div bx
  push dx
  inc cx
  cmp ax, 0
  jne div_loop

print_loop:
  pop dx
  add dl, 30h
  mov ah, 02h
  int 21h

  loop print_loop
show_done:
  pop dx
  pop cx
  pop bx
  pop ax
  ret
show endp