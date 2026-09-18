    .text
    .org 0x88

_start:
    @p 0x80

    dup if err
    dup -if calc

err:
    -1 !p 0x84
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
    !p 0x84
    halt

overflow:
    0xCCCCCCCC
    !p 0x84
    halt

multiply:
    31 >r

multiply_loop:
    +*
    next multiply_loop
    ;
