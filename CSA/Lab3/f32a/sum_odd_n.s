    .data
.org             0x88

input_addr:      .word  0x80
output_addr:     .word  0x84

err_input:       .word  -1
err_overflow:    .word  0xCCCCCCCC
multiply_steps:  .word  31

    .text

_start:
    @p input_addr
    a!
    @p output_addr
    b!

    @

    dup if err
    dup -if calc

err:
    @p err_input
    !b
    halt

calc:
    1 +
    2/                       \ на стеке (n+1)/2

    dup
    a!
    0

    multiply                 \ умножение (n+1)/2 на (n+1)/2
    dup if check_sign        \ проверка T
    overflow ;

check_sign:
    a
    dup -if print            \ проверка A
    overflow ;

print:
    !b
    halt

overflow:
    @p err_overflow
    !b
    halt

multiply:
    @p multiply_steps
    >r

multiply_loop:
    +*
    next multiply_loop
    ;
