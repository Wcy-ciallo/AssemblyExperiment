; 5.26代码实现
data segment
  x db 11
  outy db 'Y$'
  outn db 'N$'
data ends

code segment
  assume cs:code, ds:data
start:
  mov ax, data
  mov ds, ax

  mov al, x      ; 拿到数x
  shr al, 1      ; 右移1位，利用标志位判断奇偶
  jc let2        ; 如果有进位说明是奇数，跳到let2
let1:
  mov dx, offset outy  ; 偶数分支，准备输出Y
  mov ah, 09h
  int 21h
  jmp out1
let2:
  mov dx, offset outn  ; 奇数分支，准备输出N
  mov ah, 09h
  int 21h
out1:
  mov ah, 4ch    ; 程序结束回家啦
  int 21h

code ends
end start