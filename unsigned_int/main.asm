format ELF64
public _start

section '.bss' writable
    bss_char rb 1

section '.text' executable
_start:
    mov rax, 234
    push rax
    call print_number
    mov rax, '*'
    call print_char
    mov rax, 548
    push rax
    call print_number
    mov rax, '='
    call print_char
    pop rax
    pop rbx
    mul rbx
    call print_number 
    call print_line
    call exit

section '.print_char' executable
; | input:
; rax = char
print_char:
    push rax
    push rbx
    push rcx
    push rdx

    mov [bss_char], al

    mov rax, 4
    mov rbx, 1
    mov rcx, bss_char
    mov rdx, 1
    int 0x80

    pop rdx
    pop rcx
    pop rbx
    pop rax

    ret

section '.print_number' executable
; | input
; rax = number
; 571 / 10 = 57 | 1 + '0' => push in stack
; 57 / 10 = 5   | 7 + '0' => push in stack
; 5 / 10 = 0    | 5 + '0' => push in stack
print_number:
    push rax
    push rbx
    push rcx
    push rdx
    xor rcx, rcx ; counter
    .next_iter:
        cmp rax, 0
        je .print_iter
        mov rbx, 10
        xor rdx, rdx
        div rbx ; rax / rbx = rax | % = rdx
        add rdx, '0'
        push rdx
        inc rcx
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
    inc eax
    xor rbx, rbx
    int 0x80
