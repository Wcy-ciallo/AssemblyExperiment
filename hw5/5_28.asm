; 5.28题目
data segment
  x db 3
  y db 16
  z db ?
data ends
code segment
  assume cs:code, ds:data
start:
  mov ax, data
  mov ds, ax

  mov al, x
  cmp al, 0      ; 先判断一下x的正负符号
  jns let1       ; 非负(!sign)就跳到let1处理

  neg al         ; x是负数的话就变号求绝对值
  mov z, al
  jmp out1
let1:
  ; 走到这说明 x >= 0，要算 z = 4x + y/16
  mov bl, 4
  imul bl        ; 先把4*x算完
  mov cx, ax     ; 挪到cx免得被覆盖

  mov bl, 16
  mov al, y
  cbw            ; 转成带符号的16位再算除法
  idiv bl        ; 算y/16

  add al, cl     ; 两块儿结果加起来放进去
  mov z, al
out1:
  mov ah, 4ch
  int 21h
code ends
end start