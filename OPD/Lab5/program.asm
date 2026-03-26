org 0x5BE

string_start: WORD $string ; начало строки
current: WORD ? ; указатель на текущие два символа
stop: WORD 0x00 ; стоп-символ

start: 
    CLA
    LD string_start
    ST current

s1:
    CLA
    IN 0x07 ; ожидание ввода первого символа
    AND #0x40 ; проверка 6 бита SR 
    BEQ s1 ; если ВУ-3 не готово, то спин-луп

    IN 0x06
    ST (current) ; читаем и сохраняем
    CMP stop
    BEQ prog_hlt ; если стоп-символ, то на выход

s2:
    CLA
    IN 0x07 ; ожидание ввода второго символа
    AND #0x40 ; проверка 6 бита SR
    BEQ s2 ; если ВУ-3 не готово, то спин-луп
    
    IN 0x06

    SWAB ; перемещаем символ в старший байт
    OR (current) ; совмещаем с предыдущим символом
    ST (current)+ ; сохраняем и перемещаем указатель
    
    SWAB ; возвращаем в младший байт для проверки на стоп-символ
    SXTB ; для корректности сравнения
    CMP stop
    BEQ prog_hlt ; если стоп-символ, то на выход

    JUMP s1 ; продолжаем ввод

prog_hlt:
    HLT

org 0x5E5
string: WORD ?