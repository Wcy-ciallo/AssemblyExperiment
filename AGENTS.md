# AGENTS.md

This file provides guidance to Codex (Codex.ai/code) when working with code in this repository.

## Project Overview

8086/DOS assembly language course experiments using 16-bit MASM syntax. All programs use `int 21h` DOS interrupts for I/O and termination.

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

No build automation or scripts exist — each `.asm` is assembled individually.

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

## Directory Structure

- `ex1/`–`ex5/` — Course experiments, each containing `.asm` source, compiled artifacts (`.OBJ`, `.LST`, `.EXE`), and a `.docx` report
- `hw5/` — Homework 5 source files (no compiled artifacts, `.asm` only)
- `.docx` files at root level — Course guide, cover template, report template
