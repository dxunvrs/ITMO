org 0x02B8

res: WORD ?

; команда FCXX - переход, если в аккумуляторе нечетное число

start:

test_even:
    LD #0x66 ; 0000 0000 0110 0110 - четное
    WORD 0xFC03 ; не должно отработать
    LD #1
    ST res
    JUMP test_odd

set_0: ; зануляем ячейку
    LD #0
    ST res

test_odd:
    LD #0x77 ; 0000 0000 0111 0111 - нечетное
    WORD 0xFC03 ; должен сработать переход
    LD #0 ; зануляем, если не сработало
    ST res
    JUMP test_hlt

set_1: ; все в порядке, делаем И с текущим результатом
    LD #1
    AND res
    ST res

test_hlt:
    HLT