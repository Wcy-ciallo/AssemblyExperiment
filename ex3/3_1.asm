data segment
  a dw 8
  arr dw 16, 32, 64
  b dw 128
data ends

code segment
  assume cs:code, ds:data
start:
  mov ax, data
  mov ds, ax

  mov bx, offset arr
  mov word ptr [bx-2], 3
  mov word ptr [bx+14], 4

  mov ax, 4ch
  int 21h
code ends
end start

