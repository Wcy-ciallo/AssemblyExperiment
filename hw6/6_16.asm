; 6.16 在字符数组中查找'@'，找到则置标志为1

data segment
  catt db 'A', 'B', 'C', '@', 'D', 'E', 'F'
  count equ $ - catt
  sign db 0
data ends
code segment
  assume cs:code, ds:data
start:
  mov ax, data
  mov ds, ax

  mov si, offset catt
  mov cx, count
  mov al, '@'        ; 待查找字符
  mov sign, 0        ; 默认未找到

find_loop:
  cmp [si], al
  je found           ; 相等则查找成功
  inc si
  loop find_loop

  jmp exit
found:
  mov sign, 1        ; 找到'@'

exit:
  mov ah, 4ch
  int 21h
code ends
end start
