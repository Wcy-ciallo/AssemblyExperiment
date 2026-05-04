data segment
  score db 78, 92, 55, 96, 43, 88, 61, 90
        db 91, 59, 76,100, 45, 83, 67, 94
        db 58, 62, 97, 89, 54, 93, 70, 99
  max db 3 dup(0)
  min db 3 dup (0)
  good db 24 dup(0)
  fail db 24 dup(0)
  cn  dw 0
  sn dw 0
data ends
code segment
  assume cs:code, ds:data
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
  inc byte ptr min[bx]
  mov ds:fail[bp], al
  inc bp
let3:
  inc word ptr sn
  loop inner_loop

  inc word ptr cn
  pop cx
  loop outer_loop

  mov ax, di
  cmp ax, 1
  jbe sort_fail        ; 0个或1个元素不用排序

  dec ax               ; 外层循环次数 = n - 1
  mov cx, ax

good_outer:
  push cx              ; 保存外层循环次数
  mov si, 0            ; SI 从数组第0个元素开始

good_inner:
  mov al, good[si]
  cmp al, good[si+1]
  jae good_no_swap     ; 如果 good[si] >= good[si+1]，不用换

  ; 否则交换两个相邻成绩
  xchg al, good[si+1]
  mov good[si], al

good_no_swap:
  inc si
  loop good_inner

  pop cx
  loop good_outer

  ; 对 fail 数组降序冒泡排序
  ; BP 中保存 fail 数组有效成绩个数
sort_fail:
  mov ax, bp
  cmp ax, 1
  jbe sort_done        ; 0个或1个元素不用排序

  dec ax
  mov cx, ax

fail_outer:
  push cx
  mov si, 0

fail_inner:
  mov al, fail[si]
  cmp al, fail[si+1]
  jae fail_no_swap     ; 如果 fail[si] >= fail[si+1]，不用换

  xchg al, fail[si+1]
  mov fail[si], al

fail_no_swap:
  inc si
  loop fail_inner

  pop cx
  loop fail_outer


sort_done:
  mov ah, 4ch
  int 21h
code ends
end start