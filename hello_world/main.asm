format ELF64
public _start

endl equ 0xA

msg db "Hello World", endl, 0

_start:
	mov rax, msg
	call print_str
	call exit

;| input
; rax = string
;| output
; rax = lenght
get_lenght:
	push rdx
	xor rdx, rdx
	.next_iter:
		cmp [rax+rdx], byte 0
		je .close
		inc rdx
		jmp .next_iter
	.close:
		mov rax, rdx
		pop rdx
 		ret

;| input
; rax = string
print_str:
	push rax
	push rbx
	push rcx
	push rdx
	mov rcx, rax
	call get_lenght
	mov rdx, rax
	mov rax, 4
	xor rbx, rbx
	inc rbx
	int 0x80
	pop rdx
	pop rcx
	pop rbx
	pop rax
	ret

exit:
	xor rax, rax
	inc rax
	mov rbx, 0
	int 0x80
