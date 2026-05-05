; 6.22 对30名学生成绩按升序排序

DATA SEGMENT
    SCORE DB 88,76,95,60,59,100,73,84,91,45
          DB 66,78,82,90,55,69,72,87,93,61
          DB 70,80,85,64,58,99,96,77,68,89

    N EQU 30
DATA ENDS

CODE SEGMENT
ASSUME CS:CODE, DS:DATA

START:
    MOV AX, DATA
    MOV DS, AX

    MOV CX, N - 1       ; 外层循环次数 = 29

OUT_LOOP:
    PUSH CX             ; 保存外层CX

    MOV SI, OFFSET SCORE
    MOV CX, N - 1       ; 内层比较次数

IN_LOOP:
    MOV AL, [SI]
    CMP AL, [SI+1]
    JBE NO_SWAP         ; AL <= [SI+1]，不用交换

    ; 交换 [SI] 和 [SI+1]
    MOV BL, [SI+1]
    MOV [SI], BL
    MOV [SI+1], AL

NO_SWAP:
    INC SI
    LOOP IN_LOOP

    POP CX
    LOOP OUT_LOOP

    MOV AH, 4CH
    INT 21H

CODE ENDS
END START