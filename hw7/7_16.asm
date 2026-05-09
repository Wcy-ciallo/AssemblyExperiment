; 7.16代码
; data segment定义如下
; buffer db 10 dup(?)
input_buffer proc
  push ax
  push bx
  push cx
  push si

  mov si, offset buffer
  mov cx, 0

input_loop:
  mov ah, 01h
  int 21h

  cmp al, 0dh
  je input_done

  sub al, 30h

  mov [si], al
  inc si
  inc cx

  jmp input_loop

input_done:
  mov count, cl

  pop si
  pop cx
  pop bx
  pop ax
  ret
input_buffer endp
