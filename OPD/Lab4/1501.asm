org 0x0eb

start:
    CLA
    ST res
    LD Z
    PUSH
    CALL $f
    POP
    ADD res
    ST res
    LD Y
    PUSH
    CALL $f
    POP
    DEC
    ADD res
    ST res
    LD X
    INC
    PUSH
    CALL $f
    POP
    ADD res
    ST res
    HLT

Z: WORD 0x0000
Y: WORD 0x0000
X: WORD 0x0000
res: WORD 0x9D9

org 0x676

f:
    LD &1
    BMI return_const
    BEQ return_const
    CMP A
    BGE return_const
    ADD &1
    ADD &1
    ADD &1
    SUB B
    JUMP return
    return_const: LD A
    return: ST &1
    RET
A: WORD 0x0566
B: WORD 0x00F6