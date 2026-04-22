; 5.29实现代码
data segment
  M dw 0, 10, -1, -2, -3, 0, 2, 98, 33, 71
  POSI db 0
  NEGA db 0
  ZERO db 0
data ends
code segment
  assume cs:code, ds:data
start:
  mov ax, data
  mov ds, ax

  mov bx, 0      ; bx做数组指针
  mov ch, 10     ; 要循环看10个数字
let1:
  mov ax, M[bx]  ; 取出一个元素存ax
  cmp ax, 0      ; 先看看比0大小
  jns let2
  
  inc NEGA       ; 说明是负数，负数的个数加一个
  jmp let4
let2:
  jz let3
  
  inc POSI       ; 这里就是正数啦，加一个
  jmp let4
let3:
  inc ZERO       ; 剩下的只有等于0了，加加
let4:
  add bx, 2      ; 数组写的是dw，所以指针要加2字节
  dec ch
  cmp ch, 0      ; 查完这10次没
  jnz let1

  mov ah, 4ch
  int 21h
code ends
end start
