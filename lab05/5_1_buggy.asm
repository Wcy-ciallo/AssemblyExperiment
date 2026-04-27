; 这是原始有 bug 的版本
data segment
  info db 'DEC=$'
  num db 0
  i db 0
  hex db 5 dup(0)
  info1 db 'HEX=$'
data ends
code segment
  assume cs:code, ds:data
start:
  mov ax, data
  mov ds, ax

  mov dx, offset info
  mov ah, 09h
  int 21h
let1:
  mov ah, 1
  int 21h
  cmp al, 0dh
  jz let0
  sub al, 30h
  push ax
  mov al, num
  mov bl, 10
  mul bl
  mov num, al
  pop ax
  add num, al
  jmp let1

let0:
  mov al, num
  mov ah, 0
let2:
  mov bl, 16
  div bl
  cmp ah, 9
  ja let3
  add ah, 30h
  jmp let4

let3:
  add ah, 37h
let4:
  mov dx, offset info1
  mov ah, 09h
  int 21h           ; <-- BUG: 每次循环都打印 "HEX="
  mov bl, i
  mov bh, 0
  mov hex[bx], ah   ; <-- BUG: AH=09h（被上一行覆盖了），不是 hex 字符
  inc byte ptr i
  mov ah, 0
  cmp al, 0
  jnz let2
let6:
  cmp byte ptr i, 0
  jbe let5
  dec byte ptr i
  mov bl, i
  mov bh, 0
  mov dl, hex[bx]
  mov ah, 02h
  int 21h
  jmp let6
let5:
  mov ah, 4ch
  int 21h
code ends
end start
