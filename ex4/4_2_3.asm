data segment
info1 db 'input class id:$'
info2 db 0dh, 0ah, 'input student id:$'
score dw 100, 98, 98, 97, 95
      dw 100, 98, 96, 95, 95
sn db 5

data ends
; 查找出来的成绩放到ax里面

code segment
assume cs:code, ds:data
start:
  mov ax, data
  mov ds, ax

  ; 相对基址变址寻址方式 
  mov dx, offset info1
  mov ah, 9h
  int 21h
  
  mov ah, 1h
  int 21h ; 输入班级号
  sub al, 30h
  dec al
  mov cl, sn
  mul cl ; al = (class_id - 1) * 5
  mov cl, 2
  mul cl ; al=(class_id - 1)*5*2 我前面班级的学生在内存中占用的字节个数
  mov bx, ax

  mov dx, offset info2
  mov ah, 9h
  int 21h
  
  mov ah, 1h
  int 21h
  sub al, 30h
  dec al
  mov cl, 2
  mul cl ; ax=(student_id-1)*2 我班级中前面学生在内存中占用的字节数
  xor si, si
  add si, ax

  mov ax, score[bx][si]


  mov ah, 4ch
  int 21h

code ends
end start