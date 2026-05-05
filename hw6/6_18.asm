; 6.18 输入一个数字字符，循环输出从该数字开始的10个数字

data segment
  info1 db 'Input a digit: $'
  info2 db 0dh, 0ah, 'Result: $'
data ends
code segment
assume cs:code, ds:data
start:
  mov ax, data
  mov ds, ax

  ; 提示并读取一个数字字符
  mov ah, 09h
  mov dx, offset info1
  int 21h
  mov ah, 01h
  int 21h

  mov bl, al
  mov ah, 09h
  mov dx, offset info2
  int 21h
  mov cx, 10         ; 输出10个字符
print_loop:
  mov dl, bl
  mov ah, 02h
  int 21h
  inc bl             ; 转到下一个数字字符
  cmp bl, '9' + 1
  jne next
  mov bl, '0'        ; 超过'9'后从'0'继续
next:
  loop print_loop
  mov ah, 4ch
  int 21h
code ends
end start
  
