; 5.31代码实现
data segment

data ends
code segment
  assume cs:code, ds:data
start:
  mov ax, data
  mov ds, ax

  mov ax, 6789h  ; 这里是要做位操作的数

  mov dl, ah
  and dl, 0ch    ; 用00001100把ah里的第2,3位提出来
  shr dl, 1      ; 因为提出来太偏左了，右移2变成正常的数
  shr dl, 1

  mov cl, ah
  and cl, 03h    ; 直接提ah里头的第0,1位

  mov bl, al
  and bl, 0ch    ; 提取al里头第2,3位
  shr bl, 1      ; 一样右移
  shr bl, 1

  and al, 03h    ; 原地的al也只留最后的0,1这两位

  mov ah, 4ch
  int 21h
code ends
end start