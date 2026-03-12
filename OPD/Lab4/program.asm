org 0x297

start:
    CLA
    ST res

    LD X
    PUSH 
    CALL $f
    POP

    SUB res
    ST res

    LD Z
    PUSH
    CALL $f
    POP
    DEC

    SUB res
    ST res

    LD Y
    PUSH
    CALL $f
    POP

    SUB res
    ST res

    HLT
Z: WORD 0x0000
Y: WORD 0x0000
X: WORD 0x0000
res: WORD 0x008E

org 0x689

f:  
    LD &1
    BMI return_const
    CMP A
    BGE return_const
    ASL
    ADD B
    JUMP return
    return_const: LD A
    return: ST &1
    RET
A: WORD 0x01B4
B: WORD 0x008D