org 0x5d8

first: WORD 0x05EC ; адрес первого элемента
current: WORD 0xE000 ; адрес текущего элемента, перебор начинается с последнего
size: WORD 0x0200 ; размер массива
res: WORD 0xE000 ; результат

start: LD #0x80
DEC
SWAB
ST res
LD #0x03
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
x1: WORD 0x0000
x2: WORD 0xF400
x3: WORD 0x0000
