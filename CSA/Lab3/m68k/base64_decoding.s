    .data

.org             0x88

    ; io
input_addr:      .word  0x80
output_addr:     .word  0x84

    ; ASCII коды
const_underline: .word  95
const_endline:   .word  10
const_equal_sign: .word  61
const_A:         .word  65
const_Z:         .word  90
const_a:         .word  97
const_z:         .word  122
const_digit_0:   .word  48
const_digit_9:   .word  57
const_plus:      .word  43
const_slash:     .word  47

    ; ASCII -> Base64
offset_upper:    .word  65
offset_lower:    .word  71
offset_digit:    .word  4
base64_plus:     .word  62
base64_slash:    .word  63

    ; буфер
buffer_size:     .word  0x40
buffer_start:    .word  0

    ; ошибки
err_input:       .word  -1
err_overflow:    .word  0xCCCCCCCC

    ; константы
stack_addr:      .word  4096

    ; для сдвигов
shift_18:        .word  18
shift_16:        .word  16
shift_12:        .word  12
shift_8:         .word  8
shift_6:         .word  6

    .text

_start:
    ; небольшие оптимизации, запоминаем самые часто встречающиеся значения

    ; адресные регистры
    movea.l  input_addr, A3
    movea.l  (A3), A0                        ; A0 - указатель на чтение

    movea.l  output_addr, A3
    movea.l  (A3), A1                        ; A1 - указатель на запись

    movea.l  buffer_start, A3
    movea.l  (A3), A2                        ; A2 - указатель на буфер

    ; A3 оставим для свободных обращений к памяти

    movea.l  const_equal_sign, A4            ; A4 - всегда указатель на символ =
    movea.l  buffer_size, A5                 ; A5 - всегда указатель на размер буфера

    movea.l  stack_addr, A3
    movea.l  (A3), A7                        ; A7 - указатель на стек

    ; регистры данных
    movea.l  const_endline, A3
    move.l   (A3), D2                        ; D2 - всегда перенос строки

    movea.l  offset_upper, A3
    move.l   (A3), D1                        ; D1 - всегда разница между заглавной буквой в ASCII и в Base64

    movea.l  const_A, A6                     ; A6 - всегда указатель на символ A

    move.l   0, D7                           ; D7 - счетчик прочитанных символов

    ; заполняем буфер _
fill_buffer:
    move.l   (A5), D6                        ; размер буфера
    movea.l  const_underline, A3

fill_loop:
    move.b   (A3), (A2)+
    sub.l    1, D6                           ; декремент
    bgt      fill_loop

    movea.l  buffer_start, A3
    movea.l  (A3), A2                        ; снова ставим указатель на начало буфера

decode_loop:
    cmp.l    (A5), D7                        ; проверка на переполнение
    bge      buffer_overflow

    ; в base64 1 символ - это 6 бит
    ; в ascii - 8 бит
    ; будем читать по 4 символа (это 24 бит или же 3 ASCII символа)
    ; если первый символ блока - перенос, то чтение закончено
    ; остальные символы блока переносом быть не могут

    move.l   0, D3                           ; D3 = 0, результат текущего блока

    move.l   (A0), D0
    cmp.l    D2, D0                          ; проверка на \n
    beq      finish_decode
    jsr      char_to_base64                  ; преобразуем символ
    movea.l  shift_18, A3
    move.l   (A3), D6
    lsl.l    D6, D0                          ; сдвигаем влево на 18 бит
    or.l     D0, D3                          ; обновляем результат

    move.l   (A0), D0
    cmp.l    D2, D0
    beq      invalid_input
    jsr      char_to_base64
    movea.l  shift_12, A3
    move.l   (A3), D6
    lsl.l    D6, D0                          ; сдвигаем влево на 12 бит
    or.l     D0, D3

    move.l   (A0), D0
    cmp.l    D2, D0
    beq      invalid_input
    move.l   D0, D4                          ; запоминаем 3 символ в D4
    jsr      char_to_base64
    movea.l  shift_6, A3
    move.l   (A3), D6
    lsl.l    D6, D0                          ; сдвигаем влево на 6 бит
    or.l     D0, D3

    move.l   (A0), D0
    cmp.l    D2, D0
    beq      invalid_input
    move.b   D0, D5                          ; запоминаем 4 символ в D5
    jsr      char_to_base64
    or.l     D0, D3

    add.l    4, D7                           ; обновляем счетчик

    ; сейчас в D3 24 бита данных
    ; сдвинем вправо на 16 и отправим первый ASCII-символ
    ; сделаем это через буферный регистр D0
    move.l   D3, D0
    movea.l  shift_16, A3
    move.l   (A3), D6
    lsr.l    D6, D0
    jsr      write_byte

    cmp.b    (A4), D4                        ; если третий символ =, то полезная информация закончилась
    beq      decode_loop

    ; возвращаем целые 24 бита в D0
    ; сдвигаем вправо на 8 бит и возвращаем второй ASCII-символ
    move.l   D3, D0
    movea.l  shift_8, A3
    move.l   (A3), D6
    lsr.l    D6, D0
    jsr      write_byte

    cmp.b    (A4), D5                        ; проверяем четвертый символ на =
    beq      decode_loop

    move.l   D3, D0                          ; третий ASCII-символ в младших 8 битах
    jsr      write_byte

    jmp      decode_loop

finish_decode:
    move.b   0, (A2)                         ; стоп-символ в буфер

    movea.l  buffer_start, A3
    movea.l  (A3), A2

print_loop:
    move.l   0, D0
    move.b   (A2)+, D0
    cmp.b    0, D0
    beq      hlt
    move.l   D0, (A1)
    jmp      print_loop

hlt:
    halt

invalid_input:
    movea.l  err_input, A3
    move.l   (A3), D1
    move.l   D1, (A1)                        ; возвращаем -1

    ; нужно дочитать до конца (тест 7)
flush:
    cmp.l    D2, D0
    beq      hlt

flush_loop:
    move.l   (A0), D0
    cmp.l    D2, D0
    beq      hlt
    jmp      flush_loop

    ; переполнение
buffer_overflow:
    movea.l  err_overflow, A3
    move.l   (A3), D1
    move.l   D1, (A1)
    jmp      hlt

    ; запись одного символа
write_byte:
    ; в младшем байте D0 наш ASCII-символ
    move.b   D0, (A2)+
    rts

    ; ascii -> base64
char_to_base64:
    ; в D0 ASCII-код символа Base64

    ; проверяем заглавная ли буква, иначе проверка на строчную
    cmp.l    (A6), D0                        ; используем регистр с указателем на код A
    blt      check_lower
    movea.l  const_Z, A3
    cmp.l    (A3), D0
    bgt      check_lower
    sub.l    D1, D0                          ; используем сразу D1
    rts

check_lower:
    ; проверяем строчная ли буква, иначе проверка на цифру
    movea.l  const_a, A3
    cmp.l    (A3), D0
    blt      check_digit
    movea.l  const_z, A3
    cmp.l    (A3), D0
    bgt      check_digit
    movea.l  offset_lower, A3
    sub.l    (A3), D0
    rts

check_digit:
    ; проверяем цифра ли, иначе проверка на знак +
    movea.l  const_digit_0, A3
    cmp.l    (A3), D0
    blt      check_plus
    movea.l  const_digit_9, A3
    cmp.l    (A3), D0
    bgt      check_plus
    movea.l  offset_digit, A3
    add.l    (A3), D0
    rts

check_plus:
    ; проверяем плюс ли, иначе проверка на слэш
    movea.l  const_plus, A3
    cmp.l    (A3), D0
    bne      check_slash
    movea.l  base64_plus, A3
    move.l   (A3), D0
    rts

check_slash:
    ; проверяем слэш ли, иначе проверка на знак равно
    movea.l  const_slash, A3
    cmp.l    (A3), D0
    bne      check_equal
    movea.l  base64_slash, A3
    move.l   (A3), D0
    rts

check_equal:
    ; если и не =, то ошибка ввода
    movea.l  const_equal_sign, A3
    cmp.l    (A3), D0
    bne      invalid_input
    move.l   0, D0
    rts
