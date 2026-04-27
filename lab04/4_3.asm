data segment
  name0 db 'nothing     $'
  name1 db 'CHenZihui   $'
  name2 db 'LiSimeng    $'
  name3 db 'LiZishi     $'
  name4 db 'XiaoJianhui $'
  name5 db 'HuangSihan  $'

  ; stu_ptrs相当于存储了不同学生姓名的指针
  stu_ptrs dw offset name0
           dw offset name1
           dw offset name2
           dw offset name3
           dw offset name4
           dw offset name5
  msg db 'Please input the student number: $'
  crlf db 0dh, 0ah, '$'
data ends
code segment
  assume cs:code, ds:data
start:
  mov ax, data
  mov ds, ax

  mov dx, offset msg
  mov ah, 09h
  int 21h

  mov ah, 01h
  int 21h

  push ax
  mov dx, offset crlf
  mov ah, 09h
  int 21h
  pop ax

  sub al,30h

  mov ah, 0
  shl ax, 1
  mov bx, ax

  mov dx, stu_ptrs[bx]

  mov ah, 09h
  int 21h

  mov dx, offset crlf
  mov ah, 09h
  int 21h

  mov ah, 4ch
  int 21h

code ends
end start
