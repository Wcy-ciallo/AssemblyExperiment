; 6.20 在字符数组中查找最小数字字符

data segment
  found db '8', '3', '9', '1', '5', '7', '2'
  count equ $ - found
  min db ?
data ends
code segment
assume cs:code, ds:data
start:
  mov ax, data
  mov ds, ax

  mov si, offset found

  mov al, [si]
  mov min, al        ; 先用第一个元素作为最小值
  inc si
  mov cx, count - 1  ; 还需比较的元素个数

found_min:
  mov al, [si]
  cmp al, min
  jae not_smaller    ; 当前值不小于min

  mov min, al        ; 更新最小值
not_smaller:
  inc si
  loop found_min
  
  mov ah, 4ch
  int 21h
code ends
end start
