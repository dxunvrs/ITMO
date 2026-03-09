org 0x11b

start:
    CLA
    ST res
    LD X
    PUSH
    CALL $f
    POP
    SUB res
    ST res
    LD Y
    DEC
    PUSH
    CALL $f
    POP
    INC
    ADD res
    ST res
    LD Z
    PUSH
    CALL $f
    POP
    SUB res
    ST res
    HLT

Z: WORD 0x0000
Y: WORD 0x0000
X: WORD 0x0000
res: WORD 0x00C9

org 0x74b

f:
    LD &1
    BEQ zero
    BPL return_const
    zero: CMP A
    BLT return_const
    BEQ return_const
    ADD &1
    ADD &1
    ADD &1
    SUB B
    JUMP return
    return_const: LD A
    return: ST &1
    RET
    A: WORD 0xFDF7
    B: WORD 0x00C6