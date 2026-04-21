data segment
  table db '012345678'
data ends

code segment
  assume ds:data, cs:code
start:
  mov ax, data
  mov ds, ax

  ; bx放置table的首地址，al放置要查询的第几个数据
  mov bx, offset table
  mov al, 05h
  xlat
  mov dl, al ; 查询结果放在dl寄存器中

  mov ah, 4ch
  int 21h
code ends
end start