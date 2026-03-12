; максимум из трех чисел

start:
    CLA
    CALL $max
    a: WORD 0x0000
    b: WORD 0x8000
    c: WORD 0x7FFF
    res: WORD 0x0000
    HLT

max:
    LD (SP+0)
    ST msp

    LD (msp)+
    ST addr_a
    LD (msp)+
    ST addr_b
    LD (msp)+
    ST addr_c
    LD (msp)
    ST addr_res

    LD addr_a
    CMP addr_b
    BGE a_or_c

    b_or_c: LD addr_b
    CMP addr_c
    BLT return_c
    ST addr_res ; сохранили b

    return_c: LD addr_c
    ST addr_res ; сохранили c

    a_or_c: CMP addr_c
    BLT return_c
    ST addr_res ; сохранили a

    LD addr_res
    ST (addr_res)

    RET

    msp: WORD 0x0000 ; ячейка для вершины стека
    addr_a: WORD 0x0000 ; адрес операнда a
    addr_b: WORD 0x0000 ; адрес операнда b
    addr_c: WORD 0x0000 ; адрес операнда c
    addr_res: WORD 0x8000 ; адрес результата
