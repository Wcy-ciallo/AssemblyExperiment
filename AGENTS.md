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

- `lab01/`–`lab07/` — Course experiment folders. Newer folders use the `labNN` naming convention.
- `lab05/` — Experiment 5: flowchart design, logic debugging, and decimal-to-hex conversion (`5_1.asm`, `lab05.png`, `5.docx`).
- `lab06/` — Experiment 6: branch program design and menu jump-table program (`6_1.asm`, `6_2.asm`, `6_2.png`, `6.docx`).
- `lab07/` — Experiment 7: loop program design, score statistics, `good`/`fail` arrays, and descending bubble sort (`7_1.asm`, `7_1.LST`, flowchart/result screenshots, `7.docx`).
- `hw5/` — Homework 5 source files (no compiled artifacts, `.asm` only)
- `.docx` files at root level — Course guide, cover template, report template

## Current Lab Notes

- Experiment 5 (`lab05/5_1.asm`) reads a decimal number from 0 to 255, accumulates it with `num = num * 10 + digit`, divides by 16 repeatedly, stores hex digits in reverse order, then prints them in reverse.
- Experiment 6 (`lab06/6_2.asm`) uses a jump table for menu dispatch. The table order should match the numeric menu values: `0 -> prog0`, `1 -> prog1`, `2 -> prog2`, `3 -> prog3`.
- Experiment 7 (`lab07/7_1.asm`) treats `score` as a 3 x 8 byte array. Expected debug-visible results for the current data are `max = 03 03 03`, `min = 02 02 02`, `good = 64 63 61 60 5E 5D 5C 5B 5A`, and `fail = 3B 3A 37 36 2D 2B`.
