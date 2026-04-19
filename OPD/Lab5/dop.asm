current: WORD ? ; текущее число
result: WORD ? ; результат
op: WORD ? ; текущая операция (будем считать, что 0x0A это "-", а 0x0B это "+")
temp_symbol: WORD ? ; текущий символ

is_negative: WORD ? ; 0 - нет, 1 - да
current_digit: WORD ? ; текущая цифра на выводе
current_r: WORD ? ; текущее кол-во десятков
position_counter: WORD ? ; счетчик позиции на ВУ-7

temp: WORD ?

start:
    CLA
    ST current
    ST result
    ST temp_symbol
    ST is_negative
    ST current_digit
    ST current_r
    ST position_counter
    ST temp

    LD #0x0B
    ST op

keyboard_in:
    CLA
    IN 0x1D
    AND #0x40
    BEQ keyboard_in

    CLA
    IN 0x1C
    ST temp_symbol

    ; проверка, что ввели

    CMP #0x0A ; ввели число
    BLT digit_in

    CMP #0x0C ; ввели плюс или минус
    BLT op_in

    CMP #0x0F ; ввели равно
    BEQ op_in

    ; на остальное без разницы
    JUMP keyboard_in

digit_in:
    LD current ; сначала умножим на 10, 10x = 8x + 2x
    ASL
    ST temp
    ASL
    ASL
    ADD temp
    ADD temp_symbol ; добавим цифру, 10x + DIGIT
    ST current

    JUMP keyboard_in
    

op_in:
    ; сейчас ввели знак, мы сделаем result = result +- current и очистим current,
    ; а потом сохраним новый знак
    ; +- определится по переменной op

    LD op
    CMP #0x0A ; "-"
    BEQ minus
    CMP #0x0B ; "+"
    BEQ plus

    JUMP keyboard_in

minus:
    LD result
    SUB current
    ST result
    JUMP save_op

plus:
    LD result
    ADD current
    ST result
    JUMP save_op

save_op: ; если равно, то выводим результат
    CLA
    ST current
    LD temp_symbol

    CMP #0x0F
    BEQ show_result

    ST op
    JUMP keyboard_in

show_result:
    LD result

    BPL init_r
    NEG
    ST result
    LD #0x01
    ST is_negative

    init_r:
        LD result
        ST current_r

    show_loop:
        LD current_r
        ST current_digit
        CLA
        ST current_r

        div_loop:
            LD current_digit
            CMP #10
            BLT end_loop
            SUB #10
            ST current_digit
            OR (current_r)+ ; инкремент счетчика десятков
            JUMP div_loop
        
    end_loop:
        ; сейчас в аккумуляторе текущая цифра, а в current_r - число десятков
        ST temp

        LD position_counter
        PUSH
        LD temp
        PUSH
        CALL show_symbol
        OR (position_counter)+

        LD current_r
        BEQ show_end
        JUMP show_loop

show_end:
    LD is_negative
    BEQ fill_void
    ; если отрицательное, то ставим минус

    LD position_counter
    PUSH
    LD #0x0A
    PUSH
    CALL show_symbol
    OR (position_counter)+

    fill_void:
        LD #8 ; кол-во цифр на ВУ-7
        SUB position_counter
        BEQ prog_hlt
        BMI prog_hlt

        ST temp
        JUMP final_loop

        iter:
            LD position_counter
            PUSH
            LD #0x0B
            PUSH
            CALL show_symbol
            OR (position_counter)+
        final_loop: ; удаляем ненужное
            LOOP temp
            JUMP iter

prog_hlt:
    HLT

show_symbol:
    LD &1
    ST symbol
    LD &2
    ST position

    ASL
    ASL
    ASL
    ASL
    OR symbol
    OUT 0x14

    RET

    symbol: WORD ? ; символ на вывод
    position: WORD ? ; позиция