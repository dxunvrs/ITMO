    .data

.org             0x88

input_addr:      .word  0x80
output_addr:     .word  0x84

stack_top:       .word  0x1000             ; начнем стек отсюда
word_bits:       .word  32                 ; длина машинного слова
shift_mask:      .word  0x1F               ; маска для n

    .text

_start:

    lui      t0, %hi(stack_top)
    addi     t0, t0, %lo(stack_top)
    lw       sp, 0(t0)                       ; sp = 0x1000

    lui      t0, %hi(input_addr)
    addi     t0, t0, %lo(input_addr)
    lw       t0, 0(t0)                       ; t0 = 0x80

    lw       a0, 0(t0)                       ; a0 = val
    lw       a1, 0(t0)                       ; a1 = n

    jal      ra, rotate_right

    lui      t1, %hi(output_addr)
    addi     t1, t1, %lo(output_addr)
    lw       t1, 0(t1)                       ; t1 = 0x84

    sw       a0, 0(t1)

    halt

get_shift_mask:
    lui      t0, %hi(shift_mask)
    addi     t0, t0, %lo(shift_mask)
    lw       t0, 0(t0)                       ; t0 = 0x1F

    and      a0, a0, t0                      ; накладываем маску, берем сдвиг по модулю 32
    jr       ra

rotate_right:
    addi     sp, sp, -12                     ; выделяем место на стеке

    ; callee-saved регистры
    sw       ra, 8(sp)
    sw       s1, 4(sp)
    sw       s2, 0(sp)

    mv       s1, a0                          ; s1 = val

    mv       a0, a1                          ; a0 = n
    jal      ra, get_shift_mask
    mv       s2, a0                          ; s2 = сдвиг

    beqz     s2, rotate_end                  ; если сдвиг 0, сразу на выход

    ; чтобы сдвинуть число вправо по циклу нужно сделать:
    ; (val >> n) || (val << (32 - n))
    ; первый сдвиг оставит младшие биты, а второй вернет старшие

    srl      t0, s1, s2                      ; t0 = val >> n

    lui      t1, %hi(word_bits)
    addi     t1, t1, %lo(word_bits)
    lw       t1, 0(t1)                       ; t1 = 32
    sub      t1, t1, s2                      ; t1 = 32 - n

    sll      t2, s1, t1                      ; t2 = val << (32 - n)

    or       s1, t0, t2                      ; получаем результат

rotate_end:
    mv       a0, s1                          ; ответ в a0

    ; восстанвливаем регистры и стек
    lw       s2, 0(sp)
    lw       s1, 4(sp)
    lw       ra, 8(sp)
    addi     sp, sp, 12

    jr       ra
