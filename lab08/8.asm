data segment
  n equ 5
  nameA db n dup(11, ?, 13 dup ('$'))
  scoreA db n dup(4 dup('$'))
  rank db 0, 1, 2, 3, 4
  scoreN db n dup(0)
  sn db 0
  t db 0
  num db 0
data ends
code segment
assume cs:code, ds:data
start:
  mov ax, data
  mov ds, ax

  mov cx, n
  mov sn, 0
l1:
  call inName
  mov dl, 0dh
  mov ah, 02h
  int 21h
  mov dl, 0ah
  mov ah, 02h
  int 21h
  call inScore
  inc sn
  loop l1

  call sort
  mov t, 0
  mov cx, n
l2:
  call disName
  mov dl, 0dh
  mov ah, 02h
  int 21h
  mov dl, 0ah
  mov ah, 02h
  int 21h
  call disScore
  inc t
  loop l2

  mov ah, 4ch
  int 21h

inName proc
  push ax
  push bx
  push dx

  mov bl, sn
  mov al, 15
  mul bl
  mov bx, offset nameA
  add bx, ax ;bx = nameA + sn * 15
  mov dx, bx
  mov ah, 0ah
  int 21h
  mov byte ptr [bx], 0ah
  inc bx
  mov byte ptr [bx], 0dh
  
  pop dx
  pop bx
  pop ax
  ret
inName endp
inScore proc
  push ax
  push bx
  push cx

  mov num, 0
  ; 计算scoreAsc[sn]
  mov al, sn
  mov cl, 4
  mul cl
  mov bx, offset scoreA
  add bx, ax
let1:
  mov ah, 1
  int 21h
  cmp al, 0dh
  jz let0
  ; 把数字的ascii码存到相应位置
  mov [bx], al
  inc bx

  sub al, 30h
  push ax
  mov al, num
  mov bl, 10
  mul bl ; ax = num * 10
  mov num, al
  pop ax
  add num, al
  jmp let1
let0:
  mov bl, sn
  mov bh, 0
  mov al, num
  mov scoreN[bx], al

  pop cx
  pop bx
  pop ax
  ret
inScore endp
sort proc
  push ax
  push cx
  push di
  push si

  mov cx, n
  dec cx

outer_loop:
  push cx
  mov si, offset scoreN
  mov di, offset rank
inner_loop:
  mov al, [si]
  cmp al, [si + 1]
  jae no_swap
  ; 交换 scoreN
  xchg al, [si+1]
  mov [si], al
  ; 交换 rank
  mov al, [di]
  xchg al, [di+1]
  mov [di], al
no_swap:
  inc si
  inc di
  loop inner_loop
  
  pop cx
  loop outer_loop
  pop si
  pop di
  pop cx
  pop ax
  ret
sort endp
disScore proc
  push ax
  push bx
  push cx
  push dx

  mov al, 4
  mov bl, t
  mov bh, 0
  mov cl, rank[bx]
  mul cl
  mov bx, offset scoreA
  add bx, ax
  mov dx, bx
  mov ah, 09h
  int 21h
  
  pop dx
  pop cx
  pop bx
  pop ax
  ret
disScore endp
disName proc
  push ax
  push bx
  push cx
  push dx

  mov bl, t
  mov bh, 0
  mov cl, rank[bx]
  mov al, 15
  mul cl
  mov bx, offset nameA
  add bx, ax
  mov dx, bx
  mov ah, 09h
  int 21h

  pop dx
  pop cx
  pop bx
  pop ax
  ret
disName endp

code ends
end start