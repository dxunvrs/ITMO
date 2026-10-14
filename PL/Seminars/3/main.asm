%include "lib.inc"

section .text

global _start

_start:
    ; number 1122... in hexadecimal format
    mov rsi, 0x1122334455667788
    call print_hex

    mov rsi, 0xFFF1
    call print_hex

    mov rsi, 0x1984
    call print_hex

    call exit
