    .data

.org             0x88

input_addr:      .word  0x80
output_addr:     .word  0x84

len:             .word  0
pointer:         .word  0
current_char:    .word  0
buffer_size:     .word  0x20

const_1:         .word  1
const_under:     .word  0x5F
const_a:         .word  97
const_z:         .word  122
const_case:      .word  32
const_endline:   .word  10
const_overflow:  .word  0xCCCCCCCC

mask_char:       .word  0x5F5F5F00
mask_len:        .word  0xFFFFFF00
mask_ff:         .word  0xFF

    .text

_start:

fill_buffer:
    load         const_under
    store_ind    pointer

    load         pointer
    add          const_1
    store        pointer

    sub          buffer_size
    bltz         fill_buffer

read_input:
    load_imm     1
    store        pointer

read_char:
    load         input_addr
    load_acc
    store        current_char

    sub          const_endline
    beqz         read_end

    load         len
    add          const_1
    store        len
    sub          buffer_size
    bgez         buffer_overlow

check_char_a:
    load         current_char
    sub          const_a
    bltz         store_char

check_char_z:
    load         current_char
    sub          const_z
    bgtz         store_char

upper_char:
    load         current_char
    sub          const_case
    store        current_char

store_char:
    load         current_char
    or           mask_char
    store_ind    pointer

    load         pointer
    add          const_1
    store        pointer

    jmp          read_char

read_end:
    load_imm     0
    store        pointer
    load         pointer
    load_acc
    and          mask_len
    add          len
    store_ind    pointer

print_res:
    load         len
    beqz         hlt

    load_imm     1
    store        pointer

print_loop:
    load_acc
    and          mask_ff
    store_ind    output_addr

    load         len
    sub          const_1
    store        len
    beqz         hlt

    load         pointer
    add          const_1
    store        pointer
    jmp          print_loop

buffer_overlow:
    load         const_overflow
    store_ind    output_addr

hlt:
    halt
