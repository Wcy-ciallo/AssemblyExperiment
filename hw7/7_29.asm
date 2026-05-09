; 7.29子程序代码
; 数据段：
; array db 10, 20, 30, 40, 50
; num db 5
; max db ?
find_max proc
  push ax
  push bx
  push cx
  push si

  mov cl, num
  mov ch, 0
  mov bl, 0
  mov si, offset array
loop1:
  mov al, [si]
  cmp al, bl
  jl less
  mov bl, al
less:
  inc si
  loop loop1
  
  mov max, bl

  pop si
  pop cx
  pop bx
  pop ax
  ret
find_max endp