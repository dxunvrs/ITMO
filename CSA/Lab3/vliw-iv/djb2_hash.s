    .data

.org             0x88

input_addr:      .word  0x80
output_addr:     .word  0x84

hash_start:      .word  5381

    .text

_start:
    ; t0 - 0x80
    ; t1 - 0x84
    ; t2 - 5
    ; a0 - res

    lui t0, %hi(input_addr)        / lui t1, %hi(output_addr)       / nop          / nop
    addi t0, t0, %lo(input_addr)   / addi t1, t1, %lo(output_addr)  / nop          / nop

    lui t3, %hi(hash_start)        / addi t2, zero, 5               / lw t0, 0(t0) / nop
    addi t3, t3, %lo(hash_start)   / nop                            / lw t1, 0(t1) / nop

    nop                            / nop                            / lw a0, 0(t3) / nop

loop:
    nop                            / nop                            / lw t4, 0(t0) / beqz t4, end
    sll a0, a0, t2                 / add t4, t4, a0                 / nop          / nop
    add a0, a0, t4                 / nop                            / nop          / j loop

end:
    nop                            / nop                            / sw a0, 0(t1) / halt
