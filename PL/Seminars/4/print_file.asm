global print_file
global print_string

%define O_RDONLY 0
%define PROT_READ 0x1
%define MAP_PRIVATE 0x2
%define SYS_WRITE 1
%define SYS_OPEN 2
%define SYS_CLOSE 3
%define SYS_FSTAT 5
%define SYS_MMAP 9
%define SYS_MUNMAP 11
%define FD_STDOUT 1

section .text

string_length:
    xor  rax, rax
.loop:
    cmp  byte [rdi+rax], 0
    je   .end
    inc  rax
    jmp  .loop
.end:
    ret

print_string:
    push rdi
    call string_length
    pop  rsi
    mov  rdx, rax
    mov  rax, SYS_WRITE
    mov  rdi, FD_STDOUT
    syscall
    ret

; void print_file(const char *filename)
print_file:
    ; Сохраняем callee-saved регистры
    push rbx
    push r12
    push r13
    push r14

    ; 1. Открываем файл (rdi уже содержит filename)
    mov  rax, SYS_OPEN
    mov  rsi, O_RDONLY
    xor  rdx, rdx
    syscall

    test rax, rax
    js   .error         ; если rax < 0, произошла ошибка
    mov  r12, rax       ; r12 = fd

    ; 2. Вызываем fstat
    sub  rsp, 144
    mov  rax, SYS_FSTAT
    mov  rdi, r12
    mov  rsi, rsp
    syscall

    mov  r13, [rsp + 48] ; r13 = st_size
    add  rsp, 144

    test r13, r13
    jz   .close_file    ; если файл пустой, выходим

    ; 3. Вызываем mmap
    mov  rax, SYS_MMAP
    xor  rdi, rdi
    mov  rsi, r13
    mov  rdx, PROT_READ
    mov  r10, MAP_PRIVATE
    mov  r8, r12
    xor  r9, r9
    syscall

    mov  r14, rax       ; r14 = адрес отображенной памяти

    ; 4. Печать содержимого в stdout
    mov  rax, SYS_WRITE
    mov  rdi, FD_STDOUT
    mov  rsi, r14
    mov  rdx, r13
    syscall

    ; 5. Освобождаем память (munmap)
    mov  rax, SYS_MUNMAP
    mov  rdi, r14
    mov  rsi, r13
    syscall

.close_file:
    ; 6. Закрываем файл (close)
    mov  rax, SYS_CLOSE
    mov  rdi, r12
    syscall

.error:
    ; Восстанавливаем сохраненные регистры
    pop  r14
    pop  r13
    pop  r12
    pop  rbx
    ret
