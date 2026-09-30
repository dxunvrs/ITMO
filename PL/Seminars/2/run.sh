nasm -g -felf64 -o $1.o $1.asm
ld -o $1 $1.o
./$1

rm -rf $1.o
rm -rf $1
