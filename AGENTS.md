# AGENTS.md

This file provides guidance to Codex (Codex.ai/code) when working with code in this repository.

## Project Overview

8086/DOS assembly language course experiments using 16-bit MASM syntax. Programs are intended to be compiled and debugged in DOSBox with MASM, LINK, and DEBUG. Most interactive programs use `int 21h` DOS interrupts for I/O and termination.

## Build & Run

```bat
masm xxx.asm;
link xxx.obj;
xxx.exe
```

Debug with:

```bat
debug xxx.exe
```

No build automation or scripts exist. Each `.asm` is assembled individually inside DOSBox.

## Architecture

Every program follows the same segment structure:

```
data segment
  ; variables, buffers, strings ($-terminated)
data ends

code segment
  assume cs:code, ds:data
start:
  mov ax, data
  mov ds, ax
  ; ... program logic ...
  mov ah, 4ch
  int 21h
code ends
end start
```

### Key conventions

- **String output**: Use `int 21h` function `09h` — string must end with `$`. Load offset into `DX` before calling.
- **Buffered input**: Use `int 21h` function `0Ah` — buffer layout is `[max_len] [actual_len] [data...]`.
- **Single char input/output**: Use `int 21h` functions `01h` / `02h`.
- **Program exit**: `mov ah, 4ch` / `int 21h`.
- **Numeric input**: Characters read via `int 21h` function `01h` are ASCII digits; subtract `30h` to get the numeric value.
- **Numeric output**: Convert hex nibble values 0-9 to ASCII by adding `30h`, values A-F by adding `37h`.
- **`XLAT` instruction**: Used for table lookups — set `BX` to table offset, `AL` to index, then `xlat`.
- **Jump tables**: Store code labels with `dw label`. Convert the menu key to a word offset before `jmp table[bx]`.
- **BP addressing**: On 8086, effective addresses using `BP` default to `SS`. Use a `ds:` segment override when indexing data arrays with `BP`.
- **Nested loops**: When using `loop` in nested loops, preserve the outer `CX` with `push cx` / `pop cx`.

## Directory Structure

- `lab01/`–`lab08/` — Course experiment folders. Newer folders use the `labNN` naming convention.
- `lab05/` — Experiment 5: flowchart design, logic debugging, and decimal-to-hex conversion (`5_1.asm`, `lab05.png`, `5.docx`).
- `lab06/` — Experiment 6: branch program design and menu jump-table program (`6_1.asm`, `6_2.asm`, `6_2.png`, `6.docx`).
- `lab07/` — Experiment 7: loop program design, score statistics, `good`/`fail` arrays, and descending bubble sort (`7_1.asm`, `7_1.LST`, flowchart/result screenshots, `7.docx`).
- `lab08/` — Experiment 8: subroutine-based student name/score input, rank-table sorting, and descending score output (`8.asm`, `8.docx`, `8流程图.drawio`, flowchart reference images).
- `hw5/` — Homework 5 source files (no compiled artifacts, `.asm` only)
- `hw6/` — Homework 6 source files for string copy, loops, array search, output, and sorting.
- `hw7/` — Homework 7 source files for subroutine design, numeric conversion, array processing, bit counting, and signed-byte summation.
- `.docx` files at root level — Course guide, cover template, report template

## Current Lab Notes

- Experiment 5 (`lab05/5_1.asm`) reads a decimal number from 0 to 255, accumulates it with `num = num * 10 + digit`, divides by 16 repeatedly, stores hex digits in reverse order, then prints them in reverse.
- Experiment 6 (`lab06/6_2.asm`) uses a jump table for menu dispatch. The table order should match the numeric menu values: `0 -> prog0`, `1 -> prog1`, `2 -> prog2`, `3 -> prog3`.
- Experiment 7 (`lab07/7_1.asm`) treats `score` as a 3 x 8 byte array. Expected debug-visible results for the current data are `max = 03 03 03`, `min = 02 02 02`, `good = 64 63 61 60 5E 5D 5C 5B 5A`, and `fail = 3B 3A 37 36 2D 2B`.
- Experiment 8 (`lab08/8.asm`) uses subroutines `inName`, `inScore`, `sort`, `disName`, and `disScore` to input 5 students, keep ASCII scores in `scoreA`, numeric scores in `scoreN`, sort `scoreN` in descending order, and use the `rank` table to print the original names and scores without moving the name records.

## Homework 7 Notes

- `hw7` uses two-space indentation in the assembly body. Keep short header comments that describe the exercise and required data segment variables; avoid adding line-by-line explanatory comments unless needed for clarity.
- Several files contain only a `proc` body rather than a full `data/code/end start` program. Do not add a full program wrapper unless the assignment asks for an independently runnable file.
- Preserve caller registers in subroutines unless a register is the intended return value. For example, `7_28.asm` returns the bit count in `CL`, and `7_21.asm` receives the value to print in `BX`.
- When mixing byte variables with word registers, load bytes through `AL/BL/CL` and clear the high byte explicitly (`AH/BH/CH`) before using the word register in address or loop calculations.
- Current `hw7` files:
  - `7_16.asm`: keyboard digit input into `buffer`, with `count` storing the number of digits.
  - `7_17.asm`: decimal digit input accumulated as `x = x * 10 + digit`.
  - `7_18.asm`: byte-array summation using `array`, `num`, and `result`.
  - `7_20.asm`: hexadecimal display of byte variable `x`.
  - `7_21.asm`: decimal display of the unsigned value passed in `BX`.
  - `7_28.asm`: count set bits in `AX`, returning the count in `CL`.
  - `7_29.asm`: find the maximum byte in `array` and store it in `max`.
  - `7_30.asm`: sum negative signed-byte elements in arrays `A` and `B`.
