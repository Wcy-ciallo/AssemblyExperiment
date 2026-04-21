data segment
  a dw 8
  score dw 3, 2, 5, 6, 7, 8
  tail dw 100, 200, 300
data ends

code segment
  assume ds:data, cs:code
start:
  mov ax, data
  mov ds, ax

  mov bx, offset score
  mov si, bx ; si = score的首地址

  mov di, bx
  add di, 4 ; di = score[1]

  mov bp, bx
  add bp, 8 ; bp = score[2]

  mov dx, bx
  add dx, 0ch ; dx = score[3]（越界的第3行地址）

  mov ax, [bx+0ah] ; ax = score[2][1] = 8
  mov cx, [bx+10h] ; cs = score[3][2], 越界

  mov ax, 4c00h
  int 21h
code ends
end start