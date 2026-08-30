; модификация для двумерного массива
org 0x5d8

first: WORD $x1 
current: WORD 0x0000 ; адрес текущего элемента
rows: WORD 0x0002 ; кол-во строк
cols: WORD 0x0003 ; кол-во столбцов
res: WORD 0x0000 ; результат

row_counter: WORD 0x0000 ; счетчик для строк
column_counter: WORD 0x0000 ; счетчик для столбцов
row_start: WORD 0x0000 ; адрес начала текущей строки

start:
    LD #0x80
    DEC
    SWAB
    ST res

    LD first
    ST row_start ; начинаем с начала

    LD rows
    ST row_counter ; устанавливаем счетчик строк

row_loop: ; внешний цикл для строк
    LD cols
    ST column_counter

    LD row_start
    ST current

column_loop: ; внутренний цикл для столбцов

    LD (current)+

    BEQ column_iter
    CMP res
    BGE column_iter
    ST res

column_iter: ; если столбцы закончились -> следующая строка
    LOOP column_counter
    JUMP column_loop

row_iter: ; если строки закончились -> массив пройден
    LD row_start
    ADD cols
    ST row_start

    LOOP row_counter
    JUMP row_loop

HLT

x1: WORD 0x0000
x2: WORD 0x0001
x3: WORD 0x7345

y1: WORD 0x3333
y2: WORD 0xAAAA
y3: WORD 0xFFFF