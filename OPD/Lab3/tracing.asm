org 0x5d8

first: WORD $x1 ; адрес первого элемента
current: WORD 0xE000 ; адрес текущего элемента, перебор начинается с последнего
size: WORD 0x0200 ; размер массива
res: WORD 0xE000 ; результат

start: LD #0x80
DEC
SWAB
ST res
LD #0x08
ST size
ADD first
ST current
for_start: LD -(current) ; начало перебора предекрементом с конца массива
BEQ iter
CMP res
BGE iter
ST res
iter: LOOP size ; итерация
JUMP for_start
HLT
x1: WORD 0xFFC8 ; -56
x2: WORD 0x0008 ; 8
x3: WORD 0x0000 ; 0
x4: WORD 0xFFE9 ; -23
x5: WORD 0x0000 ; 0
x6: WORD 0xFFF9 ; -7
x7: WORD 0xFFC8 ; -56
x8: WORD 0x0008 ; 8
