.data
    .org 0x88

input_addr:  .word 0x80
output_addr: .word 0x84

my_var:      .word 999       ; Просто переменная. Мы узнаем её адрес в Кейсе 4!

; КЕЙС 3: ЧТО ЕСЛИ ПОЛОЖИТЬ ДАННЫЕ В 0x80?
;   .org 0x80
;   crash_var: .word 42


    .text
_start:

    ; jmp test_case_4    ; УСПЕШНЫЙ ТЕСТ: Взятие адреса метки

    ; jmp test_case_1  ; КРАШ: Запись в порт ввода

    jmp test_case_2  ; КРАШ: Выполнение кода из порта ввода


; КЕЙС 4: load_imm <метка>
; Ожидание: Программа выведет в порт 0x84 число (адрес переменной my_var)

test_case_4:
    load_imm my_var           ; В Acc ложится АДРЕС метки (как число)
    store_ind output_addr     ; Отправляем этот АДРЕС в порт вывода
    halt


; КЕЙС 1: Запись в 0x80
; Ожидание: Ошибка доступа к памяти (write to read-only)

test_case_1:
    load_imm 42               ; Кладем в Acc число 42
    store_addr 0x80           ; Насильно пытаемся записать 42 в порт ВВОДА!
    load input_addr
    load_acc
    store_addr 0x84
    halt


; КЕЙС 2: Исполнение из 0x80
; Ожидание: Illegal instruction (попытка расшифровать букву как команду)

test_case_2:
    jmp 0x80                  ; Насильно отправляем процессор за кодом в порт 0x80!
    halt
