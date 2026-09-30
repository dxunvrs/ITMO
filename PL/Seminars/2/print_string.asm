; print_string.asm
section .data
message:       db  'hello, world!', 0
error_message: db  'hello, errors!', 0
newline: db 10

section .text
global _start

exit:
    mov  rax, 60
    xor  rdi, rdi
    syscall

string_length:
    mov  rax, rdi
  .counter:
    cmp  byte [rdi], 0
    je   .end
    inc  rdi
    jmp  .counter
  .end:
    sub  rdi, rax
    mov  rax, rdi
    ret

print_string:
    push rdi
    call string_length
    pop rdi

    mov rsi, rdi
    mov rdx, rax
    mov rax, 1
    mov rdi, 1
    syscall

    mov rdx, 1
    mov rsi, newline
    mov rdi, 1
    mov rax, 1
    syscall

    ret

_start:
    mov  rdi, message
    call print_string

    mov rdi, error_message
    call print_string

    call exit
