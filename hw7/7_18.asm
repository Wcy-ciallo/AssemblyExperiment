; 7.18子程序代码
; data segment定义如下
; array db 10, 20, 30, 40, 50
; num db 5
; result db 0
sum proc
  push ax
  push bx
  push cx
  mov cl, num
  mov ch, 0
loop1:
  mov al, result
  mov bl, num
  mov bh, 0
  sub bx, cx
  add al, array[bx]
  mov al, result
  loop loop1
  pop cx
  pop bx
  pop ax
  ret
sum endp