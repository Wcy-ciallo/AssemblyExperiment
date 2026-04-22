; 5.27代码实现
data segment
  x db -10
  y db ?
  info db 'x = $'
data ends
code segment
  assume cs:code, ds:data
start:
  mov ax, data
  mov ds, ax

  mov dx, offset info  ; 先输出提示字符"x = "
  mov ah, 09h
  int 21h
  
  mov al, x
  cmp al, 0      ; 判断下正负
  jns let2       ; 不是负数(>=0)就跳走
let1:
  ; 走到这说明是负数，算 y = (x+3)*4
  add al, 3
  mov bl, 4
  imul bl
  mov y, al      ; 存结果
  jmp out1
let2:
  cmp al, 0
  jz let3        ; 等于0再跳走
  
  ; 走到这说明大于0，算 y = x/2
  mov ah, 0      ; 除法前清零ah
  mov bl, 2
  idiv bl
  mov y, al
  jmp out1
let3:
  ; 走到这说明是0，y 就是 0
  mov bl, 0
  mov y, bl
out1:
  mov ah, 4ch
  int 21h

code ends
end start