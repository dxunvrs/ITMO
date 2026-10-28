; hello_fstat.asm
%define O_RDONLY 0
%define PROT_READ 0x1
%define MAP_PRIVATE 0x2
%define SYS_WRITE 1
%define SYS_OPEN 2
%define SYS_CLOSE 3
%define SYS_FSTAT 5
%define SYS_MMAP 9
%define SYS_MUNMAP 11
%define SYS_EXIT 60
%define FD_STDOUT 1

section .data
    fname: db 'hello.txt', 0

section .text
global _start

print_substring:
    mov  rdx, rsi       ; длина
    mov  rsi, rdi       ; указатель на данные
    mov  rax, SYS_WRITE
    mov  rdi, FD_STDOUT
    syscall
    ret

_start:
    ; Открываем файл
    mov  rax, SYS_OPEN
    mov  rdi, fname
    mov  rsi, O_RDONLY
    xor  rdx, rdx
    syscall
    mov  r12, rax       ; сохраняем fd в r12

    ; Выделяем место на стеке под struct stat (144 байта, выровняем до 144)
    sub  rsp, 144
    mov  rax, SYS_FSTAT
    mov  rdi, r12
    mov  rsi, rsp
    syscall

    ; Извлекаем st_size (смещение 48)
    mov  r13, [rsp + 48] ; r13 = размер файла
    add  rsp, 144       ; освобождаем стек

    ; Вызываем mmap(0, st_size, PROT_READ, MAP_PRIVATE, fd, 0)
    mov  rax, SYS_MMAP
    xor  rdi, rdi
    mov  rsi, r13       ; length = точный размер файла
    mov  rdx, PROT_READ
    mov  r10, MAP_PRIVATE
    mov  r8, r12        ; fd
    xor  r9, r9         ; offset = 0
    syscall
    mov  r14, rax       ; r14 = указатель на память

    ; Печатаем содержимое файла через print_substring
    mov  rdi, r14       ; указатель
    mov  rsi, r13       ; размер
    call print_substring

    ; Освобождаем память munmap
    mov  rax, SYS_MUNMAP
    mov  rdi, r14
    mov  rsi, r13
    syscall

    ; Закрываем файл
    mov  rax, SYS_CLOSE
    mov  rdi, r12
    syscall

    ; Выход
    mov  rax, SYS_EXIT
    xor  rdi, rdi
    syscall
