%include "lib.inc"

%macro pushn 1-*
    %rep %0
        push %1
        %rotate 1
    %endrep
%endmacro

%macro popn 1-*
    %rep %0
        pop %1
        %rotate -1
    %endrep
%endmacro

section .text

global _start

_start:
    mov rdi, 10
    mov rsi, 2

    pushn rdi, rsi

    xor rdi, rdi
    xor rsi, rsi

    popn rsi, rdi

    call print_hex

    call exit
