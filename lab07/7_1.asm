data segment
  max db 3 dup(0)
  min db 3 dup (0)
  good db 24 dup(0)
  fail db 24 dup(0)
  cn  dw 0
  sn dw 0
data ends
code segment
start:
  mov ax, data
  mov ds, ax

  mov cx, 3
  mov word ptr cn, 0
  mov di, 0
  mov bp, 0
outer_loop:
  push cx
  mov cx, 8
  mov word ptr sn, 0
inner_loop:
  ; bx是前面班级在内存中占用的字节个数
  mov ax, cn
  mov bx, 8
  mul bx
  mov bx, ax
  ; si 是当前学生的序号
  mov si, sn

  mov al, score[bx][si]
  cmp al, 90
  jb let2
  mov bx, cn
  inc byte ptr max[bx]
  mov good[di], al
  inc di
let2:
  cmp al, 60
  jae let3
  mov bx, cn
  inc byte ptr min[cn]
  mov fail[bp], al
  inc bp
let3:
  inc word ptr sn
  loop inner_loop

  inc word ptr cn
  pop cx
  loop outer_loop

  mov ah, 4ch
  int 21h
code ends
end start