format ELF64
public _start

section '.data' writable
    strnum db "571223453643456", 0
    _buffer.size equ 20

section '.bss' writable
    _buffer rb _buffer.size
    _bss_char rb 1

section '.text' executable
_start:
    mov rax, strnum
    call string_to_number
    call print_number

    mov rax, 5725532423424
    mov rbx, _buffer
    mov rcx, _buffer.size
    call number_to_string
    call print_string
    call exit

section '.print_string' executable
; | input:
; rax = string
; rcx = lenght string
print_string:
    push rax
    push rbx
    push rcx
    push rdx

    mov rax, 4
    mov rbx, 1
    mov rcx, _buffer
    mov rdx, rcx
    int 0x80

    pop rdx
    pop rcx
    pop rbx
    pop rax
    ret

section '.print_char' executable
; | input
; rax = char
print_char:
    push rdx
    push rcx
    push rbx
    push rax

    mov [_bss_char], al

    mov rax, 4
    mov rbx, 1
    mov rcx, _bss_char
    mov rdx, 1
    int 0x80

    pop rax
    pop rbx
    pop rcx
    pop rdx
    ret

section '.string_to_number' executable
;
; "571", 0
; "5" - "0" == 0
; "7" - "0" == 0
; "1" - "0" == 0
;
; 1*1 + 7*10 + 5*100 = 571
;
; | input
; rax = string
; | output
; rax = number
string_to_number:
    push rbx
    push rcx
    push rdx
    xor rbx, rbx
    xor rcx, rcx
    .next_iter:
        cmp [rax+rbx], byte 0
        je .next_step
        mov cl, [rax+rbx]
        sub cl, '0' ; cl - '0' => rcx
        push rcx
        inc rbx
        jmp .next_iter
    .next_step:
        mov rcx, 1
        xor rax, rax
    .to_number:
        cmp rbx, 0
        je .close
        pop rdx
        imul rdx, rcx
        imul rcx, 10
        add rax, rdx
        dec rbx
        jmp .to_number
    .close:
        pop rdx
        pop rcx
        pop rbx
        ret

section '.number_to_string' executable
; | input
; rax = number
; rbx = _buffer
; rcx = _buffer.size
; 571 / 10 = 57 | 1 + '0' => push in stack
; 57 / 10 = 5   | 7 + '0' => push in stack
; 5 / 10 = 0    | 5 + '0' => push in stack
number_to_string:
    push rax
    push rbx
    push rcx
    push rdx
    push rsi
    mov rsi, rcx
    dec rsi
    xor rcx, rcx ; counter
    .next_iter:
        push rbx
        mov rbx, 10
        xor rdx, rdx
        div rbx ; rax / rbx = rax | % = rdx
        pop rbx
        add rdx, '0'
        push rdx
        inc rcx
        cmp rax, 0
        je .next_step
        jmp .next_iter
    .next_step:
        mov rdx, rcx
        xor rcx, rcx
    .to_string:
        cmp rcx, rsi
        je .pop_iter
        cmp rcx, rdx
        je .null_char
        pop rax
        mov [rbx+rcx], rax
        inc rcx
        jmp .to_string
    .pop_iter:
        cmp rcx, rdx
        je .close
        pop rax
        inc rcx
        jmp .pop_iter
    .null_char:
        mov rdx, rsi
    .close:
        mov [rbx+rsi], byte 0 
        pop rsi
        pop rdx
        pop rcx
        pop rbx
        pop rax
        ret

section '.print_number' executable
; | input:
; rax = number
print_number:
    push rax
    push rbx
    push rcx
    push rdx
    xor rcx, rcx
    .next_iter:
        mov rbx, 10
        xor rdx, rdx
        div rbx
        add rdx, '0'
        push rdx
        inc rcx
        cmp rax, 0
        je .print_iter
        jmp .next_iter
    .print_iter:
        cmp rcx, 0
        je .close
        pop rax
        call print_char
        dec rcx
        jmp .print_iter
    .close:
        pop rdx
        pop rcx
        pop rbx
        pop rax
        call print_line
        ret

section '.print_line' executable
; newline
print_line:
    push rax
    mov rax, 0xA
    call print_char
    pop rax
    ret

section '.exit' executable
exit:
    xor rax, rax
    inc rax
    xor rbx, rbx
    int 0x80
