; 6.14 将数据段中的字符串复制到附加段

data segment
  strg1 db 'HELLO 8086'
  len equ $ - strg1
data ends
extra segment
  strg2 db len dup(?)
extra ends
stack segment stack
  db 100 dup(?)
stack ends
code segment
  assume cs:code, ds:data, es:extra, ss:stack
start:
  ; 初始化各段寄存器
  mov ax, data
  mov ds, ax
  mov ax, extra
  mov es, ax
  mov ax, stack
  mov ss, ax

  lea si, strg1
  lea di, strg2
  mov cx, len
  cld                ; 设置正向传送
  rep movsb          ; 将DS:SI复制到ES:DI
  
  mov ah, 4ch
  int 21h

code ends
end start
