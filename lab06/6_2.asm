data segment
  table dw prog0, prog1, prog2, prog3
  menu db 0dh, 0ah, '1.prog1  2.prog2  3.prog3  0.exit', 0dh, 0ah
       db 'Choose:$'
  info1 db 'z = x + y = $'
  info2 db 'Convert lowercase letters to uppercase, please input a letter: ', 0dh, 0ah, '$'
  info3 db 'Convert uppercase letters to lowercase, please input a letter: ', 0dh, 0ah, '$'
  x db 3
  y db 6
  z db ?
data ends
code segment
  assume cs:code, ds:data
start:
  mov ax, data
  mov ds, ax
let0:
  mov dx, offset menu
  mov ah, 09h
  int 21h

  mov ah, 01h
  int 21h
  and al, 03h
  mov ah, 0
  shl ax, 1
  mov bx, ax
  jmp table[bx]
prog1:
  mov dx, offset info1
  mov ah, 09h
  int 21h
  mov al, x
  add al, y
  mov z, al
  add al, 30h
  mov dl, al
  mov ah, 02h
  int 21h
  jmp let0
prog2:
  mov dl, 0ah
  mov ah, 02h
  int 21h

  mov dx, offset info2
  mov ah, 09h
  int 21h
  mov ah, 01h
  int 21h

  and al, 0dfh
  jmp let1
prog3: 
  mov dl, 0ah
  mov ah, 02h
  int 21h

  mov dx, offset info3
  mov ah, 09h
  int 21h
  mov ah, 01h
  int 21h

  or al, 20h
  jmp let1
let1:
  mov dl, al
  mov ah, 02h
  int 21h
  jmp let0
prog0:
  mov ah, 4ch
  int 21h
code ends
end start