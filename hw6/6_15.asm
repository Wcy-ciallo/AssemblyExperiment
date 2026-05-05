; 6.15 计算1*2+3*4+5*6+7*8并保存结果

data segment
  x dw ?
data ends
code segment
  assume cs:code, ds:data
start:
  mov ax, data
  mov ds, ax

  mov ax, 1
  mov bx, 1          ; 每项的第一个因数
  mov cx, 4          ; 共计算4项
  mov si, 0          ; SI保存累加和
sum_loop:
  mov ax, bx
  mov dx, bx
  inc dx             ; 第二个因数 = BX + 1

  mul dx             ; AX = BX * (BX + 1)

  add si, ax
  add bx, 2          ; 转到下一组奇数因数
  
  loop sum_loop

  mov x, si          ; 保存计算结果
  mov ah, 4ch
  int 21h
code ends
end start
