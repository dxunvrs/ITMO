.data
    .org 0x88

input_addr:      .word  0x80
output_addr:     .word  0x84

ptr:             .word  0
cursor:          .word  1
len:             .word  0
cur_char:        .word  0
print_ptr:       .word  1

; Константы
const_zero:      .word  0
const_one:       .word  1
const_32:        .word  32
const_max_len:   .word  31
const_5F:        .word  0x5F
const_pad_5F:    .word  0x5F5F5F00
mask_clean_byte: .word  0xFFFFFF00
const_10:        .word  10
const_a:         .word  97
const_z:         .word  122
const_case:      .word  32
mask_ff:         .word  0xFF

    .text

_start:
    ; === 1. Инициализация буфера mem[0..31] символами '_' ===
    load_imm     0
    store        ptr

fill_loop:
    load         ptr
    sub          const_32
    beqz         fill_done

    load         const_5F
    store_ind    ptr

    load         ptr
    add          const_one
    store        ptr
    jmp          fill_loop

fill_done:

    ; === 2. Чтение, конвертация и сохранение в память ===
read_loop:
    load         input_addr
    load_acc
    and          mask_ff
    store        cur_char

    ; Проверка на конец строки '\n'
    sub          const_10
    beqz         read_done

    ; Проверка на переполнение буфера (если уже 31 символ, а это не '\n')
    load         len
    sub          const_max_len
    beqz         buffer_overflow

    ; Проверка на строчную букву ['a' .. 'z']
    load         cur_char
    sub          const_a
    bltz         skip_upper

    load         const_z
    sub          cur_char
    bltz         skip_upper

    ; Перевод в заглавную
    load         cur_char
    sub          const_case
    store        cur_char

skip_upper:
    ; Сохраняем в память mem[cursor]
    load         cur_char
    or           const_pad_5F
    store_ind    cursor

    ; cursor++
    load         cursor
    add          const_one
    store        cursor

    ; len++
    load         len
    add          const_one
    store        len

    jmp          read_loop

read_done:
    ; === 3. Запись длины в mem[0] ===
    load         const_zero
    load_acc
    and          mask_clean_byte
    add          len
    store_ind    const_zero

    ; === 4. Вывод результата в порт 0x84 (только если нет ошибки) ===
    load_imm     1
    store        print_ptr

print_loop:
    load         len
    beqz         all_done        ; Если строка была пустой (len == 0)

    ; Читаем символ из памяти mem[print_ptr]
    load         print_ptr
    load_acc
    and          mask_ff
    store_ind    output_addr     ; отправляем в порт 0x84

    ; Проверяем, напечатали ли все len символов (print_ptr == len)
    load         print_ptr
    sub          len
    beqz         all_done

    load         print_ptr
    add          const_one
    store        print_ptr
    jmp          print_loop

all_done:
    halt

buffer_overflow:
    ; При ошибке выводим ТОЛЬКО код ошибки
    load_imm     0xCCCC_CCCC
    store_ind    output_addr
    halt