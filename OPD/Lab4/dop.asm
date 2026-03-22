; максимум из трех чисел

start:
    CLA

    CALL $max
    x1: WORD 0x0000
    x2: WORD 0x8000
    x3: WORD 0x7FFF
    res1: WORD 0x0000

    CALL $max
    y1: WORD 0x0100
    y2: WORD 0x1100
    y3: WORD 0xA010
    res2: WORD 0x0000

    HLT

org 0x555

max: ; операнды копируем и передаем адрес результата
    LD (SP+0)
    ST ret_addr

    LD (ret_addr)+
    ST a
    LD (ret_addr)+
    ST b
    LD (ret_addr)+
    ST c
    
    LD ret_addr
    ST res_addr

    LD a
    CMP b
    BGE a_or_c

    b_or_c: LD b
    CMP c
    BLT return_c
    ST (res_addr) ; сохранили b
    JUMP return

    return_c: LD c
    ST (res_addr) ; сохранили c
    JUMP return

    a_or_c: CMP c ; сейчас в аккумуляторе a
    BLT return_c
    ST (res_addr) ; сохранили a

    return: 
        LD ret_addr ; сейчас на адресе результата
        INC ; чтобы продолжить выполнение
        ST (SP+0) ; адрес возврата - ячейка после результата

        RET

    ret_addr: WORD 0x0000 ; ячейка для вершины стека
    a: WORD 0x0000 ; первый операнд
    b: WORD 0x0000 ; второй операнд
    c: WORD 0x0000 ; третий операнд
    res_addr: WORD 0x0000 ; адрес результата
