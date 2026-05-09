; 7.28子程序代码
sum proc
  push ax
  push bx

  mov cx, 16 ; ax有16位数
  xor bl, bl
sum_loop:
  test ax, 1
  jz next_bit

  inc bl
next_bit:
  shr ax, 1
  loop sum_loop

  mov cl, bl
  pop bx
  pop ax
  ret
sum endp