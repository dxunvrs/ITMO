org 0x000
v0: WORD $int1, 0x180 ; обработчик прерывания ВУ-2
v1: WORD $int2, 0x180 ; обработчик прерывания ВУ-3

org 0x01F
X: WORD ?

max: WORD 0x0019 ; максимальное значение X
min: WORD 0xFFE6 ; минимальное значение X

start:
    DI
    LD #0x08 ; загрузка в аккумулятор 1000|0000 = 1000 (вектор 0)
    OUT 0x05 ; установка MR для ВУ-2
    LD #0x09 ; загрузка в аккумулятор 1000|0001 = 1001 (вектор 1)
    OUT 0x07 ; установка MR для ВУ-3
    EI

prog:
    DI ; для атомарности
    LD X
    ADD #3
    CALL check
    ST X
    EI
    JUMP prog

int1: ; обработка прерывания на ВУ-2
    NOP ; сейчас в аккумуляторе X
    IN 0x04 ; читаем данные из ВУ-2
    SUB X ; вычитаем X
    CALL check ; проверяем перед сохранением
    ST X ; сохраняем X
    NOP ; в аккумуляторе новый результат
    IRET

int2: ; обработка прерывания на ВУ-3
    LD X ; загружаем значение X
    NOP
    ASL
    ASL
    ADD X
    ADD #2 ; 2*2*x+x+2 = 5x+2
    NOP
    OUT 0x06 ; вывод на ВУ-3
    IRET

check: ; проверка на ОДЗ
    check_min:
        CMP min
        BGE check_max ; если x >= min, то проверка верхней границы
        JUMP ret_min ; иначе в аккумулятор min
    check_max:
        CMP max
        BLT ret_cur ; если x < max, то все в порядке
        BEQ ret_cur ; если x = max, то все в порядке
    ret_min:
        LD min
    ret_cur:
        RET    