    .data
.org             0x88

input_addr:      .word  0x80
output_addr:     .word  0x84

buffer_size:     .word  64
buffer_max_len:  .word  63

const_underline: .word  0x5F5F5F5F
const_endline:   .word  10
const_digit_0:   .word  48
const_digit_max: .word  8
const_word_step: .word  4

err_input:       .word  -1
err_overflow:    .word  0xCCCCCCCC

    .text

; мышь бегает и заполняет буфер нижними подчеркиваниями
init_buffer:
    .frame () $idx, $under, $step, $sz
    locals.reserve 4
    i32.const const_underline i32.load local.set $under
    i32.const const_word_step i32.load local.set $step
    i32.const buffer_size i32.load local.set $sz
    i32.const 0 local.set $idx
    loop
        local.get $idx
        local.get $under
        i32.store

        local.get $idx
        local.get $step
        i32.add
        local.tee $idx
        local.get $sz
        i32.lt_s
        br_if 0
    end
    return

; мышь сбрасывает оставшиеся символы после ошибки
flush_input:
    .frame ($ch) $endl, $in_port
    locals.reserve 2
    i32.const const_endline i32.load local.set $endl
    i32.const input_addr i32.load local.set $in_port
    loop
        local.get $ch
        local.get $endl
        i32.eq
        if
            return
        end

        local.get $in_port
        i32.load
        local.set $ch
        br 0
    end
    return

; мышь выводит символы из буфера
print_buffer:
    .frame ($len) $idx, $out_port
    locals.reserve 2
    local.get $len
    i32.eqz
    if
        return
    end

    i32.const output_addr i32.load local.set $out_port
    i32.const 0 local.set $idx
    loop
        local.get $out_port
        local.get $idx
        i32.load8_u
        i32.store8

        local.get $idx
        i32.const 1
        i32.add
        local.tee $idx
        local.get $len
        i32.lt_s
        br_if 0
    end
    return

; мышь наказывает за ошибки
handle_error:
    .frame ($last_char, $err_code)
    local.get $last_char
    i32.const flush_input
    call 1, 0

    i32.const output_addr i32.load
    local.get $err_code
    i32.store
    return

; точка входа
_start:
    .frame () $out_idx, $char, $count, $in_port, $endl, $digit_0, $digit_max, $max_len
    locals.reserve 8

    ; загрузка констант
    i32.const input_addr i32.load local.set $in_port
    i32.const const_endline i32.load local.set $endl
    i32.const const_digit_0 i32.load local.set $digit_0
    i32.const const_digit_max i32.load local.set $digit_max
    i32.const buffer_max_len i32.load local.set $max_len

    ; инициализация буфера символом '_' (0x5F)
    i32.const init_buffer
    call 0, 0

    i32.const 0
    local.set $out_idx

    block
        loop
            ; чтение символа счетчика
            local.get $in_port
            i32.load
            local.tee $char
            local.get $endl
            i32.eq
            if
                ; ставим нуль-терминатор в конец строки
                local.get $out_idx
                i32.const 0
                i32.store8

                ; выводим распакованную строку
                local.get $out_idx
                i32.const print_buffer
                call 1, 0

                br 1
            end

            ; валидация счетчика: проверяем, что символ является цифрой
            ; вычисляем $count = $char - $digit_0, затем проверяем ($count - 1) <=_u $digit_max.
            local.get $char
            local.get $digit_0
            i32.sub
            local.tee $count
            i32.const 1
            i32.sub
            local.get $digit_max
            i32.gt_u
            if
                local.get $char
                i32.const err_input i32.load
                i32.const handle_error
                call 2, 0

                br 1
            end

            ; чтение повторяемого символа
            local.get $in_port
            i32.load
            local.tee $char
            local.get $endl
            i32.eq
            if
                ; если встречаем перенос строки, то ошибка
                local.get $char
                i32.const err_input i32.load
                i32.const handle_error
                call 2, 0

                br 1
            end

            ; проверка переполнения буфера: $out_idx + $count > 63
            local.get $out_idx
            local.get $count
            i32.add
            local.get $max_len
            i32.gt_s
            if
                local.get $char
                i32.const err_overflow i32.load
                i32.const handle_error
                call 2, 0

                br 1
            end

            ; запись символа $char в буфер $count раз
            loop
                local.get $out_idx
                local.get $char
                i32.store8

                local.get $out_idx
                i32.const 1
                i32.add
                local.set $out_idx

                local.get $count
                i32.const 1
                i32.sub
                local.tee $count
                br_if 0
            end

            br 0
        end
    end

    halt
