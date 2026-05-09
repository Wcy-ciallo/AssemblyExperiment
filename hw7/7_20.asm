; 7.20子程序代码
; 数据段定义
; x db 100101b
show proc
  push ax
  push bx
  push cx
  push dx

  mov bl, x
  mov cx, 2
hex_loop:
  rol bl, 4
  mov dl, bl
  and dl, 0fh
  cmp dl, 9
  jbe is_digit

  add dl, 7

is_digit:
  add dl, 30h

  mov ah, 02h
  int 21h

  loop hex_loop

  pop dx
  pop cx
  pop bx
  pop ax
  ret
show endp